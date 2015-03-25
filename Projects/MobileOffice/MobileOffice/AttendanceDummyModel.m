//
//  AttendanceDummyModel.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/11/25.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "AttendanceDummyModel.h"
#import "TravelDataObject.h"
#import "TravelTimeObject.h"
#import "OverDataObject.h"
#import "OverTimeDataObject.h"
#import "OffDataObject.h"
#import "OffTimeDataObject.h"
@implementation AttendanceDummyModel
-(NSArray*)getTravelData:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate{
    TravelTimeObject *time1=[TravelTimeObject new];
    time1.startDate=[NSDate dateWithTimeIntervalSince1970:1320903848];
    time1.endDate=[NSDate dateWithTimeIntervalSince1970:1321335848];
    time1.evtAddress=@"龍華";
    time1.timeStyle=@"出差";
    
    TravelTimeObject *time2=[TravelTimeObject new];
    time2.startDate=[NSDate dateWithTimeIntervalSince1970:1321422248];
    time2.endDate=[NSDate dateWithTimeIntervalSince1970:1322286248];
    time2.evtAddress=@"台灣";   
    time2.timeStyle=@"事假";
    
    TravelTimeObject *time3=[TravelTimeObject new];
    time3.startDate=[NSDate dateWithTimeIntervalSince1970:1322372648];
    time3.endDate=[NSDate dateWithTimeIntervalSince1970:1322631848];
    time3.evtAddress=@"深圳";  
    time3.timeStyle=@"特休";
    
    TravelDataObject *m_testObject1=[TravelDataObject new];
    m_testObject1.cname=@"程又青";
    m_testObject1.workNo=@"16408";
    m_testObject1.assignAddr=@"駐地:龍華";
    
    m_testObject1.evtAddrList=[[NSArray arrayWithObjects:@"龍華",@"台灣",@"深圳", nil]retain];
    
    m_testObject1.travelList=[[NSMutableArray arrayWithObjects:time1,time2,time3, nil]retain];
    
    TravelDataObject *m_testObject2=[TravelDataObject new];
    m_testObject2.cname=@"李大仁";
    m_testObject2.workNo=@"16409";
    m_testObject2.assignAddr=@"駐地:台灣";
    
    m_testObject2.evtAddrList=[[NSArray arrayWithObjects:@"龍華",@"台灣",@"深圳", nil]retain];
    
    m_testObject2.travelList=[[NSMutableArray arrayWithObjects:time1,time2,time3, nil]retain];
    NSArray *m_returnArray=[NSArray arrayWithObjects:m_testObject1,m_testObject2, nil];
    [AttendanceModel share].attendanceArray=[NSMutableArray arrayWithArray: m_returnArray];
    return m_returnArray;
}

-(NSArray*)getOTList:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate{
    NSMutableArray *m_returnArray=[[NSMutableArray array] retain];
    
    OverDataObject *obj1=[OverDataObject new];
    obj1.workNo=@"16409";
    obj1.cname=@"李大仁";
    
    OverTimeDataObject *time1=[OverTimeDataObject new];
    time1.overTime=[NSDate dateWithTimeIntervalSince1970:1322372648];
    time1.overHours=4;
    time1.overType=@"G2";
    
    OverTimeDataObject *time2=[OverTimeDataObject new];
    time2.overTime=[NSDate dateWithTimeIntervalSince1970:1321968818];
    time2.overHours=8;
    time2.overType=@"G2";
    
    OverDataObject *obj2=[OverDataObject new];
    obj2.workNo=@"16408";
    obj2.cname=@"程又青";
    
    obj1.otList=[NSArray arrayWithObjects:time1,time2, nil];
    obj2.otList=[NSArray arrayWithObjects:time1,time2, nil];
    [m_returnArray addObjectsFromArray:[NSArray arrayWithObjects:obj1,obj2,nil]];
    [AttendanceModel share].overTimeArray=[NSMutableArray arrayWithArray:m_returnArray];
    return [m_returnArray autorelease];
}

-(NSArray*)getLeaveList:(NSArray*)_employees withStartDate:(NSDate*)_startDate withEndDate:(NSDate*)_endDate{
    NSMutableArray *m_returnArray=[[NSMutableArray array] retain];
    
    OffDataObject *obj1=[OffDataObject new];
    obj1.workNo=@"16409";
    obj1.cname=@"李大仁";
    
    OffTimeDataObject *time1=[OffTimeDataObject new];
    time1.startDate=[NSDate dateWithTimeIntervalSince1970:1321968818];
    time1.endDate=[NSDate dateWithTimeIntervalSince1970:1322314418];
    time1.typeString=@"事假";
    
    OffTimeDataObject *time2=[OffTimeDataObject new];
    time2.startDate=[NSDate dateWithTimeIntervalSince1970:1321282418];
    time2.endDate=[NSDate dateWithTimeIntervalSince1970:1321367018];
    time2.typeString=@"特休";
    
    OffTimeDataObject *time3=[OffTimeDataObject new];
    time3.startDate=[NSDate dateWithTimeIntervalSince1970:1321282418];
    time3.endDate=[NSDate dateWithTimeIntervalSince1970:1321367018];
    time3.typeString=@"病假";
    
    OffDataObject *obj2=[OffDataObject new];
    obj2.workNo=@"16408";
    obj2.cname=@"程又青";
    
    obj1.offArray=[NSArray arrayWithObjects:time1,time2, nil];
    obj2.offArray=[NSArray arrayWithObjects:time1,time3, nil];
    [m_returnArray addObjectsFromArray:[NSArray arrayWithObjects:obj1,obj2,nil]];
    [AttendanceModel share].offArray=[NSMutableArray arrayWithArray:m_returnArray];
    return [m_returnArray autorelease];
}
@end
