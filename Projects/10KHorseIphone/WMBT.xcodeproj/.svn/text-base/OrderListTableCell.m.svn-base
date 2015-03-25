//
//  OrderListTableCell.m
//  WMBT
//
//  Created by link on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OrderListTableCell.h"
#import "Tools.h"
#import "LocalizationSystem.h"
@implementation OrderListTableCell
@synthesize status;
@synthesize orderListId;
@synthesize orderDate;
@synthesize orderTotal;
@synthesize orderDiscount;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		    }
    return self;
}
- (void)dealloc
{
    [orderListId release];
    [orderDate release];
    [orderDiscount release];
    [orderTotal release];
    [status release];
    [super dealloc];
}
- (void)setInfoDO:(OrderListCellDataObject*) dao{
    orderDiscount.text = [[NSString alloc] initWithFormat:@"%@ %@, %@ %@" ,AMLocalizedString(@"Order_Discount", nil),[Tools getMoneyString:dao.orderDiscount],AMLocalizedString(@"Order_Total", nil),[Tools getMoneyString:dao.orderAmount]];
    orderListId.text = dao.orderNumber;
    
    orderDate.text = [[NSString alloc] initWithFormat:@"%@(%@)" ,dao.orderDate, dao.orderStore];
    status.text = dao.orderStatus;
    status.textColor = [UIColor colorWithRed:(float)134/255.0f green:(float)84/255.0f blue:(float)34/255.0f alpha:1];
}
@end
