    //
//  ProductDetailView1.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcProductDetailView1.h"
#import "Tools.h"
@interface FcProductDetailView1(PrivateMethod)
-(void)EnvelopSuit;
-(void)tuneLayout;
-(void)ratingBar:(CGFloat)ratingScore;
#ifdef TEST_DATA
-(void)testData;
#endif
@end

@implementation FcProductDetailView1

@synthesize titleLabel,brand,productName,lowerPrice,upperPrice;
@synthesize priceStringUpperLacel,priceStringLowerLabel,ratingStringLabel,desStringLabel;
@synthesize titleBackground,productPicture;
@synthesize productPictureMinList;
@synthesize content;
@synthesize closeBtn;
@synthesize ratingView;

#pragma mark Developer Override
//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//setting multi-language.
	[titleLabel setText:<#填入文字#>];
	[priceStringLowerLabel setText:<#填入文字#>];
	[priceStringUpperLabel setText:<#填入文字#>];
	[ratingStringLabel setText:<#填入文字#>];
	[desStringLabel setText:<#填入文字#>];
	[closeBtn.titleLabel setText:<#填入文字#>];
	
	//setting theme-picture
	[titleBackground setImage:[UIImage imageNamed:<#填入圖片名稱#>]];
	[closeBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[closeBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];
}

#ifdef TEST_DATA
-(void)testData{
}
#endif
#pragma mark -
#pragma mark LifeCycle
-(void)viewDidLoad{
	[super viewDidLoad];
	[self EnvelopSuit];
	[self tuneLayout];
#ifdef TEST_DATA
	[self testData];
#endif
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
	int xSpace=10;
	NSString *picName;
	for(int i=0;i<5;i++){
		if(ratingScore>=1)
			picName=<#填入全滿之圖示#>;
		else if(ratingScore>0 && ratingScore<1){
			picName=<#填入半滿之圖示#>;
		}else {
			picName=<#填入未得分之圖示#>;
		}

		UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:picName]];
		//The rating icon's size must be 15x15
		[star setFrame:CGRectMake(i*(xSpace+15), 0, 15, 15)];
		[ratingView addSubview:star];
		[star release];
		ratingScore--;
	}
}

/*Tune layout. 'cause multi-language or defining different label-string by uses,
 probably screw the layout from template.
 YOU DON'T NEED MODIFYING THIS METHOD.
 */
-(void)tuneLayout{
	int space=5;
	CGSize upperPriceStringLabelSize=[Tools estimateStringSize:priceStringUpperLabel.text withFontSize:17];
	[priceStringUpperLabel setFrame:CGRectMake(priceStringUpperLabel.frame.origin.x, priceStringUpperLabel.frame.origin.y, upperPriceStringLabelSize.width, upperPriceStringLabelSize.height)];
	[upperPrice setFrame:CGRectMake(priceStringUpperLabel.frame.origin.x+priceStringUpperLabel.frame.size.width+space, upperPrice.frame.origin.y, upperPrice.frame.size.width, upperPrice.frame.size.height)];

	CGSize lowerPriceStringLabelSize=[Tools estimateStringSize:priceStringLowerLabel.text withFontSize:17];
	[priceStringLowerLabel setFrame:CGRectMake(priceStringLowerLabel.frame.origin.x, priceStringLowerLabel.frame.origin.y, lowerPriceStringLabelSize.width, lowerPriceStringLabelSize.height)];
	[lowerPrice setFrame:CGRectMake(priceStringLowerLabel.frame.origin.x+priceStringLowerLabel.frame.size.width+space, lowerPrice.frame.origin.y, lowerPrice.frame.size.width, lowerPrice.frame.size.height)];

	CGSize ratingStringLabelSize=[Tools estimateStringSize:ratingStringLabel.text withFontSize:17];
	[ratingStringLabel setFrame:CGRectMake(ratingStringLabel.frame.origin.x, ratingStringLabel.frame.origin.y, ratingStringLabelSize.width, ratingStringLabelSize.height)];
	[ratingView setFrame:CGRectMake(ratingStringLabel.frame.origin.x+ratingStringLabel.frame.size.width+space, ratingView.frame.origin.y, ratingView.frame.size.width, ratingView.frame.size.height)];
}
#pragma mark -
@end
