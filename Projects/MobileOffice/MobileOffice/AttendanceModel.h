//
//  AttendanceModel.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/11/25.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOSearchUserViewController.h"
@interface AttendanceModel : NSObject<MettingScheduleDelegate>{
    NSMutableArray *attendanceArray;
    NSMutableArray *overTimeArray;
    NSMutableArray *offArray;
    NSMutableArray *workNos;
    NSInteger attendanceType,tableHeight;
}
@property(nonatomic,retain)NSMutableArray *overTimeArray,*offArray,*attendanceArray,*workNos;
@property(nonatomic)NSInteger attendanceType,tableHeight;
+(AttendanceModel*)share;

-(NSArray*)getTravelData:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate;
-(NSArray*)getOTList:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate;
-(NSArray*)getLeaveList:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate;
@end
