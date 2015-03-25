//
//  ShoppingCartTableCell.h
//  WMBT
//
//  Created by link on 2011/6/10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartCellDataObject.h"
#import "ShoppingCartTableCellTextField.h"
@interface ShoppingCartTableCell : UITableViewCell{
    IBOutlet UIImageView *productImg;
    IBOutlet UILabel *productName;
    IBOutlet UILabel *priceUnitLabel;
    IBOutlet UILabel *colorLabel;
    IBOutlet UILabel *totalPrice;
    IBOutlet ShoppingCartTableCellTextField *unitTextField;
    Float64 fPrice;
    
    UILabel *subTotalLabel;
    BOOL bLoaded;
}
@property (nonatomic, retain) IBOutlet UILabel *subTotalLabel;
@property (nonatomic, retain) IBOutlet UIImageView *productImg;
@property (nonatomic, retain) IBOutlet UILabel *productName;
@property (nonatomic, retain) IBOutlet UILabel *priceUnitLabel;
@property (nonatomic, retain) IBOutlet UILabel *colorLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalPrice;
@property (nonatomic, retain) IBOutlet ShoppingCartTableCellTextField *unitTextField;
@property (nonatomic) BOOL bLoaded;
- (void)setInfoDO:(ShoppingCartCellDataObject*) dao;
- (void)resetPrice;

@end
