//
//  CalendarData.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalendarData : NSObject {
    NSMutableArray *allDaysInMonth;
}
+(CalendarData*)shareMainCalendar;
+(void)releaseSingleton;
@end