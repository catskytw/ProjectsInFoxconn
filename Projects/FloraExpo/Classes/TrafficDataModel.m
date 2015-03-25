//
//  TrafficDataModel.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrafficDataModel.h"
#import "BusSearchCategoryObject.h"
#import "BusSearchCategoryListObject.h"
#import "BusLineDescriptionObject.h"
#import "StationInfoObject.h"
#import "AreaStationObject.h"
#import "TrainHSListObject.h"
#import "TrainStationObject.h"
#import "MRTListObject.h"
#import "ParkingAreaListCellObject.h"
#import "ParkingInfoObject.h"
#import "Vars.h"

#import "POI.h"
#import "JSONObject.h"
#import "JSON.h"
#import "CommonItem.h"
#import "MRTStationObject.h"
#import "DescriptionObject.h"
#import "NSString.h"
@implementation TrafficDataModel
+(NSMutableArray*)getBusSearchCategory{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	
	NSString *urlString=[NSString stringWithFormat:@"%@201&ln=%@",DefaultUrlString,DefaultLanguage];
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *lineTypeList=[rootDic objectForKey:@"lineTypeList"];
	for(NSDictionary *thisLineObject in lineTypeList){
		NSString *icon=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineTypeIcon"]];
		NSString *lineTypeId=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineTypeId"]];
		NSString *lineTypeName=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineTypeName"]];
		
		[returnArray addObject:[[[BusSearchCategoryObject alloc]initWithPicname:icon withCategoryName:lineTypeName withCategoryId:lineTypeId]autorelease]];
	}
	[myJson release];
	return returnArray;
}

//204,依站名尋找經過路線
+(NSMutableArray*)getBusSearchCategoryByStationName:(NSString*)stationName{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSString *encodingStation=[TrafficDataModel getUTF8EncodingString:stationName];
	NSString *urlString=[NSString stringWithFormat:@"%@204&ln=%@&stationName=%@",DefaultUrlString,DefaultLanguage,encodingStation];
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *lineList=[rootDic objectForKey:@"lineList"];
	for(NSDictionary *thisLineObject in lineList){
		NSString *icon=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"icon"]];
		NSString *lineTypeId=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineId"]];
		NSString *lineTypeName=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineTypeName"]];
		NSString *lineName=[NSString stringWithString:(NSString*)[thisLineObject objectForKey:@"lineName"]];
		
		[returnArray addObject:[[[BusSearchCategoryListObject alloc]initWithPicName:icon withBusName:lineTypeName withBusDescription:lineName withLineId:lineTypeId]autorelease]];
	}
	return returnArray;
}
+(NSMutableArray*)getBusSearchCategoryList:(NSString*)selectedBusLineType{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	
	NSString *urlString=[NSString stringWithFormat:@"%@203&lineCategoryId=%@&ln=%@",DefaultUrlString,selectedBusLineType,DefaultLanguage];
	NSLog(urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *lineList=[rootDic objectForKey:@"lineList"];
	for(NSDictionary *thisLineObject in lineList){
		NSString *icon=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"icon"]];
		NSString *lineTypeId=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineId"]];
		NSString *lineTypeName=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineTypeName"]];
		NSString *lineName=[NSString stringWithString:(NSString*)[thisLineObject objectForKey:@"lineName"]];
		
		[returnArray addObject:[[[BusSearchCategoryListObject alloc]initWithPicName:icon withBusName:lineTypeName withBusDescription:lineName withLineId:lineTypeId]autorelease]];
	}
	return returnArray;
}

