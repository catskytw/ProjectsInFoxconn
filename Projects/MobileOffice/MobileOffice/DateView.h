//
//  DateView.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DateView : UIViewController {
    IBOutlet UILabel *dayLabel;
    IBOutlet UILabel *monthLabel;
    CGFloat fc_radian;
    
    NSString *_day,*_month;
}
@property(nonatomic,retain)UILabel *dayLabel,*monthLabel;
@property(nonatomic)CGFloat fc_radian;
-(id)initWithDay:(NSString*)day withMonth:(NSString*)month;
-(void)caculateXYFromRadian;
@end
