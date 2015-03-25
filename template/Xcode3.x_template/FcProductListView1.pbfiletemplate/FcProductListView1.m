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
@interface FcProductListView1 (PrivateMethods)
-(void)buttonSelectedAction:(id)sender;
-(void)fillData:(FcProductButtonView1*)productButton;

@end

@implementation FcProductListView1
@synthesize dataSource
#pragma mark Developer Override

-(void)buttonSelectedAction:(id)sender{
	//Fill your data here!
	//Using FoxconnQuery Library to query data and fetch them.
	FcProductDetailView1 *selectedProduct=[FcProductDetailView1 new];
	[self.view.superview.superview addSubview:selectedProduct.view];
	UIButton *btn=(UIButton*)sender;
}
-(void)fillData:(FcProductButtonView1*)productButton withQueryPatten:(QueryPattern*)queryPattern{
	/*You have to fill these fields below:
	 productButton.actionButton.title as the product's id for next querying step.
	 productButton.price
	 productButton.picture
	 productButton.name
	 */
}
#pragma mark -

#pragma mark LifeCycle
//You should not modify these methods below until you know what you are doing!!
-(id)initWithProductNumber:(NSInteger)number withStartIndex:(NSInteger)index{
	self=[super init];
	startIndexInQueryPattern=index;
	if(self!=nil){
		//startPoint 14,33
		//picSize 128x178
		//space 15x9
		CGPoint buttonLocation []= {
			CGPointMake(14,33),CGPointMake(157,33),CGPointMake(300,33),CGPointMake(443,33),CGPointMake(586,33),
			CGPointMake(14,228),CGPointMake(157,228),CGPointMake(300,228),CGPointMake(443,228),CGPointMake(586,228),
			CGPointMake(14,416),CGPointMake(157,416),CGPointMake(300,416),CGPointMake(443,416),CGPointMake(586,416),
			CGPointMake(14,604),CGPointMake(157,604),CGPointMake(300,604),CGPointMake(443,604),CGPointMake(586,604)
		};
		[self.view setUserInteractionEnabled:YES];
		for(int i=0;i<number;i++){
			CGPoint loc=buttonLocation[i];
			FcProductButtonView1 *buttonView=[FcProductButtonView1 new];
			[buttonView.view setFrame:CGRectMake(loc.x, loc.y, 128, 178)];
			[buttonView.actionButton addTarget:self action:@selector(buttonSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:buttonView.view];
			[self fillData:buttonView];
			startIndexInQueryPattern++;
			//[buttonView release];
			//TODO:memory issue!
		}
	}
	return self;
}

- (void)dealloc {
    [super dealloc];
}
#pragma mark -

@end