+(BusLineDescriptionObject*)getBusStationInfoObject:(NSString*)lineId withLeaveMode:(NSString*)leaveString{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	
	NSString *urlString=[NSString stringWithFormat:@"%@202&lineId=%@&leave=%@&ln=%@",DefaultUrlString,lineId,leaveString,DefaultLanguage];
	NSLog(urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSDictionary *lineInfo=(NSDictionary*)[rootDic objectForKey:@"lineInfo"];
	NSArray *stationList=[lineInfo objectForKey:@"stationList"];
	for(NSDictionary *stationObject in stationList){
		StationInfoObject *thisStation=[StationInfoObject new];
		thisStation.stationId=[NSString stringWithString:(NSString*)[stationObject objectForKey:@"stationId"]];
		thisStation.latitude=[(NSString*)[stationObject objectForKey:@"lat"] doubleValue];
		thisStation.longitude=[(NSString*)[stationObject objectForKey:@"lon"] doubleValue];
		NSString *timeMin=(NSString*)[stationObject objectForKey:@"min"];
		thisStation.timeMin=([timeMin isEqualToString:@"-"])?-1:[timeMin intValue];
		thisStation.stationLineIcon=[NSString stringWithString:(NSString*)[stationObject objectForKey:@"stationLine"]];
		thisStation.stationPassIcon=[NSString stringWithString:(NSString*)[stationObject objectForKey:@"stationPass"]];
		thisStation.stationName=[NSString stringWithString:(NSString*)[stationObject objectForKey:@"name"]];
		thisStation.timeUnit=[NSString stringWithString:(NSString*)[stationObject objectForKey:@"minDesc"]];
		thisStation.isUrgent=([(NSString*)[stationObject objectForKey:@"urgent"] isEqual:@"true"])?YES:NO;
		[returnArray addObject:thisStation];
		[thisStation release];
	}
	
	BusLineDescriptionObject *thisBusDescription=[[BusLineDescriptionObject alloc]init];
	thisBusDescription.busLineId=[NSString stringWithString:lineId];
	thisBusDescription.leaveMode=[NSString stringWithString:leaveString];
	@try{
		thisBusDescription.busLineName=[NSString stringWithString:(NSString*)[lineInfo objectForKey:@"lineName"]];
		thisBusDescription.busLinePic=[NSString stringWithFormat:@"%@.png",(NSString*)[lineInfo objectForKey:@"lineIcon"]];
		thisBusDescription.busLineScheduleString=[NSString stringWithString:(NSString*)[lineInfo objectForKey:@"lineDesc"]];
	}@catch (id theEsception) {
		thisBusDescription.busLineName=[NSString stringWithString:@""];
		thisBusDescription.busLinePic=[NSString stringWithFormat:@""];
		thisBusDescription.busLineScheduleString=[NSString stringWithString:@""];
	}
	thisBusDescription.stationInfoArray=[NSArray arrayWithArray:returnArray];
	return [thisBusDescription autorelease];
}

+(BusLineDescriptionObject*)getMRTStationInfoObject:(NSString*)stationKey isLeave:(BOOL)isLeave{
	BusLineDescriptionObject *thisBusDescription=[[BusLineDescriptionObject alloc]init];
	NSMutableArray *stations=[[NSMutableArray arrayWithObjects:nil]retain];
	NSString *urlString=[NSString stringWithFormat:@"%@221&trainId=%@&leave=%@&ln=%@",DefaultUrlString,stationKey,(isLeave==YES)?@"true":@"false",DefaultLanguage];
	NSLog(urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSDictionary *contentDic=(NSDictionary*)[rootDic objectForKey:@"lineInfo"];
	
	NSArray *stationList=(NSArray*)[contentDic objectForKey:@"stationList"];
	
	for(NSDictionary *thisStationDic in stationList){
		MRTStationObject *thisStationObject=[[[MRTStationObject alloc]initWithStationName:(NSString*)[thisStationDic objectForKey:@"name"] 
																			  withArrivedTime:@"" 
																			  withStationLine:(NSString*)[thisStationDic objectForKey:@"stationLine"] 
																			  withStationPass:(NSString*)[thisStationDic objectForKey:@"stationPass"] 
																			  withStationId:(NSString*)[thisStationDic objectForKey:@"stationId"]]autorelease];
		NSArray *transInfoArray= (NSArray*)[thisStationDic objectForKey:@"transferInfo"];
		int count=0;
		for(NSString *thisString in transInfoArray){
			BOOL isFlagOpen=([thisString isEqual:@"true"]?YES:NO);
			switch (count) {
				case 0:
					thisStationObject.isATrans=isFlagOpen;
					break;
				case 1:
					thisStationObject.isTTrans=isFlagOpen;
					break;
				case 2:
					thisStationObject.isHTrans=isFlagOpen;
					break;
				case 3:
					thisStationObject.isBTrans=isFlagOpen;
					break;
			}
			count++;
		}
		[stations addObject:thisStationObject];
	}
	thisBusDescription.busLineName=(NSString*)[contentDic objectForKey:@"trainLine"];
	thisBusDescription.busLineScheduleString=(NSString*)[contentDic objectForKey:@"totalTravelTime"];
	thisBusDescription.busLinePic=(NSString*)[contentDic objectForKey:@"icon"];
	thisBusDescription.stationInfoArray=stations;
	[stations autorelease];
	return [thisBusDescription autorelease];
}

//所有火車站之站點
+(NSMutableArray*)getAllTrainStationName{
	NSMutableArray *stations=[NSMutableArray arrayWithObjects:nil];
	
	NSString *urlString=[NSString stringWithFormat:@"%@224&ln=%@",DefaultUrlString,DefaultLanguage];
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *areaList=[rootDic objectForKey:@"areaList"];
	for(NSDictionary *thisAreaObject in areaList){
		NSString *areaName=(NSString*)[thisAreaObject objectForKey:@"areaName"];
		NSMutableArray *stationList=[NSMutableArray arrayWithObjects:nil];
		NSArray *jsonStationArray=(NSArray*)[thisAreaObject objectForKey:@"stationList"];
		for(NSDictionary *thisStation in jsonStationArray){
			NSString *stationId=(NSString*)[thisStation objectForKey:@"stationId"];
			NSString *stationName=(NSString*)[thisStation objectForKey:@"stationName"];
			CommonItem *thisItem=[[[CommonItem alloc]initWithItemKey:stationId withItemName:stationName]autorelease];
			[stationList addObject:thisItem];
		}
 		AreaStationObject *thisAreaStationObject=[[[AreaStationObject alloc]initWithAreaName:areaName withStationArray:stationList]autorelease];
		[stations addObject:thisAreaStationObject];
	}
	return stations;
}

/**
 查詢兩站之間的所有火車動線
 */
+(NSMutableDictionary*)getAllTrainLineBetweenTwoStations:(NSString*)startId withEndStation:(NSString*)destId withTrainType:(NSInteger)trainType withDateTicks:(NSString*)dateTicks withDurationHr:(NSInteger)d_hr isDeparture:(BOOL)isDeparture{
	NSString *departureString=(isDeparture==NO)?@"false":@"true";
	NSString *urlString=[NSString stringWithFormat:@"%@218&startId=%@&destId=%@&queryDate=%@&isDeparture=%@&seatMode=%i&durationHr=%i&ln=%@",DefaultUrlString,startId,destId,dateTicks,departureString,trainType,d_hr,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSMutableDictionary *responseDic=[[NSMutableDictionary dictionaryWithDictionary:rootDic]retain];
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	for(NSDictionary *stationDic in (NSArray*)[rootDic objectForKey:@"trainList"]){
		TrainHSListObject *thisStationObject=[[[TrainHSListObject alloc]initWithTrainName:(NSString*)[stationDic objectForKey:@"trainNo"] withCategoryPicName:(NSString*)[stationDic objectForKey:@"icon"] withBrief:(NSString*)[stationDic objectForKey:@"travelTime"] withDuration:(NSString*)[stationDic objectForKey:@"timeDesc"]]autorelease];
		thisStationObject.trainId=(NSString*)[stationDic objectForKey:@"trainId"];
		[returnArray addObject:thisStationObject];
	}
	[responseDic setObject:returnArray forKey:@"trainList"];
	[thisJSONObject release];
	return [responseDic autorelease];
	
}

+(TrainInfoObject*)getTrainInfoObject:(NSString*)key  withStartId:(NSString*)startStationId withDestId:(NSString*)destStationId{
	NSString *urlString=[NSString stringWithFormat:@"%@217&startId=%@&destId=%@&trainId=%@&ln=%@",DefaultUrlString,startStationId,destStationId,key,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSDictionary *rootDic=[jsonString JSONValue];
	NSDictionary *resultDic=(NSDictionary*)[rootDic objectForKey:@"trainInfo"];
	TrainInfoObject *thisObject=[[TrainInfoObject alloc]init];
	thisObject.trainName=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"trainLine"]];
	thisObject.trainSchedule=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"travelTime"]];
	thisObject.categoryPic=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"icon"]];
	thisObject.note=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"trainWeekend"]];
	thisObject.trainStationArray=[NSMutableArray arrayWithObjects:nil];
	
	NSArray *stationList=(NSArray*)[resultDic objectForKey:@"stationList"];
	for(NSDictionary *thisStation in stationList){
		TrainStationObject *thisStationObject=[[[TrainStationObject alloc]initWithStationName:(NSString*)[thisStation objectForKey:@"name"] 
											   withArrivedTime:(NSString*)[thisStation objectForKey:@"min"] 
											   withStationLine:(NSString*)[thisStation objectForKey:@"stationLine"] 
											   withStationPass:(NSString*)[thisStation objectForKey:@"stationPass"] 
											   withStationId:(NSString*)[thisStation objectForKey:@"stationId"]]autorelease];
		[thisObject.trainStationArray addObject:thisStationObject];
	}

	[thisJSONObject release];
	return [thisObject autorelease];
}

