//
//  FloraExpoModel.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExhibitionDescriptionObject.h"
#import "DescriptionPageDataObject.h"
@interface FloraExpoModel : NSObject {
}
+(NSMutableArray*)getFloraExpoContentItemsTitle;
-(NSMutableArray*)getFloraExpoContentItemsPicName;

-(NSString*)getFloraExpoContentTitle:(NSInteger)index;
-(NSString*)getFloraExpoContentPicName:(NSInteger)index;
-(NSString*)getFLoraExpoNewsDate:(NSInteger)index;
-(NSString*)getFloraExpoNewsContent:(NSInteger)index;

+(NSMutableArray*)totalAboutFloratitles;
+(NSString*)getFloraAboutFloraTitle:(NSInteger)index;
+(NSString*)getFloraAboutFloraPicName:(NSInteger)index;
+(DescriptionPageDataObject*)getAllAreaExhibitionName;
+(ExhibitionDescriptionObject*)getExhibitionDescription:(NSString*)key;
-(NSArray*)getFlowerArea;
-(NSArray*)getAllFlowerKind;
-(NSArray*)searchFlowerByKey:(NSString*)key;

+(NSMutableArray*)getExpoLatestNewList;
//116
+(DescriptionPageDataObject*)getExpoNewsInfo:(NSString*)newsId;
//101
+(DescriptionPageDataObject*)getExpoOriginDesc;
//102
+(DescriptionPageDataObject*)getExpoVisittimeDesc;
+(DescriptionPageDataObject*)getExpoContact;
+(DescriptionPageDataObject*)getExpoTicketInfo;
+(DescriptionPageDataObject*)getExpoTrafficInfo;
+(DescriptionPageDataObject*)getExpoVisitNotice;
//103
+(DescriptionPageDataObject*)getExpoHotelAreaList;
+(NSMutableArray*)getExpoHotelListWithKey:(NSString*)key;
//109
+(ExhibitionDescriptionObject*)getExpoExhibitionInfo:(NSString*)exhibitId;
@end
