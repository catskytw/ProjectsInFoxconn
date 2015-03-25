//
//  MapDAO.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapDAO.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "LoginDataObject.h"
#import "DateUtilty.h"
#import "ScheduleObject.h"
#import "UITuneLayout.h"
#import "LocationInfoObject.h"
#import "LoginDataObject.h"
@interface MapDAO(PrivateMethod)
@end
@implementation MapDAO
-(LocationInfoObject*)getLocationFromExhibitorId:(NSString*)exhibitorId{
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[qp prepareDic:getExhibitorById(loginDO.sessionId, exhibitorId)];
    LocationInfoObject *returnObject=[LocationInfoObject new];
    returnObject.mapId=[qp getValue:@"mapId" withIndex:0];
    returnObject.locationId=[qp getValue:@"locationId" withIndex:0];
    [qp release];
    return [returnObject autorelease];
}
-(NSArray*)getAllLocationList:(NSInteger)floor{
    NSMutableArray *allLocationList=[[NSMutableArray array]retain];
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [qp prepareDic:getAllLocationList([LoginDataObject sharedInstance].sessionId,floor)];
    int totalCount=[qp getNumberUnderNode:@"locationList" withKey:@"locationId"];
    for(int i=0;i<totalCount;i++){
        LocationInfoObject *thisObject=[LocationInfoObject new];
        thisObject.name=[NSString stringWithString:[qp getValueUnderNode:@"locationList" withKey:@"name" withIndex:i]];
        thisObject.mapId=[NSString stringWithString:[qp getValueUnderNode:@"locationList" withKey:@"mapId" withIndex:i]];
        thisObject.locationId=[NSString stringWithString:[qp getValueUnderNode:@"locationList" withKey:@"locationId" withIndex:i]];
        [allLocationList addObject:thisObject];
    }
    [qp release];
    return allLocationList;
}
-(NSArray*)getLast3Schedules{
    NSMutableArray *returnArray=[NSMutableArray new];
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [qp prepareDic:last3Schedules([LoginDataObject sharedInstance].sessionId)];
    int count=[qp getNumberUnderNode:@"locationList" withKey:@"title"];
    for(int i=0;i<count;i++){
        ScheduleObject *newScheudle=[ScheduleObject new];
        newScheudle.title=[NSString stringWithString:[qp getValue:@"title" withIndex:i]];
        newScheudle.startTime=[DateUtilty timeString:[UITuneLayout getTimestamp:[qp getValue:@"startDate" withIndex:i] withKey:@"Timestamp"]];
        newScheudle.endTime=[DateUtilty timeString:[UITuneLayout getTimestamp:[qp getValue:@"endDate" withIndex:i] withKey:@"Timestamp"]];
        newScheudle.locationPoint=[NSString stringWithString: [qp getValue:@"locationId" withIndex:i]];
        newScheudle.mapId=[NSString stringWithString: [qp getValue:@"mapId" withIndex:i]];
                           
        [returnArray addObject:[newScheudle autorelease]];
    }
    [qp release];
    return (NSArray*)[returnArray autorelease];
}

//取得location資訊
//@param:uuid from QRCode
-(LocationInfoObject*)fetchLocationFromUUID:(NSString*)_uuid{
    LocationInfoObject *newLocation=[LocationInfoObject new];
    QueryPattern *qp=[QueryPattern new];
    [qp prepareDic:getLocationByQRCode([LoginDataObject sharedInstance].sessionId,_uuid)];
    newLocation.name=[NSString stringWithString:[qp getValueUnderNode:@"location" withKey:@"name" withIndex:0 withDepth:1]];
    newLocation.mapId=[qp getValue:@"mapId" withIndex:0];
    newLocation.locationId=[qp getValue:@"locationId" withIndex:0];
    newLocation.pointId=[qp getValueUnderNode:@"pointList" withKey:@"pointId" withIndex:0];
    [qp release];
    return [newLocation autorelease];
}