+(NSMutableArray*)getAllHighSpeedStations{
	NSString *urlString=[NSString stringWithFormat:@"%@225&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootJsonDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *stationArray=[NSArray arrayWithArray:(NSArray*)[rootJsonDic objectForKey:@"stationList"]];
	
	for(NSDictionary *thisContentDic in stationArray){
		CommonItem *thisItem=[CommonItem new];
		thisItem.itemKey=(NSString*)[thisContentDic objectForKey:@"stationId"];
		thisItem.itemName=(NSString*)[thisContentDic objectForKey:@"stationName"];
		
		[returnArray addObject:thisItem];
	}
	return returnArray;
}

/**
 查詢兩站之間的所有高鐵動線
 */
+(NSMutableDictionary*)getAllHighSpeedBetweenTwoStations:(NSString*)startStation withEndStation:(NSString*)endStation isDeparture:(BOOL)isDeparture withDuration:(NSInteger)duration withQueryTime:(NSString*)queryTime{
	NSString *departureString=(isDeparture)?@"true":@"false";
	NSString *urlString=[NSString stringWithFormat:@"%@211&startId=%@&destId=%@&queryDate=%@&isDeparture=%@&durationHr=%i&ln=%@",
						 DefaultUrlString,startStation,endStation,queryTime,departureString,duration,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSDictionary *rootDic=[(NSDictionary*)[jsonString JSONValue] objectForKey:@"listInfo"];
	NSMutableDictionary *responseDic=[[NSMutableDictionary dictionaryWithDictionary:rootDic]retain];
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	for(NSDictionary *stationDic in (NSArray*)[rootDic objectForKey:@"trainList"]){
		TrainHSListObject *thisStationObject=[[[TrainHSListObject alloc]initWithTrainName:(NSString*)[stationDic objectForKey:@"trainNo"] withCategoryPicName:(NSString*)[stationDic objectForKey:@"icon"] withBrief:(NSString*)[stationDic objectForKey:@"travelTime"] withDuration:(NSString*)[stationDic objectForKey:@"timeDesc"]]autorelease];
		thisStationObject.trainId=(NSString*)[stationDic objectForKey:@"trainId"];
		[returnArray addObject:thisStationObject];
	}
	[responseDic setObject:returnArray forKey:@"trainList"];
	[thisJSONObject release];
	return [responseDic autorelease];
}

+(TrainInfoObject*)getHighSpeedInfoObjectWithTrainId:(NSString*)trainId withStartId:(NSString*)startId withDestId:(NSString*)destId{
	NSString *urlString=[NSString stringWithFormat:@"%@210&startId=%@&destId=%@&trainId=%@&ln=%@",DefaultUrlString,startId,destId,trainId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSDictionary *rootDic=[jsonString JSONValue];
	NSDictionary *resultDic=(NSDictionary*)[rootDic objectForKey:@"trainInfo"];
	TrainInfoObject *thisObject=[[TrainInfoObject alloc]init];
	thisObject.trainName=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"trainLine"]];
	thisObject.trainSchedule=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"travelTime"]];
	thisObject.categoryPic=[NSString stringWithString:(NSString*)[resultDic objectForKey:@"icon"]];
	thisObject.trainStationArray=[NSMutableArray arrayWithObjects:nil];
	
	NSArray *stationList=(NSArray*)[resultDic objectForKey:@"stationList"];
	for(NSDictionary *thisStation in stationList){
		TrainStationObject *thisStationObject=[[[TrainStationObject alloc]initWithStationName:(NSString*)[thisStation objectForKey:@"name"] 
																			  withArrivedTime:(NSString*)[thisStation objectForKey:@"min"] 
																			  withStationLine:(NSString*)[thisStation objectForKey:@"stationLine"] 
																			  withStationPass:(NSString*)[thisStation objectForKey:@"stationPass"] 
																				withStationId:(NSString*)[thisStation objectForKey:@"stationId"]]autorelease];
		[thisObject.trainStationArray addObject:thisStationObject];
	}
	
	NSArray *driveDay=(NSArray*)[resultDic objectForKey:@"driveDay"];
	int count=0;
	for(NSString *thisPicString in driveDay){
		switch (count) {
			case 0:
				thisObject.sunPic=[NSString stringWithFormat:@"%@",thisPicString];
 				break;
			case 1:
				thisObject.monPic=[NSString stringWithFormat:@"%@",thisPicString];
				break;
			case 2:
				thisObject.tuePic=[NSString stringWithFormat:@"%@",thisPicString];
				break;
			case 3:
				thisObject.wedPic=[NSString stringWithFormat:@"%@",thisPicString];
				break;
			case 4:
				thisObject.thuPic=[NSString stringWithFormat:@"%@",thisPicString];
				break;
			case 5:
				thisObject.friPic=[NSString stringWithFormat:@"%@",thisPicString];
				break;
			case 6:
				thisObject.satPic=[NSString stringWithFormat:@"%@",thisPicString];
				break;
			default:
				break;
		}
		count++;
	}
	[thisJSONObject release];
	return [thisObject autorelease];
}

