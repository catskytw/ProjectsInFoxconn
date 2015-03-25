//
//  ProductDetailView1.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcProductDetailView1.h"
#import "LocalizationSystem.h"
#import "Configure.h"
#import "Tools.h"
#import "QueryPattern.h"
#import "NinePatch.h"
#import "UIViewClearSubViews.h"
#import "FcTabUIComponent.h"
#import "BuyPopView.h"
#import "SignInObject.h"
#import "LoginView.h"
#import "FcPopWindows.h"
#import "QuerySQLProcess.h"
#import "NSString+extension.h"
#define MAXCOLORNUM 6
@interface FcProductDetailView1(PrivateMethod)
-(void)EnvelopSuit;
-(void)ratingBar:(CGFloat)ratingScore;
-(void)addLabel:(NSString*)labelString withUiComponent:(id)uiComponent;
-(void)addColorButton;
-(IBAction)reloadColorAction:(id)sender;
-(UIScrollView*)createContentScrollSubView:(NSInteger)index withTitle:(NSString*)title withContent:(NSString*)content;
-(void)createContentSubviews:(QueryPattern*)query;
#ifdef TEST_DATA
-(void)testData;
#endif
@end

@implementation FcProductDetailView1

@synthesize titleLabel,brand,productName,lowerPrice,upperPrice,contentLabel;
@synthesize priceStringUpperLacel,priceStringLowerLabel,ratingStringLabel,desStringLabel;
@synthesize titleBackground,productPicture,backgroundView;
@synthesize productPictureMinList;
@synthesize contentScrollView;
@synthesize closeBtn,shoppingBtn;
@synthesize ratingView,colorView;
@synthesize pageController;
@synthesize productId;
#pragma mark Developer Override
//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//setting multi-language.
    [backgroundView setImage:[UIImage imageNamed:@"cataloge_bg.png"]];
	[titleLabel setText:AMLocalizedString(@"ProductDetailInfo",nil)];
	[priceStringLowerLabel setText:AMLocalizedString(@"LowerPriceString",nil)];
	[priceStringUpperLabel setText:AMLocalizedString(@"UpperPriceString",nil)];
	[ratingStringLabel setText:AMLocalizedString(@"RatingString",nil)];
	[desStringLabel setText:AMLocalizedString(@"ProductDescription",nil)];
	[closeBtn.titleLabel setText:AMLocalizedString(@"Return",nil)];
	
    [desStringLabel setBackgroundColor:[UIColor clearColor]];
    [ratingView setBackgroundColor:[UIColor clearColor]];
	//setting theme-picture
	[titleBackground setImage:[UIImage imageNamed:@"content_ui_title_bar.png"]];
	//use 9-patch
	CGSize fontSize=[Tools estimateStringSize:closeBtn.titleLabel.text withFontSize:14.0];
	int width=(fontSize.width<63)?63:fontSize.width+10;
	int height=32;
	[closeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(width, height) forNinePatchNamed:@"button_normal"]
						forState:UIControlStateNormal];
	[closeBtn setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(width, height) forNinePatchNamed:@"button_active"]
						forState:UIControlStateHighlighted];
    pageController.imageNormal=[UIImage imageNamed:@"content_ui_page_off.png"];
	pageController.imageCurrent=[UIImage imageNamed:@"content_ui_page_on.png"];
}

