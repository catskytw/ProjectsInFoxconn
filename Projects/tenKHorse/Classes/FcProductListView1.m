    //
//  ProductListView.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcProductListView1.h"
#import "FcProductButtonView1.h"
#import "FcProductDetailView1.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "Tools.h"
#import "TUNinePatchCache.h"
@interface FcProductListView1 (PrivateMethods)
-(void)buttonSelectedAction:(id)sender;
-(void)buttonSelectedCompareAction:(id)sender;
-(void)fillData:(FcProductButtonView1*)productButton;
-(void)addLabel:(NSString*)labelString withUiComponent:(id)uiComponent;
@end

@implementation FcProductListView1
@synthesize dataSource;
#pragma mark Developer Override
-(void)buttonSelectedCompareAction:(id)sender{
    /**
     1.show frame image
     2.set notification for adding information into compare panel
     */
    UIButton *thisBtn=(UIButton*)sender;
    NSString *productId=[NSString stringWithString: thisBtn.titleLabel.text];
    
    FcProductButtonView1 *thisView;
    for(FcProductButtonView1 *buttonView in buttonViews){
        NSLog(@"id:%@", buttonView.actionButton.titleLabel.text);
        if([buttonView.actionButton.titleLabel.text isEqualToString:productId]){
            thisView=buttonView;
            break;
        }
    }
    //TODO
    NSMutableDictionary *dataDic=[NSMutableDictionary dictionary];
    [dataDic setValue:productId forKey:@"ProductId"];
    [dataDic setValue:thisView forKey:@"FcProductButtonView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:AddProductCompare object:nil userInfo:dataDic];
}
-(void)buttonSelectedAction:(id)sender{
	FcProductDetailView1 *selectedProduct=[[FcProductDetailView1 alloc]init];
	[self.view.superview.superview addSubview:selectedProduct.view];
    
	UIButton *btn=(UIButton*)sender;
    [selectedProduct loadProductInfo:btn.titleLabel.text];
    [selectedProduct tuneLayout];
}
-(void)fillData:(FcProductButtonView1*)productButton{
	/*You have to fill these fields below:
	 productButton.actionButton.title as the product's id for next querying step.
	 productButton.price
	 productButton.picture
	 productButton.name
	 */
	QueryPattern *queryPattern=(QueryPattern*)dataSource;
	if(queryPattern!=nil){
		[queryPattern valueBinding:productButton.actionButton.titleLabel withKey:@"id" withIndexArray:startIndexInQueryPattern];
		[queryPattern valueBinding:productButton.name withKey:@"name" withIndexArray:startIndexInQueryPattern];
		//[queryPattern valueBinding:productButton.price withKey:@"price" withIndexArray:startIndexInQueryPattern];
        [productButton.price setText:[Tools formatMoneyString:[queryPattern getValue:@"retailPrice" withIndex:startIndexInQueryPattern]]];
        
		NSString *picFileName=[queryPattern getValue:@"image110" withIndex:startIndexInQueryPattern];
        [queryPattern valueBinding:productButton.brand withKey:@"brand" withIndexArray:startIndexInQueryPattern];
        [queryPattern uiValueBinding:productButton.picture withValue:picUrl(picFileName)];
        [productButton tuneLayout];
		//[queryPattern valueBinding:productButton.picture withKey:@"image110" withIndexArray:startIndexInQueryPattern];
#ifdef TEST_DATA
		[productButton.picture setImage:[UIImage imageNamed:@"casico_pillow_110X110.png"]];
#endif 
	}
}
-(void)addLabel:(NSString*)labelString withUiComponent:(id)uiComponent{
	int ySpace=15;
	UILabel *thisLabel=[[UILabel alloc]initWithFrame:CGRectZero]; 
    [thisLabel setBackgroundColor:[UIColor clearColor]];
	[thisLabel setNumberOfLines:0];
	[thisLabel setFont:[UIFont fontWithName:DefaultFontName size:17.0]];
	[thisLabel setTextColor:[UIColor blackColor]];
	[thisLabel setText:labelString];
	CGSize maxSize=CGSizeMake(466, 20000);
	CGSize labelSize=[Tools estimateStringSize:labelString withFontSize:17.0 withMaxSize:maxSize];
	[thisLabel setFrame:CGRectMake(0, startYPosition, labelSize.width, labelSize.height)];
	startYPosition+=(labelSize.height+ySpace);
	UIView *targetView=(UIView*)uiComponent;
	[targetView addSubview:thisLabel];
	[thisLabel release];
}
#pragma mark -

#pragma mark LifeCycle
//You should not modify these methods below until you know what you are doing!!
-(id)initWithProductNumber:(NSInteger)number withStartIndex:(NSInteger)index isCompareMode:(BOOL)compareMode withDataSource:(id)inputDataSource{
	self=[super init];
    buttonViews=[[NSMutableArray arrayWithObjects:nil]retain];
	startIndexInQueryPattern=index;
	dataSource=inputDataSource;
	if(self!=nil){
		//startPoint 14,33
		//picSize 128x178
		//space 15x9
		CGPoint buttonLocation []= {
			CGPointMake(14,0),CGPointMake(157,0),CGPointMake(300,0),CGPointMake(443,0),CGPointMake(586,0),
			CGPointMake(14,187),CGPointMake(157,187),CGPointMake(300,187),CGPointMake(443,187),CGPointMake(586,187),
			CGPointMake(14,374),CGPointMake(157,374),CGPointMake(300,374),CGPointMake(443,374),CGPointMake(586,374),
			CGPointMake(14,561),CGPointMake(157,561),CGPointMake(300,561),CGPointMake(443,561),CGPointMake(586,561),
            CGPointMake(14,748),CGPointMake(157,748),CGPointMake(300,748),CGPointMake(443,748),CGPointMake(586,748),
            CGPointMake(14,935),CGPointMake(157,935),CGPointMake(300,935),CGPointMake(443,935),CGPointMake(586,935)
		};
		[self.view setUserInteractionEnabled:YES];
		for(int i=0;i<number;i++){
			CGPoint loc=buttonLocation[i];
			FcProductButtonView1 *buttonView=[FcProductButtonView1 new];
			[buttonView.view setFrame:CGRectMake(loc.x, loc.y, 128, 178)];
            //依不同的模式(正常模式或是比較模式)來決定按鍵的動作
            (compareMode==YES)?[buttonView.actionButton addTarget:self action:@selector(buttonSelectedCompareAction:) forControlEvents:UIControlEventTouchUpInside]:
			[buttonView.actionButton addTarget:self action:@selector(buttonSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:buttonView.view];
			[self fillData:buttonView];
            [buttonViews addObject:buttonView];
			startIndexInQueryPattern++;
			[buttonView autorelease];
            //TODO buttonView has a memory-issue?
		}
	}
	return self;
}

- (void)dealloc {
    [buttonViews removeAllObjects];
    [buttonViews release];
    [super dealloc];
}
#pragma mark -

@end