+(NSMutableArray*)getAllMRTLine{
	NSString *urlString=[NSString stringWithFormat:@"%@219&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootJsonDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *lineList=[NSArray arrayWithArray:(NSArray*)[rootJsonDic objectForKey:@"lineList"]];
	
	for(NSDictionary *thisContentDic in lineList){
		[returnArray addObject:[[[MRTListObject alloc]initWithPicName:(NSString*)[thisContentDic objectForKey:@"icon"] withMRTLineName:(NSString*)[thisContentDic objectForKey:@"name"] withMRTLineId:(NSString*)[thisContentDic objectForKey:@"lineId"]]autorelease]];
	}
	return returnArray;
}

+(NSMutableArray*)getParkingAreaData{
	NSString *urlString=[NSString stringWithFormat:@"%@212&ln=%@",DefaultUrlString,DefaultLanguage];
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootJsonDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *areaList=[NSArray arrayWithArray:(NSArray*)[rootJsonDic objectForKey:@"areaList"]];
	
	for(NSString *areaName in areaList){
		[returnArray addObject:[[[ParkingAreaListCellObject alloc]initWithAreName:areaName withPublicNumber:0 withPrivateNumber:0]autorelease]];
	}
	return returnArray;
}

+(NSMutableArray*)getParkingInfoData:(NSString*)areaName{
	NSString *encodingAreaName=[TrafficDataModel getUTF8EncodingString:areaName];
	NSString *urlString=[NSString stringWithFormat:@"%@214&ln=%@&areaName=%@",DefaultUrlString,DefaultLanguage,encodingAreaName];
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootJsonDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *parkList=[NSArray arrayWithArray:(NSArray*)[rootJsonDic objectForKey:@"parkList"]];
	//[[[ParkingInfoObject alloc]initWithParkingName:@"成淵高中地下停車場" withSpace:0 isPublic:YES]autorelease],
	for(NSDictionary *parkObject in parkList){
		NSString *parkId=(NSString*)[parkObject objectForKey:@"parkId"];
		NSString *name=(NSString*)[parkObject objectForKey:@"name"];
		NSString *address=(NSString*)[parkObject objectForKey:@"address"];
		NSString *surplus=(NSString*)[parkObject objectForKey:@"surplus"];
		NSString *lat=(NSString*)[parkObject objectForKey:@"lat"];
		NSString *lon=(NSString*)[parkObject objectForKey:@"lon"];
		ParkingInfoObject *thisParkingObject=[[ParkingInfoObject alloc]initWithParkingName:name withSpace:[surplus intValue] isPublic:YES];
		thisParkingObject.address=[NSString stringWithString:address];
		thisParkingObject.parkId=[NSString stringWithString:parkId];
		thisParkingObject.lat=[NSString stringWithString:lat];
		thisParkingObject.lon=[NSString stringWithString:lon];
		[returnArray addObject:thisParkingObject];
		[thisParkingObject release];
	}
	return returnArray;
}

+(NSMutableArray*)getParkingDetailInfo:(NSString*)parkingName{
	NSString *encodingParkingName=[TrafficDataModel getUTF8EncodingString:parkingName];
	NSString *urlString=[NSString stringWithFormat:@"%@213&parkName=%@&ln=%@",DefaultUrlString,encodingParkingName,DefaultLanguage];
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootJsonDic=(NSDictionary*)[jsonString JSONValue];
	NSDictionary *parkInfo=(NSDictionary*)[rootJsonDic objectForKey:@"parkInfo"];
	
	DescriptionObject *obj1=[DescriptionObject new];
	obj1.descriptionType=DescriptionTypeTitle;
	obj1.textString=[NSString stringWithString:(NSString*)[parkInfo objectForKey:@"name"]];

	DescriptionObject *obj2=[DescriptionObject new];
	obj2.descriptionType=DescriptionTypeContent;
	obj2.textString=[NSString stringWithString:(NSString*)[parkInfo objectForKey:@"desc"]];

	[returnArray addObject:obj1];
	[returnArray addObject:obj2];
	
	[obj1 autorelease];
	[obj2 autorelease];
	return returnArray;
}

+(NSMutableArray*)getAllPOIData:(NSInteger)type withCentral:(CLLocationCoordinate2D)thisLocation{
	MapSettingDataObject *thisSetting=(MapSettingDataObject*)[TrafficDataModel getMapQuerySetting];
	NSInteger range=thisSetting.distance;
	//公車捷運高鐵停車場
	NSArray *settingArray=[NSArray arrayWithArray:thisSetting.settingArray];
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSMutableArray *tmpArray;
	@try{
		if([((NSNumber*)[settingArray objectAtIndex:0]) intValue]!=0){
			tmpArray=[TrafficDataModel getBusStationLocationList:thisLocation withRange:range];
			[returnArray addObjectsFromArray:tmpArray];
		}
		
		if([((NSNumber*)[settingArray objectAtIndex:1]) intValue]!=0){
			tmpArray=[TrafficDataModel getTRTCLocationList:thisLocation withRange:range];
			[returnArray addObjectsFromArray:tmpArray];
		}
		if([((NSNumber*)[settingArray objectAtIndex:2]) intValue]!=0){
			tmpArray=[TrafficDataModel getHsrLocationList:thisLocation withRange:range];
			[returnArray addObjectsFromArray:tmpArray];
		}
		if([((NSNumber*)[settingArray objectAtIndex:3]) intValue]!=0){
			tmpArray=[TrafficDataModel getParkLocationList:thisLocation withRange:range];
			[returnArray addObjectsFromArray:tmpArray];
		}
	}@catch (NSException *e) {
		NSLog(@"Get Some traffice data error!");
	}
	return returnArray;
}

//206
+(NSMutableArray*)getAllBusLine:(NSString*)startStation withEndStation:(NSString*)endStation{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@206&startStationName=%@&destStationName=%@&ln=%@",DefaultUrlString,startStation,endStation,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *lineList=[rootDic objectForKey:@"lineList"];
	for(NSDictionary *thisLineObject in lineList){
		NSString *icon=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"icon"]];
		NSString *lineTypeId=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineId"]];
		NSString *lineTypeName=[NSString stringWithString: (NSString*)[thisLineObject objectForKey:@"lineTypeName"]];
		NSString *lineName=[NSString stringWithString:(NSString*)[thisLineObject objectForKey:@"lineName"]];
		
		[returnArray addObject:[[[BusSearchCategoryListObject alloc]initWithPicName:icon withBusName:lineTypeName withBusDescription:lineName withLineId:lineTypeId]autorelease]];
	}
	return returnArray;
}

