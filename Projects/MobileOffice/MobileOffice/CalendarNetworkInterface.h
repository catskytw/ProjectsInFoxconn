//
//  CalendarNetworkInterface.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
@interface CalendarNetworkInterface : NSObject {
    
}
+(CalendarNetworkInterface*)share;
+(void)releaseSingleton;
-(BOOL)addEvent:(EKEvent*)event;
-(BOOL)removeEvent:(EKEvent*)event;
-(BOOL)updateEvent:(EKEvent*)updateEvent;
-(NSMutableDictionary*)fetchEventsFromDate:(NSDate*)baseDate;
@end
