//
//  AttendanceModel.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/11/25.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "AttendanceModel.h"
#import "FcConfig.h"
#import "TravelDataObject.h"

#import "AttendanceDummyModel.h"
#import "AttendanceRealModel.h"
#import "MOSearchResultItem.h"
static AttendanceModel *singletonAttendanceModel=nil;

@implementation AttendanceModel
@synthesize offArray,attendanceArray,overTimeArray,workNos,attendanceType,tableHeight;
+(AttendanceModel*)share{
    if(singletonAttendanceModel==nil){
        //change adaptor here
        singletonAttendanceModel=[AttendanceRealModel new];
    }
    return singletonAttendanceModel;
}

+(void)releaseSingleton{
    [singletonAttendanceModel release];
    singletonAttendanceModel=nil;
}

-(id)init{
    if((self=[super init])){
        attendanceType=ATTENDANCE_TRAVEL;
        offArray=[NSMutableArray new];
        attendanceArray=[NSMutableArray new];
        overTimeArray=[NSMutableArray new];
        workNos=[NSMutableArray new];
    }
    return self;
}
-(void)dealloc{
    [offArray release];
    [attendanceArray release];
    [overTimeArray release];
    [workNos release];
    [super dealloc];
}

- (void)didAddWorkers:(NSArray *)array{
    for (MOSearchResultItem *m_thisItem in array) {
        [workNos addObject:m_thisItem.workNo];   
    }
}
- (void)didRemoveWorkers:(NSArray *)array{
    for (MOSearchResultItem *m_thisItem in array) {
        for (NSString *worker in workNos) {
            if([worker isEqualToString:m_thisItem.workNo]){
                [workNos removeObject:worker];
                break;
            }
        }
    }
}
@end