//222
+(MapSettingDataObject*)getMapQuerySetting{
	MapSettingDataObject *thisReturnObject=[MapSettingDataObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@222&userId=%@&ln=%@",DefaultUrlString,DefaultUserId,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSDictionary *settings=(NSDictionary*)[rootDic objectForKey:@"settings"];
	NSArray *display=(NSArray*)[settings objectForKey:@"display"];
	thisReturnObject.distance=[(NSString*)[settings objectForKey:@"distance"] intValue];
	//for traffic map setting
	thisReturnObject.mapSettingType=0;
	thisReturnObject.settingArray=[NSMutableArray arrayWithObjects:nil];
	for(NSString *thisDisplayString in display){
		NSNumber *tmp=[NSNumber numberWithInt:([thisDisplayString isEqualToString:@"true"])?1:0];
		[thisReturnObject.settingArray addObject:tmp];
	}
	return [thisReturnObject autorelease];
}

//223
+(BOOL)setMapQuerySetting:(MapSettingDataObject*)thisDataObject{
	NSMutableString *displayString=[NSMutableString string];
	int count=0;
	for(NSNumber *thisNumber in thisDataObject.settingArray){
		if(count==0)
			[displayString appendFormat:@"%@",(([thisNumber intValue]==0)?@"false":@"true")];
		else
			[displayString appendFormat:@",%@",(([thisNumber intValue]==0)?@"false":@"true")];
		count++;
	}
	
	NSString *urlString=[NSString stringWithFormat:@"%@223&userid=%@&distance=%i&display=%@&ln=%@",DefaultUrlString,DefaultUserId,thisDataObject.distance,displayString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnVale= (NSInteger)[rootDic objectForKey:@"ret"];
	return returnVale;
}
+(NSArray*)getTrafficSearchItems{
	NSArray *returnArray=[NSArray arrayWithObjects:
						  AMLocalizedString(@"BusLineSearch",nil),
						  AMLocalizedString(@"TRTCLineSearch",nil),
						  AMLocalizedString(@"HighSpeedSearch",nil),
						  AMLocalizedString(@"TrainSearch",nil),
						  AMLocalizedString(@"ParkingSearch",nil),
						  nil];
	return returnArray;
}

+(NSArray*)getTrafficSearchItemImages{
	NSArray *returnArray=[NSArray arrayWithObjects:
						  @"contentui_ic_menu_b1.png",
						  @"contentui_ic_menu_b2.png",
						  @"contentui_ic_menu_b3.png",
						  @"contentui_ic_menu_b4.png",
						  @"contentui_ic_menu_b5.png",
						  nil];
	return returnArray;
}
+(NSString*)getUTF8EncodingString:(NSString*)originString{
	NSString *returnString=(NSString*)CFURLCreateStringByAddingPercentEscapes(
																			  NULL,
																			  (CFStringRef)originString,
																			  NULL, 
																			  (CFStringRef)@"!*'();:@&=+$,/?%#[]", 
																			  kCFStringEncodingUTF8);
	return returnString;
}

+(NSMutableArray*)getBusStationLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@208&lat=%f&lon=%f&distance=%i&ln=%@",DefaultUrlString,location.latitude,location.longitude,range,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *stationList=[rootDic objectForKey:@"stationList"];
	for(NSDictionary *thisLocationObject in stationList){
		POI *thisPOI=[POI new];
		CLLocationCoordinate2D poiLocation;
		poiLocation.latitude=[(NSString*)[thisLocationObject objectForKey:@"lat"] doubleValue];
		poiLocation.longitude=[(NSString*)[thisLocationObject objectForKey:@"lon"] doubleValue];
		thisPOI.coordinate=poiLocation;
		thisPOI.title=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.subTitle=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.key=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"stationId"]];
		thisPOI.poiType=poiBusType;
		[returnArray addObject:thisPOI];
		[thisPOI release];
	}
	return returnArray;
}

