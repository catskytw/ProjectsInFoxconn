//
//  CalendarNetworkInterface.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "CalendarNetworkInterface.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "CalendarDAO.h"
#import "ProjectTool.h"
#import "SingletonDBConnect.h"
#import "FMResultSet.h"
#import "SQLCommand.h"
#import "MOLoginViewController.h"
#import "MOLoginInfo.h"
static CalendarNetworkInterface *singletonInterface=nil;

@interface CalendarNetworkInterface(PrivateMethod)
-(NSString*)getEventJSONString:(EKEvent*)event isNewEvent:(BOOL)isNewEvent;
@end
@implementation CalendarNetworkInterface
+(CalendarNetworkInterface*)share{
    if(singletonInterface==nil)
       singletonInterface=[CalendarNetworkInterface new];
    return singletonInterface;
}

+(void)releaseSingleton{
    [singletonInterface release];
}

-(BOOL)addEvent:(EKEvent*)event{
    BOOL isAddSuccess=NO;

    NSString *returnJSON=[self getEventJSONString:event isNewEvent:YES];
    
    QueryPattern *query=[QueryPattern new];
    NSString *qureryStr =[ AddEventURL([MOLoginViewController loginInfo].sessionId,returnJSON) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",AddEventURL([MOLoginViewController loginInfo].sessionId,returnJSON));
    //NSString *qureryStr = AddEventURL([MOLoginViewController loginInfo].sessionId,returnJSON) ;
    [query prepareDic:qureryStr];
    isAddSuccess=([[query getValue:@"response" withIndex:0] isEqualToString:@"0"])?YES:NO;
    NSLog(@"mapping %@ %@",event.eventIdentifier,[query getValue:event.eventIdentifier withIndex:0]);
    //插入server 和 local key的mapping
    [[SingletonDBConnect share] executeUpdate:AddKeysMapping(event.eventIdentifier,[query getValue:event.eventIdentifier withIndex:0])];

    [query release];
    return isAddSuccess;
}

-(NSMutableDictionary*)fetchEventsFromDate:(NSDate*)baseDate{
    NSMutableDictionary *rDic=[[NSMutableDictionary dictionary] retain];
    int dateLong=ceil([baseDate timeIntervalSince1970]);
    NSString *m_dateLong=[NSString stringWithFormat:@"%i000",dateLong];
    QueryPattern *query=[QueryPattern new];
    [query prepareDic:fetchEventsURL([MOLoginViewController loginInfo].sessionId,m_dateLong)];
    NSInteger eventListNum=[query getNumberForKey:@"id"];
    for(int i=0;i<eventListNum;i++){
        NSDictionary *eventData=[[query getObjectUnderNode:@"eventList" withIndex:0]objectAtIndex:i];
        
        EKEvent *thisEvent=[[CalendarDAO share] factoryEvent];
        if([(NSString*)[eventData objectForKey:@"active"] isEqual:@"N"])
        {
            FMResultSet *result=[[SingletonDBConnect share] executeQuery:GetLocalKeys((NSString*)[eventData objectForKey:@"id"])];
            NSString *localId=@"";
            while ([result next]) {
                localId=  [result stringForColumn:@"LOCALID"];
            }
            [[CalendarDAO share] deleteEvent:localId];
            //NSLog(@"delete event %@",localId);
            continue;
        }
        thisEvent.location=(NSString*)[eventData objectForKey:@"location"];
        thisEvent.notes=(NSString*)[eventData objectForKey:@"description"];
        thisEvent.title=(NSString*)[eventData objectForKey:@"subject"];
        thisEvent.recurrenceRule=[ProjectTool recurrenceRuleForType: [[eventData objectForKey:@"repeatType"] intValue]];
        //thisEvent.calendar.type=[[eventData objectForKey:@"eventType"]intValue];
        thisEvent.location=[NSString stringWithFormat:@"%@%@%@",thisEvent.location,Seperator,[eventData objectForKey:@"eventType"]];
        NSLog(@"%@",thisEvent.location);
        NSTimeInterval timeInterval=[ProjectTool parseTimeIntervalFromJSONFormat:(NSString*)[eventData objectForKey:@"beginDatetime"]];
        thisEvent.startDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
        timeInterval=[ProjectTool parseTimeIntervalFromJSONFormat:(NSString*)[eventData objectForKey:@"endDatetime"]];

        thisEvent.endDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
        //[rDic setValue:[thisEvent autorelease] forKey:[eventData objectForKey:@"id"]];
        [rDic setValue:thisEvent forKey:[eventData objectForKey:@"id"]];
    }
    [query release];
    return [rDic autorelease];
}
-(BOOL)updateEvent:(EKEvent*)updateEvent{
    BOOL r=NO;
    NSString *eventJSONString=[self getEventJSONString:updateEvent isNewEvent:NO];
    QueryPattern *query=[QueryPattern new];
    NSString *qureryStr =[ updateEventURL([MOLoginViewController loginInfo].sessionId,eventJSONString) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [query prepareDic:qureryStr];
    r=![[query getValue:@"response" withIndex:0] boolValue];
    [query release];
    return r;
}
-(BOOL)removeEvent:(EKEvent*)i_event{
    BOOL r=NO;
    FMResultSet *result=[[SingletonDBConnect share] executeQuery:GetServerKeys(i_event.eventIdentifier)];
    NSString *serverId=@"";
    while ([result next]) {
        serverId=  [result stringForColumn:@"SERVERID"];
        
    }
    NSLog(@"servier ID %@",serverId);
    QueryPattern *query=[QueryPattern new];
    [query prepareDic:deleteEventURL([MOLoginViewController loginInfo].sessionId,serverId)];
    r=![[query getValue:@"response" withIndex:0] boolValue];
    [query release];
    return r;
}

-(NSString*)getEventJSONString:(EKEvent*)event isNewEvent:(BOOL)isNewEvent{
    int beginTime=ceil([event.startDate timeIntervalSince1970]);
    int endTime=ceil([event.endDate timeIntervalSince1970])+600;
    NSString *beginDatetime=[NSString stringWithFormat:@"%i000",beginTime];
    NSString *endDatetime=[NSString stringWithFormat:@"%i000",endTime];
    NSString *eventType=[ProjectTool getEventTypeFromEventForJson:event];
    NSString *repeatType=[NSString stringWithFormat:@"%i",[ProjectTool parseRepeatIndex:event.recurrenceRule]];
    FMResultSet *result=[[SingletonDBConnect share] executeQuery:GetServerKeys(event.eventIdentifier)];
    NSString *serverId=@"";
    while ([result next]) {
        serverId= [result stringForColumn:@"SERVERID"];
    }
    NSString *eventId = event.eventIdentifier;
    if (!isNewEvent) {
        return [NSString stringWithFormat:@"{\"id\":\"%@\",\"workNo\":\"%@\",\"beginDatetime\":\"Timestamp(%@)\",\"endDatetime\":\"Timestamp(%@)\",\"eventType\":\"%@\",\"repeatType\":\"%@\",\"subject\":\"%@\",\"location\":\"%@\",\"description\":\"%@\"}",serverId,[MOLoginViewController loginInfo].loginId,beginDatetime,endDatetime,eventType,repeatType,event.title,[ProjectTool getLocationFromEvent:event],event.notes];
    }else{
        return [NSString stringWithFormat:@"{\"localEventId\":\"%@\",\"workNo\":\"%@\",\"beginDatetime\":\"Timestamp(%@)\",\"endDatetime\":\"Timestamp(%@)\",\"eventType\":\"%@\",\"repeatType\":\"%@\",\"subject\":\"%@\",\"location\":\"%@\",\"description\":\"%@\"}",eventId,[MOLoginViewController loginInfo].loginId,beginDatetime,endDatetime,eventType,repeatType,event.title,[ProjectTool getLocationFromEvent:event],event.notes];   
    }

}
@end
