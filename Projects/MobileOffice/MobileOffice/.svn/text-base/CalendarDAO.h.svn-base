//
//  CalendarDAO.h
//  MobileOffice
//
//  DAO for EventKit
//
//  Created by 廖 晨志 on 2011/8/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
@interface CalendarDAO : NSObject {
    EKEventStore *eventStore;
    NSMutableArray *eventsInMainMonthView;
}
@property(nonatomic,retain)NSMutableArray *eventsInMainMonthView;
@property(nonatomic,retain)EKEventStore *eventStore;
+(CalendarDAO*)share;
+(void)releaseSingleton;
-(void)setEventsInMonthView:(NSArray*)events;
-(void)deleteEvent:(NSString*)eventId;
-(NSArray*)fetchEventsWithStartDate:(NSDate*)startDate withEndDate:(NSDate*)endDate;
-(EKEvent*)factoryEvent;
-(NSString*)addEventWithEKEvent:(EKEvent*)_event;
-(NSString*)updateEventWithEKEvent:(EKEvent*)dataEvent withEventId:(NSString*)eventId;
-(EKEvent*)fetchEvent:(NSString*)idString;
@end
