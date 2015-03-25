//
//  MapDAO.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationInfoObject.h"
@interface MapDAO : NSObject{
    
}
-(LocationInfoObject*)getLocationFromExhibitorId:(NSString*)exhibitorId;
-(NSArray*)getLast3Schedules;
-(NSString*)getLocationIconName:(NSInteger)bitmapId;
-(LocationInfoObject*)fetchLocationFromUUID:(NSString*)_uuid;
-(NSString*)getExitByFromAndToMapId:(NSInteger)fromMapId withToMapId:(NSInteger)toMapId;
-(NSArray*)getAllLocationList:(NSInteger)floor;
-(void)settingInitNowPosition;
-(NSMutableArray*)getFacilityLocationByIds:(NSString*)idString;
-(NSString*)getExhibitorIdFromUUID:(NSString*)_uuid;
@end
