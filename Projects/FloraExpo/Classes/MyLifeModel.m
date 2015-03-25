//
//  MyLifeModel.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeModel.h"
#import "MyLifeTableCellObject.h"
#import "CategoryObject.h"
#import "MyLifeSearchResultObject.h"
#import "DiscountObject.h"
#import "SubCategoryObject.h"
#import "Vars.h"
#import "CommonItem.h"
#import "JSONObject.h"
#import "JSON.h"
#import "TrafficDataModel.h"
#import "DescriptionObject.h"
#import "POI.h"
#import "NSString.h"
@implementation MyLifeModel
+(NSMutableArray*)getAllDirectoryByMyLife{
	MyLifeTableCellObject *object1=[MyLifeTableCellObject new];
	object1.objectName=AMLocalizedString(@"LifeDatabase",nil);
	object1.objectPicName=@"contentui_ic_menu_c1.png";
	//商家促銷活動
	/*
	MyLifeTableCellObject *object2=[MyLifeTableCellObject new];
	object2.objectName=AMLocalizedString(@"PromoteAction",nil);
	object2.objectPicName=@"contentui_ic_menu_c3.png";
	 */
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:object1
								 //,object2
								 ,nil];
	
	[object1 release];
	//[object2 release];
	
	return returnArray;
}

+(NSArray*)getAllArea{
	NSString *urlString=[NSString stringWithFormat:@"%@302&ln=%@",DefaultUrlString,DefaultLanguage];
	
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	CommonItem *noArea=[CommonItem new];
	noArea.itemKey=@"-";
	noArea.itemName=AMLocalizedString(@"AllArea",nil);
	[returnArray addObject:[noArea autorelease]];
	
	NSArray *rootArray=(NSArray*)[jsonString JSONValue];
	
	for(NSDictionary *district in rootArray){
		CommonItem *thisItem=[CommonItem new];
		thisItem.itemKey=[NSString stringWithNullString:(NSString*)[district objectForKey:@"districtKey"]];
		thisItem.itemName=[NSString stringWithNullString:(NSString*)[district objectForKey:@"districtName"]];
		[returnArray addObject:[thisItem autorelease]];
	}
	[thisJSONObject release];
	return returnArray;
}

+(NSArray*)getAllCategory:(NSString*)userId isSetting:(BOOL)isSetting{
	NSString *urlString=[NSString stringWithFormat:@"%@303&userId=%@&ln=%@",DefaultUrlString,userId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSLog(jsonString);
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	/**
	 先建立一個不分類
	 */
	CategoryObject *noCategory=[CategoryObject new];
	SubCategoryObject *noSubCategory=[SubCategoryObject new];
	noCategory.categoryKey=@"-";
	noCategory.mainCategoryName=AMLocalizedString(@"AllCategory",nil);
	noSubCategory.key=@"-";
	noSubCategory.subCategoryName=AMLocalizedString(@"AllCategory",nil);
	
	noCategory.subCategoryNames=[NSArray arrayWithObjects:noSubCategory,nil];
	if(!isSetting)
		[returnArray addObject:noCategory];
	
	NSDictionary *rootArray=(NSDictionary*)[jsonString JSONValue];
	NSArray *Category=(NSArray*)[rootArray objectForKey:@"Category"];
	for(NSDictionary *mainCategoryDic in Category){
		CategoryObject *thisMainCategory=[CategoryObject new];
		thisMainCategory.categoryKey=[NSString stringWithNullString:(NSString*)[mainCategoryDic objectForKey:@"mainCategoryKey"]];
		thisMainCategory.mainCategoryName=[NSString stringWithNullString:(NSString*)[mainCategoryDic objectForKey:@"mainCategoryName"]];
		NSMutableArray *subCategoryArray=[[NSMutableArray arrayWithObjects:nil]retain];
		if(!isSetting)
			[subCategoryArray addObject:noSubCategory];
		
		NSArray *subCategory=(NSArray*)[mainCategoryDic objectForKey:@"subCategory"];
		for(NSDictionary *thisSubCategory in subCategory){
			SubCategoryObject *thisSub=[SubCategoryObject new];
			thisSub.key=[NSString stringWithNullString:(NSString*)[thisSubCategory objectForKey:@"subCategoryKey"]];
			thisSub.subCategoryName=[NSString stringWithNullString:(NSString*)[thisSubCategory objectForKey:@"name"]];
			[subCategoryArray addObject:thisSub];
			[thisSub release];
		}
		thisMainCategory.subCategoryNames=[NSArray arrayWithArray:subCategoryArray];
		[subCategoryArray release];
		[returnArray addObject:[thisMainCategory autorelease]];
		//[thisMainCategory autorelease];
	}
	[noCategory autorelease];
	[noSubCategory autorelease];
	[thisJSONObject release];
	return returnArray;
}

+(NSArray*)getAllSearchResult:(NSString*)maincategoryKey withSubCategoryKey:(NSString*)subKey withDistrictKey:(NSString*)districtKey{
	NSString *encodingDistrictKey=[TrafficDataModel getUTF8EncodingString:districtKey];
	NSString *urlString=[NSString stringWithFormat:@"%@304&mainCategoryKey=%@&subCategoryKey=%@&districtKey=%@&ln=%@",DefaultUrlString,maincategoryKey,subKey,encodingDistrictKey,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	
	NSArray *rootArray=(NSArray*)[jsonString JSONValue];
	
	for(NSDictionary *thisObject in rootArray){
		MyLifeSearchResultObject *thisItem=[MyLifeSearchResultObject new];
		thisItem.address=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"address"]];
		thisItem.lat=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"latitude"]];
		thisItem.lon=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"longitude"]];
		thisItem.mainKey=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"mainCtgryId"]];
		thisItem.objKey=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"storeKey"]];
		thisItem.telephone=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"telephone"]];
		thisItem.name=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"name"]];

		[returnArray addObject:thisItem];
		[thisItem release];
	}
	[thisJSONObject release];
	return returnArray;
}

