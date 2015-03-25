//
//  Attendance3View.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentXibView.h"
@interface Attendance3View : ContentXibView{
    IBOutlet UIScrollView *contentScrollView;
    NSMutableArray *dataArray;
}
@property(nonatomic,retain)UIScrollView *contentScrollView;
-(void)drawAttendanceSchedule:(NSNotification*)noti;
-(void)drawOverTimeShcedule:(NSNotification*)noti;
-(void)drawOffSchedule:(NSNotification*)noti;
@end
