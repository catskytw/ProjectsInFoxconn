//
//  CalendarDAO.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "CalendarDAO.h"
static CalendarDAO *singletonCalendarDAO=nil;
@implementation CalendarDAO
@synthesize eventsInMainMonthView,eventStore;
+(CalendarDAO*)share{
    if(singletonCalendarDAO==nil)
        singletonCalendarDAO=[CalendarDAO new];
    return singletonCalendarDAO;
}
+(void)releaseSingleton{
    [singletonCalendarDAO release];
}
-(id)init{
    if((self=[super init])){
        eventStore=[[EKEventStore alloc] init];
        eventsInMainMonthView=[[NSMutableArray array] retain];
    }
    return self;
}
-(void)dealloc{
    [eventsInMainMonthView release];
    [eventStore release];
    [super dealloc];
}
-(EKEvent*)factoryEvent{
    EKEvent *myEvent=[EKEvent eventWithEventStore:eventStore];
    myEvent.calendar=[eventStore defaultCalendarForNewEvents];
    return myEvent;
}
-(NSString*)addEventWithEKEvent:(EKEvent*)_event{
    NSError *error=nil;
    EKRecurrenceRule *recurrenceObject=_event.recurrenceRule;
    EKSpan span=(recurrenceObject==nil)?EKSpanThisEvent:EKSpanFutureEvents;
    [eventStore saveEvent:_event span:span error:&error];
    NSLog(@"addEventWithEKEvent ID %@",_event.eventIdentifier);
    return _event.eventIdentifier;
}
-(NSString*)updateEventWithEKEvent:(EKEvent*)dataEvent withEventId:(NSString*)eventId{
    NSLog(@"updateEventWithEKEvent eventId %@", eventId);
    EKEvent *_thisEvent=[self fetchEvent:eventId];
    _thisEvent.title=dataEvent.title;
    _thisEvent.location=dataEvent.location;
    _thisEvent.notes=dataEvent.notes;
    _thisEvent.recurrenceRule=dataEvent.recurrenceRule;
    _thisEvent.alarms=dataEvent.alarms;
    _thisEvent.startDate=dataEvent.startDate;
    _thisEvent.endDate=dataEvent.endDate;
    return [self addEventWithEKEvent:_thisEvent];
}

-(void)deleteEvent:(NSString*)eventId{
    for(EKEvent *thisEvent in eventsInMainMonthView){
        if ([thisEvent.eventIdentifier isEqualToString:eventId]){
            [eventsInMainMonthView removeObject:thisEvent];
            break;
        }
    }
    [eventsInMainMonthView sortUsingSelector:@selector(compareStartDateWithEvent:)];
    
    NSError *error;
    EKEvent *deleteEvent=[eventStore eventWithIdentifier:eventId];
    [eventStore removeEvent:deleteEvent span:EKSpanFutureEvents error:&error];
}
-(void)setEventsInMonthView:(NSArray*)events{
    [eventsInMainMonthView removeAllObjects];
    [eventsInMainMonthView addObjectsFromArray:events];
}
-(NSArray*)fetchEventsWithStartDate:(NSDate*)startDate withEndDate:(NSDate*)endDate{
    NSPredicate *predicate=[eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    NSArray *_tmpArray=[eventStore eventsMatchingPredicate:predicate];
    _tmpArray=[_tmpArray sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    return _tmpArray;
}
-(EKEvent*)fetchEvent:(NSString*)idString{
    NSLog(@"fetchEvent idString %@", idString);
    for(EKEvent *thisEvent in eventsInMainMonthView){
        //NSLog(@"fetchEvent %@", thisEvent.eventIdentifier);
        
        if([thisEvent.eventIdentifier isEqualToString:idString])
        {
            NSLog(@"fetchEvent %@", thisEvent.eventIdentifier);
            return thisEvent;
        }
    }
    return nil;
}
@end
