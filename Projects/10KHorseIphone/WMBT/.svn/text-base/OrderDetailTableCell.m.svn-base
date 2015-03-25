//
//  OrederDetailTableCell.m
//  WMBT
//
//  Created by link on 2011/6/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailTableCell.h"
#import "Tools.h"

@implementation OrderDetailTableCell
@synthesize ProductNameLabel;
@synthesize QuantityLabel;
@synthesize PriceLabel;


- (void)dealloc
{
    //[ProductNameLabel release];
    //[QuantityLabel release];
    //[PriceLabel release];
    [super dealloc];
}
- (void)setInfoDO:(OrderDetailDataObject*) dao{
    ProductNameLabel.text = dao.name;
    QuantityLabel.text = [NSString stringWithFormat:@"X %@",dao.quantity];
    PriceLabel.text = [Tools getMoneyString:dao.price];

}

@end
