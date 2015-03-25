//
//  ShoppingCartTableCell.m
//  WMBT
//
//  Created by link on 2011/6/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ShoppingCartTableCell.h"
#import "LocalizationSystem.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "Tools.h"
#import <QuartzCore/QuartzCore.h>
@implementation ShoppingCartTableCell
@synthesize subTotalLabel;
@synthesize productImg;
@synthesize productName;
@synthesize priceUnitLabel;
@synthesize colorLabel;
@synthesize totalPrice;
@synthesize unitTextField;
@synthesize bLoaded;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        bLoaded = NO;
    }
    return self;
}
- (void)dealloc
{

    [super dealloc];
}
- (void)setInfoDO:(ShoppingCartCellDataObject*) dao{
    //[dao retain];
    unitTextField.productId = dao.productId;
    productName.text = dao.productName;
    if(dao.color)
    {
        colorLabel.text =[NSString stringWithFormat:@"/%@",dao.color];
    }
    unitTextField.text = [NSString stringWithFormat:@"%d",dao.quantity]; 
    priceUnitLabel.text = AMLocalizedString(@"money_unit", nil);
    totalPrice.text = [Tools getMoneyStringF32:dao.quantity*dao.price];
    CGRect subTotalRect = [totalPrice frame];
    CGSize subTotalSize =[Tools estimateStringSize:totalPrice.text withFontSize:16];
    totalPrice.frame = CGRectMake(285-subTotalSize.width, subTotalRect.origin.y, subTotalSize.width, subTotalRect.size.height);
    subTotalLabel.text = AMLocalizedString(@"shoppingCart_Subtotal", nil);
    CGRect subTotalLabelRect = [subTotalLabel frame];
    CGSize subTotalLabelSize =[Tools estimateStringSize:subTotalLabel.text withFontSize:13];
    subTotalLabel.frame = CGRectMake(280-subTotalSize.width-subTotalLabelSize.width, subTotalLabelRect.origin.y, subTotalLabelRect.size.width, subTotalLabelRect.size.height);

    fPrice = dao.price;
    //QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [productImg.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [productImg.layer setBorderWidth: 1.0];
    //[query uiValueBinding:productImg withValue:picUrl(dao.imgUrl)];
    //[query release];
}
- (void)resetPrice
{
    totalPrice.text = [NSString stringWithFormat:@"%.1f",[unitTextField.text floatValue]*fPrice];
}
@end