+(MyLifeDescriptionObject*)getMyLifeDetailInformation:(NSString*)storeKey{
	MyLifeDescriptionObject *thisDescriptionObject=[MyLifeDescriptionObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@307&storeKey=%@&ln=%@",DefaultUrlString,storeKey,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	thisDescriptionObject.address=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"address"]];
	thisDescriptionObject.categoryName=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"categoryName"]];
	thisDescriptionObject.introduction=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"introduction"]];
	thisDescriptionObject.storeName=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"storeName"]];
	thisDescriptionObject.storePicName=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"storePicName"]];
	thisDescriptionObject.telephone=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"telephone"]];
	thisDescriptionObject.day_off=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"day_off"]];
	thisDescriptionObject.email=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"email"]];
	thisDescriptionObject.hour_close=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"hour_close"]];
	thisDescriptionObject.hour_open=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"hour_open"]];
	thisDescriptionObject.web=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"web"]];
	thisDescriptionObject.fax=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"fax"]];


	thisDescriptionObject.indoor_navi=[((NSString*)[rootDic objectForKey:@"indoor_navi"]) intValue];
	thisDescriptionObject.parking=[((NSString*)[rootDic objectForKey:@"parking"]) intValue];
	thisDescriptionObject.payment=[((NSString*)[rootDic objectForKey:@"payment"]) intValue];
	thisDescriptionObject.pet_allow=[((NSString*)[rootDic objectForKey:@"pet_allow"]) intValue];
	thisDescriptionObject.wifi=[((NSString*)[rootDic objectForKey:@"wifi"]) intValue];
	thisDescriptionObject.discountKey=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"discountKey"]];
	[thisJSONObject release];
	return [thisDescriptionObject autorelease];
}

+(NSArray*)getAllDiscountAction{
	NSString *urlString=[NSString stringWithFormat:@"%@305&ln=%@",DefaultUrlString,DefaultLanguage];

	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	
	NSArray *rootArray=(NSArray*)[jsonString JSONValue];
	
	for(NSDictionary *thisObject in rootArray){
		DiscountObject *thisItem=[DiscountObject new];
		thisItem.discountKey=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"discountKey"]];
		thisItem.actionString=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"discountName"]];
		thisItem.durationString=[NSString stringWithNullString:(NSString*)[thisObject objectForKey:@"duration"]];
		[returnArray addObject:thisItem];
		[thisItem release];
	}
	[thisJSONObject release];
	return returnArray;
}

