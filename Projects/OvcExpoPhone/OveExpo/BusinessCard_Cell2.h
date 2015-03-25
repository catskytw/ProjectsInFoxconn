//
//  OveMeetingListCell2.h
//  OveExpo
//
//  Created by  on 11/9/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
/*typedef enum{
    FcGroupTableCellMode_MIDDLE1 = 0, //中
    FcGroupTableCellMode_TOP1,      //上
    FcGroupTableCellMode_BUTTON1,
}FcGroupTableCellMode1;*/

@interface BusinessCard_Cell2 : UITableViewCell{
    int mode ;// 0 middle 1 top 2 button
    
    UIImageView *bgView;
    UIImageView *selectedImg;
    UIImageView *seperateLineImg;
    UILabel *label1;
    UITextField *textField1;
}
@property (nonatomic, retain) IBOutlet UIImageView *bgView;
@property (nonatomic, retain) IBOutlet UIImageView *selectedImg;
@property (nonatomic, retain) IBOutlet UIImageView *seperateLineImg;
@property (nonatomic, retain) IBOutlet UILabel *label1;
@property (nonatomic, retain) IBOutlet UITextField *textField1;
@property int mode;
-(void)setFcLayout:(NSIndexPath *)indexPath withRows:(NSInteger)rows;

@end
