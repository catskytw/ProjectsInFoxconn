//
//  FcStyle1Cell.h
//  Logistics
//
//  Created by Chang Link on 11/9/1.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FcTableCellStyle1 : UITableViewCell{
    NSMutableArray *selectedArray;
    CGRect selectedRect ;
    CGRect seperateLineRect;
}
-(void)setLayout;

@end
