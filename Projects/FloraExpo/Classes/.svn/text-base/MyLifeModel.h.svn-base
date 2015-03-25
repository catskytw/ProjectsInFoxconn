//
//  MyLifeModel.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyLifeDescriptionObject.h"
#import "DiscountDetailObject.h"
#import "MapSettingDataObject.h"
#import <MapKit/MapKit.h>
@interface MyLifeModel : NSObject {

}
+(NSMutableArray*)getAllDirectoryByMyLife;
+(NSArray*)getAllArea;
+(NSArray*)getAllCategory:(NSString*)userId isSetting:(BOOL)isSetting;
+(NSArray*)getAllSearchResult:(NSString*)maincategoryKey withSubCategoryKey:(NSString*)subKey withDistrictKey:(NSString*)districtKey;
+(MyLifeDescriptionObject*)getMyLifeDetailInformation:(NSString*)storeKey;
+(NSArray*)getAllDiscountAction;
+(DiscountDetailObject*)getDicountDetailInfo:(NSString*)discountKey;
+(MapSettingDataObject*)getMapSetting;
+(BOOL)setMapQuerySetting:(MapSettingDataObject*)thisDataObject;
+(NSMutableArray*)getLifeInfoLocationList:(NSInteger)range withLocation:(CLLocationCoordinate2D)location withMainCategory:(NSString*)mainCategoryString withSubCategory:(NSString*)subCategoryString;
@end
