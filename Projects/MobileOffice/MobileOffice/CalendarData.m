//
//  CalendarData.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "CalendarData.h"

static CalendarData *singletonCalendarData=nil;
@implementation CalendarData
+(CalendarData*)shareMainCalendar{
    if (singletonCalendarData==nil) {
        singletonCalendarData=[CalendarData new];
    }
    return  singletonCalendarData;
}
+(void)releaseSingleton{
    [singletonCalendarData release];
}
@end
