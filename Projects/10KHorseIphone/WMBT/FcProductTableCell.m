//
//  FcProductTableCell.m
//  FcProductList
//
//  Created by link on 2011/2/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FcProductTableCell.h"
#import "Configure.h"
#import "QueryPattern.h"
#import "Tools.h"
#import <QuartzCore/QuartzCore.h>

@implementation FcProductTableCell
@synthesize No1Img;
@synthesize imgProduct, lblName,imgScore,lblprice,productListController,bLoaded;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		productListController = nil;
        bLoaded = false;
    }
    return self;
}
-(void)setScore:(CGFloat)ratingScore{
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
		[star setFrame:CGRectMake(i*(xSpace+2), 0, 13, 11)];
		[imgScore addSubview:star];
		[star release];
		ratingScore--;
	}
}

- (void)setInfoDO:(ProductListCellDataObject*) dao andController:(id) viewController{
	[self setInfo:dao.imgUrl andNameTxt:dao.productName andPriceTxt:dao.price andScore:dao.score andController: viewController];
}
- (void)setInfo:(NSString*) urlImgProduct andNameTxt:(NSString*) strName andPriceTxt:(NSString*) strPrice
andScore:(NSString*) sScore andController:(id) viewController{
	if (urlImgProduct!=@"" && strName !=@"") {
		//NSLog(@"urlImg:%@",picUrl(urlImgProduct));
		//QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
		//[query uiValueBinding:imgProduct withValue:picUrl(urlImgProduct)];
		//[query release];		
		[self setScore:[sScore floatValue]];
        //NSLog(@"SetInfo %@", strName);
		lblName.text = strName;
		lblName.font = [UIFont systemFontOfSize:NameFontSize];
		lblName.textAlignment = UITextAlignmentLeft;
		lblprice.text = [Tools getMoneyString:strPrice];
		lblprice.font = [UIFont systemFontOfSize:PriceFontSize];
		lblprice.textAlignment = UITextAlignmentRight;
		productListController = viewController;
        [imgProduct.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [imgProduct.layer setBorderWidth: 1.0];
		//next level
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    No1Img.hidden = YES;
}

- (void)dealloc {
    //[No1Img release];
    [super dealloc];
	productListController = nil;
}

-(void) showNo1:(int)number{
    No1Img.hidden = NO;
    NSString *strImage =@"contentui_btn_rank_no1.png";
    if (number==2) {
        strImage =@"contentui_btn_rank_no2.png";
    }else if(number ==3){
        strImage =@"contentui_btn_rank_no3.png";
    }
    [No1Img setImage:[UIImage imageNamed:strImage]];
}
@end
