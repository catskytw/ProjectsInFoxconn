//
//  OrderListTableCell.h
//  WMBT
//
//  Created by link on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListCellDataObject.h"

@interface OrderListTableCell : UITableViewCell {
    
    UILabel *orderListId;
    UILabel *orderDate;
    UILabel *orderTotal;
    UILabel *orderDiscount;
    UILabel *status;
}
@property (nonatomic, retain) IBOutlet UILabel *status;
@property (nonatomic, retain) IBOutlet UILabel *orderListId;
@property (nonatomic, retain) IBOutlet UILabel *orderDate;
@property (nonatomic, retain) IBOutlet UILabel *orderTotal;
@property (nonatomic, retain) IBOutlet UILabel *orderDiscount;
- (void)setInfoDO:(OrderListCellDataObject*) dao;

@end
