//
//  AttendanceRealModel.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/12/1.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "AttendanceRealModel.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "MOLoginViewController.h"
#import "MOLoginInfo.h"
#import "TravelDataObject.h"
#import "TravelTimeObject.h"
#import "ProjectTool.h"
#import "OffDataObject.h"
#import "OffTimeDataObject.h"
#import "OverDataObject.h"
#import "OverTimeDataObject.h"
@interface AttendanceRealModel(PrivateMethod)
-(NSString*)getTravelJSONString:(NSDate*)startTime withEndDate:(NSDate*)endTime withEmployees:(NSArray*)employees;
@end
@implementation AttendanceRealModel
-(NSArray*)getTravelData:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate{
    NSMutableArray *m_rArray=[[NSMutableArray array] retain];
    NSString *m_jsonString=[self getTravelJSONString:_startDate withEndDate:_endDate withEmployees:_employees];
                            
    QueryPattern *query=[QueryPattern new];
    [query prepareDic:getBusinessTrabelInfo([MOLoginViewController loginInfo].sessionId, [MOLoginViewController loginInfo].loginId, m_jsonString)];
    
    NSArray *travelEmpList=(NSArray*)[query getObjectUnderNode:@"travelEmpList" withIndex:0];
    for (NSDictionary *eachEmp in travelEmpList) {
        QueryPattern *eachEmpQuery=[QueryPattern new];
        [eachEmpQuery prepareDicWithDictionary:eachEmp];
        TravelDataObject *thisTravelObj=[TravelDataObject new];
        NSArray *m_evtAddrList=(NSArray*)[eachEmpQuery getObjectUnderNode:@"evtAddrList" withIndex:0];
        thisTravelObj.evtAddrList=[NSMutableArray arrayWithArray:m_evtAddrList];
        thisTravelObj.travelList=[NSMutableArray array];
        NSArray *m_travelList=(NSArray*)[eachEmpQuery getObjectUnderNode:@"travelList" withIndex:0];
        for (NSDictionary *m_travelItem in m_travelList) {
            QueryPattern *travelItemQuery=[QueryPattern new];
            [travelItemQuery prepareDicWithDictionary:m_travelItem];
            TravelTimeObject *travelItem=[TravelTimeObject new];
            
            NSInteger startDateTimeInterval= ceilf([[ProjectTool getTimestamp:[travelItemQuery getValue:@"startDate" withIndex:0] withKey:@"Timestamp"]longLongValue]/1000.0f);
            NSInteger endDateTimeInterval= ceilf([[ProjectTool getTimestamp:[travelItemQuery getValue:@"endDate" withIndex:0] withKey:@"Timestamp"]longLongValue]/1000.0f);
            
            travelItem.startDate=[NSDate dateWithTimeIntervalSince1970:startDateTimeInterval];
            travelItem.endDate=[NSDate dateWithTimeIntervalSince1970:endDateTimeInterval];
            travelItem.evtAddress=[NSString stringWithString:[travelItemQuery getValue:@"evtAddress" withIndex:0]];
                                   
            [thisTravelObj.travelList addObject:travelItem];
            [travelItem release];
        }
        thisTravelObj.cname=[NSString stringWithString:[eachEmpQuery getValue:@"cname" withIndex:0]];
        thisTravelObj.workNo=[NSString stringWithString:[eachEmpQuery getValue:@"workNo" withIndex:0]];
        thisTravelObj.assignAddr=[NSString stringWithString:[eachEmpQuery getValue:@"assignAddr" withIndex:0]];
        [m_rArray addObject:[thisTravelObj autorelease]];
        [eachEmpQuery release];
    }
    NSLog(@"count %d",[m_rArray count]);
    [[AttendanceModel share].attendanceArray removeAllObjects];
    [[AttendanceModel share].attendanceArray addObjectsFromArray:m_rArray];
    //getB([MOLoginViewController loginInfo].sessionId,returnJSON) 
    [query release];
    return m_rArray;
}
-(NSArray*)getLeaveList:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate{
    NSMutableArray *r_array=[NSMutableArray array];
    NSString *m_jsonString=[self getTravelJSONString:_startDate withEndDate:_endDate withEmployees:_employees];
    QueryPattern *m_query=[QueryPattern new];
    [m_query prepareDic:getLeaveList([MOLoginViewController loginInfo].sessionId, [MOLoginViewController loginInfo].loginId, m_jsonString)];
    NSArray *m_offArray=(NSArray*)[m_query getObjectUnderNode:@"leaveEmpList" withIndex:0];
    int m_cout=0;
    for (NSDictionary *m_offDic in m_offArray) {
        if (m_cout>20) break;
        OffDataObject *personOff=[OffDataObject new];
        QueryPattern *m_personQuery=[QueryPattern new];
        [m_personQuery prepareDicWithDictionary:m_offDic];
        personOff.cname=[NSString stringWithString:[m_personQuery getValue:@"localName" withIndex:0]];
        personOff.workNo=[NSString stringWithString:[m_personQuery getValue:@"workNo" withIndex:0]];
        personOff.offArray=[NSMutableArray array];
        NSArray *otList=[m_personQuery getObjectUnderNode:@"leaveList" withIndex:0];
        for (NSDictionary *timeDic in otList) {
            QueryPattern *timeQuery=[QueryPattern new];
            [timeQuery prepareDicWithDictionary:timeDic];
            OffTimeDataObject *timeObject=[[OffTimeDataObject new]autorelease];
            @try{
                
                NSInteger startDateTimeInterval= [[[ProjectTool getTimestamp:[timeQuery getValue:@"startDate" withIndex:0] withKey:@"Timestamp"]substringWithRange:NSMakeRange(0, 10)] intValue];
                NSInteger endDateTimeInterval= ceilf([[ProjectTool getTimestamp:[timeQuery getValue:@"endDate" withIndex:0] withKey:@"Timestamp"]longLongValue]/1000.0f);
                timeObject.startDate=[NSDate dateWithTimeIntervalSince1970:startDateTimeInterval];
                timeObject.endDate=[NSDate dateWithTimeIntervalSince1970:endDateTimeInterval];
                timeObject.typeString=[NSString stringWithString:[timeQuery getValue:@"lvTypeName" withIndex:0]];
                [personOff.offArray addObject:timeObject];
            }
            @catch (NSException *exception) {
            }
            [timeQuery release];
        }
        [m_personQuery release];
        [r_array addObject:[personOff autorelease]];
        m_cout++;
    }
    [m_query release];
    [[AttendanceModel share].offArray removeAllObjects];
    [[AttendanceModel share].offArray addObjectsFromArray:r_array];
    return r_array;
}
-(NSArray*)getOTList:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate{
    NSMutableArray *r_array=[NSMutableArray array];
    NSString *m_jsonString=[self getTravelJSONString:_startDate withEndDate:_endDate withEmployees:_employees];
    QueryPattern *m_query=[QueryPattern new];
    [m_query prepareDic:getOTList([MOLoginViewController loginInfo].sessionId, [MOLoginViewController loginInfo].loginId, m_jsonString)];
    NSArray *m_offArray=(NSArray*)[m_query getObjectUnderNode:@"otEmpList" withIndex:0];
    for (NSDictionary *m_offDic in m_offArray) {
        OverDataObject *personOverTime=[OverDataObject new];
        QueryPattern *m_personQuery=[QueryPattern new];
        [m_personQuery prepareDicWithDictionary:m_offDic];
        personOverTime.cname=[NSString stringWithString:[m_personQuery getValue:@"localName" withIndex:0]];
        personOverTime.workNo=[NSString stringWithString:[m_personQuery getValue:@"workNo" withIndex:0]];
        personOverTime.otList=[NSMutableArray array];
        NSArray *otList=[m_personQuery getObjectUnderNode:@"otList" withIndex:0];
        for (NSDictionary *timeDic in otList) {
            QueryPattern *timeQuery=[QueryPattern new];
            [timeQuery prepareDicWithDictionary:timeDic];
            OverTimeDataObject *timeObject=[OverTimeDataObject new];
            NSInteger startDateTimeInterval= [[[ProjectTool getTimestamp:[timeQuery getValue:@"otDate" withIndex:0] withKey:@"Timestamp"]substringWithRange:NSMakeRange(0, 10)] intValue];
            timeObject.overTime=[NSDate dateWithTimeIntervalSince1970:startDateTimeInterval];
            timeObject.overHours=[[timeQuery getValue:@"otHours" withIndex:0] intValue];
            timeObject.overType=[NSString stringWithString: [timeQuery getValue:@"otType" withIndex:0]];
            [personOverTime.otList addObject:timeObject];
            [timeQuery release];
        }
        [m_personQuery release];
        [r_array addObject:[personOverTime autorelease]];
    }
    [m_query release];
    [[AttendanceModel share].overTimeArray removeAllObjects];
    [[AttendanceModel share].overTimeArray addObjectsFromArray:r_array];
    return r_array;
}

