//
//  OrederDetailTableCell.h
//  WMBT
//
//  Created by link on 2011/6/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDataObject.h"

@interface OrderDetailTableCell : UITableViewCell {
    
    IBOutlet UILabel *ProductNameLabel;
    IBOutlet UILabel *QuantityLabel;
    IBOutlet UILabel *PriceLabel;
}
@property (nonatomic, retain)  UILabel *ProductNameLabel;
@property (nonatomic, retain)  UILabel *QuantityLabel;
@property (nonatomic, retain)  UILabel *PriceLabel;
- (void)setInfoDO:(OrderDetailDataObject*) dao;
@end