+(NSMutableArray*)getParkLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@215&lat=%f&lon=%f&distance=%i&ln=%@",DefaultUrlString,location.latitude,location.longitude,range,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *stationList=[rootDic objectForKey:@"parkList"];
	for(NSDictionary *thisLocationObject in stationList){
		POI *thisPOI=[POI new];
		CLLocationCoordinate2D poiLocation;
		poiLocation.latitude=[(NSString*)[thisLocationObject objectForKey:@"lat"] doubleValue];
		poiLocation.longitude=[(NSString*)[thisLocationObject objectForKey:@"lon"] doubleValue];
		thisPOI.coordinate=poiLocation;
		thisPOI.title=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.subTitle=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.key=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"stationId"]];
		thisPOI.poiType=poiParkType;
		[returnArray addObject:thisPOI];
		[thisPOI release];
	}
	return returnArray;
}

+(NSMutableArray*)getTraLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@216&lat=%f&lon=%f&distance=%i&ln=%@",DefaultUrlString,location.latitude,location.longitude,range,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *stationList=[rootDic objectForKey:@"stationList"];
	for(NSDictionary *thisLocationObject in stationList){
		POI *thisPOI=[POI new];
		CLLocationCoordinate2D poiLocation;
		poiLocation.latitude=[(NSString*)[thisLocationObject objectForKey:@"lat"] doubleValue];
		poiLocation.longitude=[(NSString*)[thisLocationObject objectForKey:@"lon"] doubleValue];
		thisPOI.coordinate=poiLocation;
		thisPOI.title=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.subTitle=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.key=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"stationId"]];
		thisPOI.poiType=poiTrainType;
		[returnArray addObject:thisPOI];
		[thisPOI release];
	}
	return returnArray;
}

