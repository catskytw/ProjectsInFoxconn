//
//  EventData.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "EventData.h"

static EventData *singletonEventData=nil;
@implementation EventData
+(EventData*)share{
    if(singletonEventData==nil){
        singletonEventData=[EventData new];
        singletonEventData->datesRangeArray=[[NSMutableArray array] retain];
    }
    return singletonEventData;
}
+(void)releaseSingleton{
    [singletonEventData release];
}
@end
