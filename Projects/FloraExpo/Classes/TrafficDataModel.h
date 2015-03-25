//1111
//  TrafficDataModel.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusLineDescriptionObject.h"
#import "TrainInfoObject.h"
#import "MapSettingDataObject.h"
#import <MapKit/MapKit.h>
@interface TrafficDataModel : NSObject {

}
//取得所有公車分類
+(NSMutableArray*)getBusSearchCategory;
//取得該分類下所有公車列表
+(NSMutableArray*)getBusSearchCategoryList:(NSString*)selectedBusLineType;
+(NSMutableArray*)getBusSearchCategoryByStationName:(NSString*)stationName;
+(BusLineDescriptionObject*)getBusStationInfoObject:(NSString*)lineId withLeaveMode:(NSString*)leaveString;
+(BusLineDescriptionObject*)getMRTStationInfoObject:(NSString*)stationKey isLeave:(BOOL)isLeave;
+(NSMutableArray*)getAllTrainStationName;
+(NSMutableDictionary*)getAllTrainLineBetweenTwoStations:(NSString*)startId withEndStation:(NSString*)destId withTrainType:(NSInteger)trainType withDateTicks:(NSString*)dateTicks withDurationHr:(NSInteger)d_hr isDeparture:(BOOL)isDeparture;
+(TrainInfoObject*)getTrainInfoObject:(NSString*)key  withStartId:(NSString*)startStationId withDestId:(NSString*)destStationId;
+(NSMutableArray*)getAllHighSpeedStations;
+(NSMutableDictionary*)getAllHighSpeedBetweenTwoStations:(NSString*)startStation withEndStation:(NSString*)endStation isDeparture:(BOOL)isDeparture withDuration:(NSInteger)duration withQueryTime:(NSString*)queryTime;
+(TrainInfoObject*)getHighSpeedInfoObjectWithTrainId:(NSString*)trainId withStartId:(NSString*)startId withDestId:(NSString*)destId;
+(NSMutableArray*)getAllMRTLine;
+(NSMutableArray*)getParkingAreaData;
+(NSMutableArray*)getParkingInfoData:(NSString*)areaName;
+(NSMutableArray*)getParkingDetailInfo:(NSString*)parkingName;
+(NSMutableArray*)getAllPOIData:(NSInteger)type withCentral:(CLLocationCoordinate2D)thisLocation;
+(NSMutableArray*)getAllBusLine:(NSString*)startStation withEndStation:(NSString*)endStation;
+(NSArray*)getTrafficSearchItems;
+(NSArray*)getTrafficSearchItemImages;
+(MapSettingDataObject*)getMapQuerySetting;
+(BOOL)setMapQuerySetting:(MapSettingDataObject*)thisDataObject;
+(NSString*)getUTF8EncodingString:(NSString*)originString;
+(NSMutableArray*)getBusStationLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range;
+(NSMutableArray*)getParkLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range;
+(NSMutableArray*)getTraLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range;
+(NSMutableArray*)getHsrLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range;
+(NSMutableArray*)getTRTCLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range;

+(BOOL)verifyUser;
+(NSString*)getAlertMessage;
@end