-(NSString*)getExitByFromAndToMapId:(NSInteger)fromMapId withToMapId:(NSInteger)toMapId{
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [qp prepareDic:getExitByFromAndToMapId([LoginDataObject sharedInstance].sessionId , fromMapId, toMapId)];
    [LocationInfoObject targetPosition].name=[NSString stringWithFormat:@"%@",[qp getValueUnderNode:@"location" withKey:@"name" withIndex:0 withDepth:1]];
    [LocationInfoObject targetPosition].pointId=[NSString stringWithFormat:@"%@",[qp getValue:@"pointId" withIndex:0]];
    [LocationInfoObject targetPosition].mapId=[NSString stringWithFormat:@"%@",[qp getValue:@"mapId" withIndex:0]];
    [LocationInfoObject targetPosition].locationId=[NSString stringWithFormat:@"%@",[qp getValue:@"locationId" withIndex:0]];
    NSString *targetPoint=[qp getValueUnderNode:@"pointList" withKey:@"pointId" withIndex:0];
    [qp release];
    return targetPoint;
}
-(NSMutableArray*)getFacilityLocationByIds:(NSString*)idString{
    NSMutableArray *rArray=[NSMutableArray array];
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [qp prepareDic:getFacilityLocationByIds([LoginDataObject sharedInstance].sessionId,idString)];
    int count=[qp getNumberUnderNode:@"locationList" withKey:@"locationId"];
    for (int i=0; i<count; i++) {
        LocationInfoObject *thisObject=[LocationInfoObject new];
        thisObject.name=[NSString stringWithString:[qp getValueUnderNode:@"locationList" withKey:@"name" withIndex:i withDepth:1]];
        thisObject.locationId=[NSString stringWithString:[qp getValueUnderNode:@"locationList" withKey:@"locationId" withIndex:i withDepth:1]];
        thisObject.mapId=[NSString stringWithString:[qp getValueUnderNode:@"locationList" withKey:@"mapId" withIndex:i]];
        [rArray addObject:thisObject];
    }
    [qp release];
    return rArray;
}

-(void)settingInitNowPosition{
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [qp prepareDic:getDefaultExitLocation([LoginDataObject sharedInstance].sessionId)];
    [LocationInfoObject nowPosition].mapId=[NSString stringWithFormat:@"%d", B_1F];
    [LocationInfoObject nowPosition].name=[NSString stringWithFormat:@"%@",[qp getValueUnderNode:@"location" withKey:@"name" withIndex:0 withDepth:1]];
    NSLog(@"now position name:%@",[LocationInfoObject nowPosition].name);
    [LocationInfoObject nowPosition].pointId=[NSString stringWithFormat:@"%@",[qp getValueUnderNode:@"pointList" withKey:@"pointId" withIndex:0]];
    [qp release];
}
-(NSString*)getExhibitorIdFromUUID:(NSString*)_uuid{
    
    QueryPattern *qp=[QueryPattern new];
    [qp prepareDic:getExhibitorByQRCode([LoginDataObject sharedInstance].sessionId,_uuid)];
    NSString *r=[NSString stringWithString:[qp getValueUnderNode:@"exhibitor" withKey:@"id" withIndex:0]];
    [qp release];
    return r;
}
-(NSString*)getLocationIconName:(NSInteger)bitmapId{
    NSString *iconName=@"";
    switch (bitmapId) {
        case 1:
            iconName=@"ic_01.png";
            break;
        case 2:
            iconName=@"ic_02.png";
            break;
        case 3:
            iconName=@"ic_03.png";
            break;
        case 4:
            iconName=@"ic_04.png";
            break;
        case 5:
            iconName=@"ic_05.png";
            break;
        case 6:
            iconName=@"ic_06.png";
            break;
        case 7:
            iconName=@"ic_07.png";
            break;
        case 8:
            iconName=@"ic_08.png";
            break;
        case 9:
            iconName=@"ic_09.png";
            break;
        case 10:
            iconName=@"ic_10.png";
            break;
        case 11:
            iconName=@"ic_11.png";
            break;
        case 12:
            iconName=@"ic_12.png";
            break;
        case 13:
            iconName=@"ic_13.png";
            break;
        case 14:
            iconName=@"ic_14.png";
            break;
        case 15:
            iconName=@"ic_15.png";
            break;
        case 16:
            iconName=@"ic_16.png";
            break;
        case 17:
            iconName=@"ic_17.png";
            break;
        case 18:
            iconName=@"ic_18.png";
            break;
        case 19:
            iconName=@"ic_19.png";
            break;
        case 20:
            iconName=@"ic_20.png";
            break;
        case 21:
            iconName=@"ic_21.png";
            break;
        case 22:
            iconName=@"ic_22.png";
            break;
        case 9999:
            break;
        default:
            break;
    }
    return iconName;
}
@end