+(NSMutableArray*)getHsrLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@209&lat=%f&lon=%f&distance=%i&ln=%@",DefaultUrlString,location.latitude,location.longitude,range,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *stationList=[rootDic objectForKey:@"stationList"];
	for(NSDictionary *thisLocationObject in stationList){
		POI *thisPOI=[POI new];
		CLLocationCoordinate2D poiLocation;
		poiLocation.latitude=[(NSString*)[thisLocationObject objectForKey:@"lat"] doubleValue];
		poiLocation.longitude=[(NSString*)[thisLocationObject objectForKey:@"lon"] doubleValue];
		thisPOI.coordinate=poiLocation;
		thisPOI.title=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.subTitle=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.key=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"stationId"]];
		thisPOI.poiType=poiHighSpeedType;
		[returnArray addObject:thisPOI];
		[thisPOI release];
	}
	return returnArray;
}

+(NSMutableArray*)getTRTCLocationList:(CLLocationCoordinate2D)location withRange:(NSInteger)range{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@220&lat=%f&lon=%f&distance=%i&ln=%@",DefaultUrlString,location.latitude,location.longitude,range,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *stationList=[rootDic objectForKey:@"stationList"];
	for(NSDictionary *thisLocationObject in stationList){
		POI *thisPOI=[POI new];
		CLLocationCoordinate2D poiLocation;
		poiLocation.latitude=[(NSString*)[thisLocationObject objectForKey:@"lat"] doubleValue];
		poiLocation.longitude=[(NSString*)[thisLocationObject objectForKey:@"lon"] doubleValue];
		thisPOI.coordinate=poiLocation;
		thisPOI.title=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.subTitle=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"name"]];
		thisPOI.key=[NSString stringWithString:(NSString*)[thisLocationObject objectForKey:@"stationId"]];
		thisPOI.poiType=poiTRTCType;
		[returnArray addObject:thisPOI];
		[thisPOI release];
	}
	return returnArray;
}

+(BOOL)verifyUser{
	NSString *urlString=[NSString stringWithFormat:@"%@414&userId=%@&ln=%@",DefaultUrlString,DefaultUserId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSLog(jsonString);
	NSDictionary *rootJsonDic=(NSDictionary*)[jsonString JSONValue];
	NSInteger returnValue=(NSInteger)[rootJsonDic objectForKey:@"ret"];
	return (returnValue==1)?YES:NO;
}

+(NSString*)getAlertMessage{
    NSString *res;
    @try {
        NSString *urlString=[NSString stringWithString:ALERTMSGURL];
        JSONObject *thisJSONObject=[JSONObject new];
        NSString *response=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
        res=response;
    }
    @catch (NSException *exception) {
        res=AMLocalizedString(@"CloseExpoMsg", nil);
    }
    return res;
}
@end