-(NSString*)getTravelJSONString:(NSDate*)startTime withEndDate:(NSDate*)endTime withEmployees:(NSArray*)employees{
    NSInteger m_startTime=[startTime timeIntervalSince1970];
    NSInteger m_endTime=[endTime timeIntervalSince1970];
    
    BOOL isFirstElement=YES;
    NSMutableString *m_emploeeString=[NSMutableString stringWithString:@"["];
    for (NSString *m_workNo in employees) {
        if(isFirstElement){
            [m_emploeeString appendFormat:@"\"%@\"",m_workNo];
            isFirstElement=!isFirstElement;
        }else
            [m_emploeeString appendFormat:@",\"%@\"",m_workNo];
    }
    [m_emploeeString appendString:@"]"];
    NSString *rString=nil;
    switch (attendanceType) {
        case ATTENDANCE_TRAVEL:
            rString=[NSString stringWithFormat:@"{\"startDate\":\"Timestamp(%d000)\",\"endDate\":\"Timestamp(%d000)\",\"empList\":%@}",m_startTime,m_endTime,m_emploeeString];
            break;
        case ATTENDANCE_OVERTIME:
        case ATTENDANCE_OFF:
            rString=[NSString stringWithFormat:@"{\"startDate\":\"Timestamp(%d000)\",\"endDate\":\"Timestamp(%d000)\",\"empList\":%@}",m_startTime,m_endTime,m_emploeeString];
            break;
        default:
            break;
    }
    return rString;
}
@end

