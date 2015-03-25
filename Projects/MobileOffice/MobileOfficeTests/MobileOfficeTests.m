//
//  MobileOfficeTests.m
//  MobileOfficeTests
//
//  Created by 廖 晨志 on 2011/8/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MobileOfficeTests.h"
#import <EventKit/EventKit.h>
@implementation MobileOfficeTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}
/*
- (void)testExample{
    NSDate *dateNow=[NSDate new];

    NSDate *preday=[[NSDate alloc] initWithTimeIntervalSince1970:[dateNow timeIntervalSince1970]-86400];
    NSDate *nextDay=[[NSDate alloc] initWithTimeIntervalSince1970:[dateNow timeIntervalSince1970]+86400];

    CalendarDAO *dao=[CalendarDAO share];
    NSArray *array=[dao fetchEventsWithStartDate:preday withEndDate:nextDay];
    for(EKEvent *event in array){
        NSLog(@"eventTitle: %@",event.title);
    }
    [dao release];
}
-(void)test1{
    NSLog(@"starting add a new event!");
    EventObject *newEvent=[EventObject new];
    newEvent.eventName=@"TestEventName";
    newEvent.eventDesc=@"EventBalaBala";
    newEvent.startDate=[NSDate new];
    newEvent.endDate=[NSDate new];
    newEvent.eventLocation=@"A19";
    newEvent.eventType=0;
    newEvent.repeatType=0;
    BOOL r=[[CalendarNetworkInterface share] addEvent:newEvent];
    NSLog(@"r:%i",r);
    [newEvent release];
    
    NSDate *startTime=[[NSDate alloc] initWithTimeIntervalSince1970: ([[NSDate new] timeIntervalSince1970]-3600)];
    NSDate *endTime=[NSDate new];
    NSArray *returnArray=[[CalendarNetworkInterface share] fetchEventsFromStartDate:startTime withEndDate:endTime];
    
    for(EventObject *thisObject in returnArray){
        NSLog(@"id:%@",thisObject.identifier);
        NSLog(@"title: %@",thisObject.eventName);
        NSLog(@"desc:%@",thisObject.eventDesc);
    }
}
*/
@end
