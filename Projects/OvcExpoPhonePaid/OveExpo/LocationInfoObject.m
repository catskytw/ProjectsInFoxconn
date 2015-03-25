//
//  LocationInfoObject.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LocationInfoObject.h"
static LocationInfoObject *singletonLocationInfo=nil;
static LocationInfoObject *targetLocationInfo=nil;
@implementation LocationInfoObject
@synthesize locationId,mapId,name,pointId;
+(LocationInfoObject*)nowPosition{
    if(singletonLocationInfo==nil){
        singletonLocationInfo=[LocationInfoObject new];
    }
    return singletonLocationInfo;
}
+(LocationInfoObject*)targetPosition{
    if(targetLocationInfo==nil){
        targetLocationInfo=[LocationInfoObject new];
    }
    return targetLocationInfo;
}
+(void)releaseSingleton{
    if(singletonLocationInfo!=nil){
        [singletonLocationInfo release];
        singletonLocationInfo=nil;
    }
    if(targetLocationInfo!=nil){
        [targetLocationInfo release];
        targetLocationInfo=nil;
    }
}
@end
