//
//  AboutFutureModel.h
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentObject.h"

@interface AboutFutureModel : NSObject {

}
//API 201
+(NSArray*)getNewsList;
//API 202
+(ContentObject*)getNewsContent:(NSString*)newsKey;
//API 203
+(ContentObject*)getExhibitFeature;
//API 204
+(ContentObject*)getTicketInfo;
//API 205
+(ContentObject*)getVisitNotice;
//API 210
+(ContentObject*)getFeatureContent:(NSString*)featureId;
//API 211
+(ContentObject*)getContactInfo;
//API 101
+(NSArray*)getAreaList:(NSString*)areaId;
//API 103
+(ContentObject*)getFlowerListByAreaId:(NSString*)areaId;
//API 105
+(ContentObject*)getFlowerByName:(NSString*)flowerName;

+(NSArray*)getMarquees;
@end
