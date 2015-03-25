//
//  GoFutureModel.h
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExhibitionInfoObject.h"
#import "AreaInfoObject.h"
#import "FlowerAreaObject.h"
#import "FlowerContentObject.h"
#import "ContentObject.h"
@interface GoFutureModel : NSObject {

}
//API 106
+(ExhibitionInfoObject*)getExhibitPointInfo:(NSString*)exhibitPtId;
//API 108
+(NSMutableArray*)getExhibitPtFacilityList;
//API 102
+(AreaInfoObject*)getAreaInfo:(NSString*)areaId;
//API 107
+(FlowerAreaObject*)getFlowerListByExhibitPtId:(NSString*)exhibitPtId;
//API 104
+(FlowerContentObject*)getFlowerInfo:(NSString*)flowerId;
//API 207
+(NSArray*)getTransportationTypeList;
//API 208
+(ContentObject*)getTransportationInfo:(NSString*)transKey;
@end