#ifdef TEST_DATA
-(void)testData{
	QueryPattern *myQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
	//[myQuery uiValueBinding:productPicture withValue:@"http://10.62.13.32:8080/productimg_enlarge_notebook.jpg"];
	//[productPicture setImage:[UIImage imageNamed:@"casico_pillow_250x250.png"]];
	[brand setText:@"Fake Brand"];
	[self ratingBar:2.5];
}
#endif
#pragma mark -
#pragma mark LifeCycle
-(void)viewDidLoad{
	[super viewDidLoad];
    colorDic=[NSMutableDictionary new];
    contentViews=[NSMutableArray new];
    contentScrollView.delegate=self;
	[self EnvelopSuit];
	[self tuneLayout];
#ifdef TEST_DATA
	[self testData];
#endif
    pageControlUsed=YES;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    [contentViews release];
    [productId release];
    [colorDic removeAllObjects];
    [colorDic release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)loadProductInfo:(NSString*)sKey{
    //Fill your data here!
	//Using FoxconnQuery Library to query data and fetch them.
    startYPosition=0;
    productId=[[NSString stringWithString:sKey]retain];

    QueryPattern *detailQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
	//[detailQuery prepareDic:searchProductDetailInfo(sKey)];
    [detailQuery prepareDicWithDictionary:[QuerySQLProcess queryProductDetail:sKey]];
    NSLog(@"productKey:%@",sKey);
	[self.lowerPrice setText:[Tools formatMoneyString:[detailQuery getValue:@"retailPrice" withIndex:0]]];
	[self.upperPrice setText:[NSString stringWithFormat:@"%@ %@",[detailQuery getValue:@"retailPrice" withIndex:0],AMLocalizedString(@"coinName",nil)]];
	[detailQuery valueBinding:self.productName withKey:@"productName" withIndexArray:0];
	[detailQuery valueBinding:self.brand withKey:@"brand" withIndexArray:0];
	[self ratingBar:[[detailQuery getValue:@"score" withIndex:0]floatValue]];
	//add main productPic
	NSString *picFileName=[detailQuery getValueUnderNode:@"imageList" withKey:@"image250" withIndex:0];
	//[detailQuery uiValueBinding:self.productPicture withValue:picFileName];
    [productPicture setImage:[UIImage imageWithContentsOfFile:
                              [NSString stringWithFormat:@"%@/%@",[NSString documentPath],[NSString fetchFileName:picFileName]]]];
	
	//add button
	int imageCount=[detailQuery getNumberForKey:@"image46"];
	int xSpace=8;
	for(int i=0;i<imageCount;i++){
		QueryPattern *picQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
		UIButton *myPicButton=[[UIButton alloc]initWithFrame:CGRectMake(5+(xSpace+46)*i, 5, 46, 46)];
		NSString *picFileName=[detailQuery getValueUnderNode:@"imageList" withKey:@"image46" withIndex:i]; 
		//[picQuery uiValueBinding:myPicButton withValue:picUrl(picFileName)];
        [myPicButton setImage:
                     [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[NSString documentPath],[NSString fetchFileName:picFileName]]]
                     forState:UIControlStateNormal];
		[myPicButton.titleLabel setText:[detailQuery getValueUnderNode:@"imageList" withKey:@"image250" withIndex:i]];
		[myPicButton.titleLabel setTextColor:[UIColor clearColor]];
		[myPicButton addTarget:self action:@selector(changePicAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.productPictureMinList addSubview:myPicButton];
		
		[picQuery release];
		[myPicButton release];
	}
	[self.productPictureMinList setContentSize:CGSizeMake((xSpace+46)*imageCount, 56)];
    [self createContentSubviews:detailQuery];
    contentScrollView.contentSize=CGSizeMake(723*[contentViews count], 479);
    pageController.numberOfPages=[contentViews count];
    
    NSInteger colorCount=[detailQuery getNumberUnderNode:@"colorList" withKey:@"id"];
    colorCount=(colorCount>MAXCOLORNUM)?MAXCOLORNUM:colorCount;
    for(int i=0;i<colorCount;i++){
        NSString *colorKey=[detailQuery getValueUnderNode:@"colorList" withKey:@"color" withIndex:i];
        NSString *colorValue=[detailQuery getValueUnderNode:@"colorList" withKey:@"rgb" withIndex:i];
        [colorDic setValue:colorValue forKey:colorKey];
    }
    [self addColorButton];
	[detailQuery release];
}

-(void)addLabel:(NSString*)labelString withUiComponent:(id)uiComponent{
	int ySpace=15;
	UILabel *thisLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [thisLabel setBackgroundColor:[UIColor clearColor]];
	[thisLabel setNumberOfLines:0];
	[thisLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:17.0]];
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
- (void)dealloc {
    [super dealloc];
}
#pragma mark -
#pragma mark DelegateAction
-(IBAction)close:(id)sender{
	[self.view removeFromSuperview];
	[self release];
}
#pragma -
#pragma mark Unmutable Method
//人氣度的星星
-(void)ratingBar:(CGFloat)ratingScore{
    [ratingView clearSubViews];
	int xSpace=10;
	NSString *picName;
	for(int i=0;i<5;i++){
		if(ratingScore>=1)
			picName=@"content_ui_star_on.png";
		else if(ratingScore>0 && ratingScore<1){
			picName=@"content_ui_star_half.png";
		}else {
			picName=@"content_ui_star_off.png";
		}

		UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:picName]];
		//The rating ice must be 15x15
		[star setFrame:CGRectMake(i*(xSpace+15), 0, 15, 15)];
		[ratingView addSubview:star];
		[star release];
		ratingScore--;
	}
}
//增加顏色按鍵
-(void)addColorButton{
    [colorView clearSubViews];
    [colorView setBackgroundColor:[UIColor clearColor]];
    NSInteger startX=0, space=10, width=34, height=34;
    NSArray *allColorKeys=[colorDic allKeys];
    for(int i=0;i<[allColorKeys count];i++){
        UIButton *colorButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [colorButton setFrame:CGRectMake( startX+width*i+space*i,0,width,height)];
        [colorButton.titleLabel setTextColor:[UIColor clearColor]];
        [colorButton.titleLabel setText:(NSString*)[allColorKeys objectAtIndex:i]];
        UIColor *buttonColor=[Tools convertString2UIColor:(NSString*)[colorDic valueForKey:(NSString*)[allColorKeys objectAtIndex:i]]];
        [colorButton setBackgroundColor:buttonColor];
        [colorView addSubview:colorButton];
        [colorButton addTarget:self action:@selector(reloadColorAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(IBAction)reloadColorAction:(id)sender{
    FcProductDetailView1 *newProductDetail=[[FcProductDetailView1 alloc]init];
    [self.view.superview addSubview:newProductDetail.view];
    [newProductDetail loadProductInfo:((UIButton*)sender).titleLabel.text];
    
    [self.view removeFromSuperview];
	[self release];
}
-(void)changePicAction:(id)sender{
	UIButton *thisBtn=(UIButton*)sender;
    /*
	QueryPattern *query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
	[query uiValueBinding:productPicture withValue:picUrl(thisBtn.titleLabel.text)];
	[query release];
     */
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",[NSString documentPath],[NSString fetchFileName:thisBtn.titleLabel.text]];
    [productPicture setImage:[UIImage imageWithContentsOfFile:filePath]];
    NSLog(@"main pic: %@",filePath);
}
/*Tune layout. 'cause multi-language or defining different label-string by uses,
 probably screw the layout from template.
 */
-(void)tuneLayout{
	int space=5;
	CGSize upperPriceStringLabelSize=[Tools estimateStringSize:priceStringUpperLabel.text withFontSize:17];
	[priceStringUpperLabel setFrame:CGRectMake(priceStringUpperLabel.frame.origin.x, priceStringUpperLabel.frame.origin.y, upperPriceStringLabelSize.width, upperPriceStringLabelSize.height)];
	[upperPrice setFrame:CGRectMake(priceStringUpperLabel.frame.origin.x+priceStringUpperLabel.frame.size.width+space, upperPrice.frame.origin.y, upperPrice.frame.size.width, upperPrice.frame.size.height)];

	CGSize lowerPriceStringLabelSize=[Tools estimateStringSize:priceStringLowerLabel.text withFontSize:17];
	[priceStringLowerLabel setFrame:CGRectMake(priceStringLowerLabel.frame.origin.x, priceStringLowerLabel.frame.origin.y, lowerPriceStringLabelSize.width, lowerPriceStringLabelSize.height)];
	//[lowerPrice setFrame:CGRectMake(priceStringLowerLabel.frame.origin.x+priceStringLowerLabel.frame.size.width+space, lowerPrice.frame.origin.y, lowerPrice.frame.size.width, lowerPrice.frame.size.height)];

	CGSize ratingStringLabelSize=[Tools estimateStringSize:ratingStringLabel.text withFontSize:17];
	[ratingStringLabel setFrame:CGRectMake(ratingStringLabel.frame.origin.x, ratingStringLabel.frame.origin.y, ratingStringLabelSize.width, ratingStringLabelSize.height)];
	[ratingView setFrame:CGRectMake(ratingStringLabel.frame.origin.x+ratingStringLabel.frame.size.width+space, ratingView.frame.origin.y, ratingView.frame.size.width, ratingView.frame.size.height)];
	
	CGSize maxSize=CGSizeMake(466, 20000);
	CGSize contentSize=[Tools estimateStringSize:contentLabel.text withFontSize:17 withMaxSize:maxSize];
	[contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentSize.width, contentSize.height)];
    [contentLabel setBackgroundColor:[UIColor clearColor]];
	//[contentScrollView setContentSize:contentSize];
	
    CGSize priceSize=[Tools estimateStringSize:lowerPrice.text withFontSize:30.0f withMaxSize:CGSizeMake(297, 30)];
    NSLog(@"lowerPrice.txt %@",lowerPrice.text);
    [lowerPrice setFrame:CGRectMake(lowerPrice.frame.origin.x, lowerPrice.frame.origin.y, priceSize.width, priceSize.height)];
    
    [shoppingBtn setFrame:CGRectMake(lowerPrice.frame.origin.x+lowerPrice.frame.size.width+20.0f, shoppingBtn.frame.origin.y, shoppingBtn.frame.size.width, shoppingBtn.frame.size.height)];
    
	[self.view setNeedsDisplay];
}
-(IBAction)shoppingAction:(id)sender{
    //can't buy anthing in offline version
    [Tools FcMessageWindows:AMLocalizedString(@"Cannot_buy", nil) withParentView:self.view];
                       
    /*
    if([productName.text isEqualToString:@"-"]||[productName.text isEqualToString:@""]){
        //可能因錯誤之網路傳輸導致productid不對
        [Tools FcMessageWindows:AMLocalizedString(@"BadNetworkTransfer", nil) withParentView:self.view];
        return;
    }
    BuyPopView *buyView= [[BuyPopView alloc]initWithProductId:productId withProductName:productName.text withProductPrice:[upperPrice.text intValue] withParentView:self.view];
    FcPopWindows *pop=[[FcPopWindows alloc] initWithInnerFrame:buyView.view.frame.size withPosition:CGPointMake(175,215) withContentViewController:buyView withCloseBtnString:AMLocalizedString(@"Cancel", nil) isAllowedClose:YES];
    [pop show:self.view];
    [buyView release];
     */
    //release by itself
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        [self changePage:nil];
        return;
    }
    CGFloat pageWidth = contentScrollView.frame.size.width;
    int page = floor((contentScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageController.currentPage = page;
}

-(void)createContentSubviews:(QueryPattern*)query{
    NSMutableString *contentString;
    NSString *title;
    int index=0;
    for (int i=0; i<4; i++) {
        switch (i) {
            case 0:
                title=[NSString stringWithString:AMLocalizedString(@"ProductDescription", nil)];
                contentString=(NSMutableString*)[query getValue:@"description" withIndex:0];
                break;
            case 1:
                title=[NSString stringWithString:AMLocalizedString(@"ProductSpec", nil)];
                contentString=[NSMutableString string];
                NSInteger count=[query getNumberUnderNode:@"specList" withKey:@"name"];
                for(int i=0;i<count;i++){
                    [contentString appendFormat:@"%@ %@\n",[query getValueUnderNode:@"specList" withKey:@"name" withIndex:i],[query getValueUnderNode:@"specList" withKey:@"value" withIndex:i]];
                }
                break;
            case 2:
                title=[NSString stringWithString:AMLocalizedString(@"ProductAcc", nil)];
                contentString=(NSMutableString*)[query getValue:@"accessories" withIndex:0];
                break;
            case 3:
                title=[NSString stringWithString:AMLocalizedString(@"ProductService", nil)];
                contentString=(NSMutableString*)[query getValue:@"service" withIndex:0];;
                break;
        }
        if ([contentString isEqualToString:@"-"])
            return; //表示沒有該欄位
        UIScrollView *thisContent=[self createContentScrollSubView:index withTitle:title withContent:contentString];
        [contentViews addObject:thisContent];
        [contentScrollView addSubview:thisContent];
        index++;
    }
}

-(UIView*)createContentScrollSubView:(NSInteger)index withTitle:(NSString*)title withContent:(NSString*)content{
    UIView *rView=[[UIScrollView alloc]initWithFrame:CGRectMake(723*index, 0, 723, 429)];
    UILabel *_titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(7, 20, 300, 20)];
    [_titleLabel setTextAlignment:UITextAlignmentLeft];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setText:title];
    [_titleLabel setFont:[UIFont fontWithName:DefaultFontName size:20]];
    [_titleLabel setTextColor:[UIColor colorWithRed:(CGFloat)135/256 green:(CGFloat)82/256 blue:(CGFloat)7/256 alpha:1]];
    [rView addSubview:_titleLabel];
    [_titleLabel release];
    
    UITextView *_contentView=[[UITextView alloc]initWithFrame:CGRectMake(7, 49, 709, 380)];
    _contentView.editable=NO;
    [_contentView setFont:[UIFont fontWithName:DefaultFontName size:18]];
    [_contentView setBackgroundColor:[UIColor clearColor]];
    [_contentView setTextColor:[UIColor blackColor]];
    [_contentView setText:content];
    [rView addSubview:_contentView];
    [_contentView release];
    
    return  [rView autorelease];
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate==YES)
        pageControlUsed=YES;
    else
        [self changePage:nil];
}
- (IBAction)changePage:(id)sender{
    [contentScrollView scrollRectToVisible:CGRectMake(723*pageController.currentPage, 0, 723, 429) animated:YES];
}
#pragma mark -
@end