+(DiscountDetailObject*)getDicountDetailInfo:(NSString*)discountKey{
	NSString *urlString=[NSString stringWithFormat:@"%@306&discountKey=%@&ln=%@",DefaultUrlString,discountKey,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSString *place=AMLocalizedString(@"Place",nil);
	NSString *time=AMLocalizedString(@"Time",nil);
	NSString *descriptionString=[NSString stringWithFormat:@"%@\n%@:%@\n%@:%@",(NSString*)[rootDic objectForKey:@"description"],place,(NSString*)[rootDic objectForKey:@"address"],time,(NSString*)[rootDic objectForKey:@"duration"]];

	NSArray *returnArray=[NSArray arrayWithObjects:
						  [[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[rootDic objectForKey:@"discountTitle"]]autorelease],
						  [[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:descriptionString]autorelease],
						  nil];
	
	DiscountDetailObject *returnObject=[DiscountDetailObject new];
	//returnObject.hasDiscount=((NSInteger)[rootDic objectForKey:@"hasDiscountTicket"])?YES:NO;
	returnObject.hasDiscount=NO;
	returnObject.descriptionArray=returnArray;
	[thisJSONObject release];
	return [returnObject autorelease];
}

//取得 mapSetting
+(MapSettingDataObject*)getMapSetting{
	MapSettingDataObject *thisDataObject=[MapSettingDataObject new];
	thisDataObject.settingArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@303&userId=%@&ln=%@",DefaultUrlString,DefaultUserId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	thisDataObject.distance=[[rootDic objectForKey:@"Range"] intValue];
	//我的最愛 mapSetting
	thisDataObject.mapSettingType=1;
	
	NSArray *settedSubCategory=(NSArray*)[rootDic objectForKey:@"selectedKey"];
	for(NSString *thisKey in settedSubCategory){
		[thisDataObject.settingArray addObject:thisKey];
	}
	[thisJSONObject release];
	return [thisDataObject autorelease];
}
//309
+(BOOL)setMapQuerySetting:(MapSettingDataObject*)thisDataObject{
	NSMutableString *displayString=[NSMutableString string];
	int count=0;
	for(NSString *thisSubCategoryKey in thisDataObject.settingArray){
		if(count==0)
			[displayString appendFormat:@"%@",thisSubCategoryKey];
		else
			[displayString appendFormat:@",%@",thisSubCategoryKey];
		count++;
	}
	
	NSString *urlString=[NSString stringWithFormat:@"%@309&userId=%@&range=%i&subCategoryKey=%@&ln=%@",DefaultUrlString,DefaultUserId,thisDataObject.distance,displayString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnVale= (NSInteger)[rootDic objectForKey:@"ret"];
	[myJson release];
	return returnVale;
}

//308
+(NSMutableArray*)getLifeInfoLocationList:(NSInteger)range withLocation:(CLLocationCoordinate2D)location withMainCategory:(NSString*)mainCategoryString withSubCategory:(NSString*)subCategoryString{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@308&lat=%f&long=%f&range=%i&mainCategory=%@&subCategory=%@&ln=%@",DefaultUrlString,location.latitude,location.longitude,range,mainCategoryString,subCategoryString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSArray *rootArray=(NSArray*)[jsonString JSONValue];
	
	for(NSDictionary *thisLocationObject in rootArray){
		POI *thisPOI=[POI new];
		CLLocationCoordinate2D poiLocation;
		poiLocation.latitude=[(NSString*)[thisLocationObject objectForKey:@"latitude"] doubleValue];
		poiLocation.longitude=[(NSString*)[thisLocationObject objectForKey:@"longitude"] doubleValue];
		thisPOI.coordinate=poiLocation;
		thisPOI.title=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"poiName"]];
		thisPOI.subTitle=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"poiName"]];
		thisPOI.key=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"storeKey"]];
		thisPOI.mainCategoryKey=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"mainCategoryKey"]];
		thisPOI.subCategoryKey=[NSString stringWithNullString:(NSString*)[thisLocationObject objectForKey:@"subCategory"]];
		[returnArray addObject:thisPOI];
		[thisPOI release];
	}
	[myJson release];
	return returnArray;
}
@end
