//
//  FcGroupTableCell.h
//  OveExpo
//
//  Created by Chang Link on 11/9/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
/*typedef enum{
    FcGroupTableCellMode_MIDDLE = 0, //中
    FcGroupTableCellMode_TOP,      //上
    FcGroupTableCellMode_BUTTON,
}FcGroupTableCellMode;*/
@interface FcGroupTableCell : UITableViewCell{
    int mode ;// 0 middle 1 top 2 button
}
@property (nonatomic, assign) int mode;
-(void)setLayout;
@end
