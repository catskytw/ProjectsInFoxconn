//
//  MyFavoriteModel.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteModel.h"
#import "Vars.h"
#import "JSONObject.h"
#import "JSON.h"
#import "DirectoryObject.h"
#import "MyFavoriteBusObject.h"
#import "MyFavoriteBusDetail.h"
#import "MyFavoriteParkObject.h"
#import "MyFavoriteParkDetail.h"
#import "MyFavoriteLifeObject.h"
#import "MyFavoriteLifeDetail.h"
@implementation MyFavoriteModel
+(NSMutableArray*)getFavoriteFolderList:(NSInteger)favType{
	NSString *favString=[MyFavoriteModel converCategoryIntToString:favType];
	NSString *urlString=[NSString stringWithFormat:@"%@408&userId=%@&favType=%@&ln=%@",DefaultUrlString,DefaultUserId,favString,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *folderList=[NSArray arrayWithArray:(NSArray*)[rootDic objectForKey:@"folderList"]];
	
	for(NSDictionary *thisFolder in folderList){
		DirectoryObject *thisDir=[DirectoryObject new];
		thisDir.folderId=[NSString stringWithString: (NSString*)[thisFolder objectForKey:@"folderId"]];
		thisDir.folderName=[NSString stringWithString: (NSString*)[thisFolder objectForKey:@"folderName"]];
		thisDir.itemCount=[NSString stringWithFormat:@"%i",[(NSString*)[thisFolder objectForKey:@"itemCount"]intValue]];
		[returnArray addObject:thisDir];
		[thisDir release];
	}
	[thisJSONObject release];
	return returnArray;
}

+(BOOL)createFavoriteFolder:(NSInteger)categoryType withName:(NSString*)name{
	NSString *favTypeString=[MyFavoriteModel converCategoryIntToString:categoryType];
	NSString *urlString=[NSString stringWithFormat:@"%@407&userId=%@&favType=%@&name=%@&ln=%@",DefaultUrlString,DefaultUserId,favTypeString,name,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}

+(BOOL)deleteFavoriteFolder:(NSString*)folderId{
	NSString *urlString=[NSString stringWithFormat:@"%@410&userId=%@&folderId=%@&ln=%@",DefaultUrlString,DefaultUserId,folderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}

+(BOOL)editFavoriteFolder:(NSString*)folderId withDirName:(NSString*)dirName{
	NSString *urlString=[NSString stringWithFormat:@"%@409&userId=%@&folderId=%@&name=%@&ln=%@",DefaultUrlString,DefaultUserId,folderId,dirName,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}

+(BOOL)addBusFavoriteItem:(NSString*)busLineId withBusStationId:(NSString*)stationId withLeaveMode:(NSString*)leaveString withDestFolderId:(NSString*)destFolderId{
	NSString *leaveMode=([leaveString isEqualToString:@"true"])?@"0":@"1";
	NSString *urlString=[NSString stringWithFormat:@"%@403&phoneNo=%@&busLineId=%@&busStationId=%@&leaveMode=%@&destFolderId=%@&ln=%@",DefaultUrlString,DefaultUserId,busLineId,stationId,leaveMode,destFolderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}
+(NSMutableArray*)getFavoriteButItem:(NSString*)folderId{
	NSString *urlString=[NSString stringWithFormat:@"%@401&phoneNo=%@&folderId=%@&ln=%@",DefaultUrlString,DefaultUserId,folderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *favBusList=(NSArray*)[rootDic objectForKey:@"FavBusList"];
	for(NSDictionary *eachBusDic in favBusList){
		MyFavoriteBusObject *thisObject=[MyFavoriteBusObject new];
		thisObject.busRouteId=[NSString stringWithString: (NSString*)[eachBusDic objectForKey:@"busRouteId"]];
		thisObject.icon=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"icon"]];
		thisObject.isGo=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"isGo"]];
		thisObject.itemId=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"itemId"]];
		thisObject.lat=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"lat"]];
		thisObject.lineName=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"lineName"]];
		thisObject.lon=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"lon"]];
		thisObject.min=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"min"]];
		thisObject.stationId=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"stationId"]];
		thisObject.stationName=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"stationName"]];
		thisObject.urgent=[NSString stringWithString:(NSString*)[eachBusDic objectForKey:@"urgent"]];	
		[returnArray addObject:[thisObject autorelease]];
	}
	[thisJSONObject release];
	return returnArray;
}

+(BOOL)deleteBusFavoriteItem:(NSString*)itemId{
	NSString *urlString=[NSString stringWithFormat:@"%@402&phoneNo=%@&itemId=%@&ln=%@",DefaultUrlString,DefaultUserId,itemId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}

+(BOOL)addParkToFavorite:(NSString*)parkId withDestFolderId:(NSString*)destId{
	NSString *urlString=[NSString stringWithFormat:@"%@406&phoneNo=%@&parkId=%@&destFolderId=%@&ln=%@",DefaultUrlString,DefaultUserId,parkId,destId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}
+(NSMutableArray*)getFavoriteParkingItem:(NSString*)folderId{
	NSString *urlString=[NSString stringWithFormat:@"%@404&phoneNo=%@&folderId=%@&ln=%@",DefaultUrlString,DefaultUserId,folderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *favBusList=(NSArray*)[rootDic objectForKey:@"FavParkList"];
	for(NSDictionary *eachDic in favBusList){
		MyFavoriteParkObject *thisObject=[MyFavoriteParkObject new];
		thisObject.address=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"address"]];
		thisObject.itemId=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"itemId"]];
		thisObject.lat=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"lat"]];
		thisObject.lon=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"lon"]];
		thisObject.parkId=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"parkId"]];
		thisObject.parkName=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"parkName"]];
		thisObject.icon=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"icon"]];
		thisObject.restSpace=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"restSpace"]];
		[returnArray addObject:[thisObject autorelease]];
	}
	[thisJSONObject release];
	return returnArray;
}

+(BOOL)deleteParkFavoriteItem:(NSString*)itemId{
	NSString *urlString=[NSString stringWithFormat:@"%@405&phoneNo=%@&itemId=%@&ln=%@",DefaultUrlString,DefaultUserId,itemId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}

+(NSArray*)getFavLifeItem:(NSString*)folderId{
	NSString *urlString=[NSString stringWithFormat:@"%@412&userId=%@&folderId=%@&ln=%@",DefaultUrlString,DefaultUserId,folderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *favBusList=(NSArray*)[rootDic objectForKey:@"itemList"];
	for(NSDictionary *eachDic in favBusList){
		MyFavoriteLifeObject *thisObject=[MyFavoriteLifeObject new];
		thisObject.address=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"address"]];
		thisObject.itemId=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"itemId"]];
		thisObject.lat=[NSString stringWithFormat:@"%f",[(NSString*)[eachDic objectForKey:@"latitude"]floatValue]];
		thisObject.lon=[NSString stringWithFormat:@"%f",[(NSString*)[eachDic objectForKey:@"longitude"] floatValue]];
		thisObject.name=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"name"]];
		thisObject.storeKey=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"storeKey"]];
		thisObject.tel=[NSString stringWithString:(NSString*)[eachDic objectForKey:@"telephone"]];
		[returnArray addObject:thisObject];
		[thisObject release];
	}
	[thisJSONObject release];
	return returnArray;
}

+(BOOL)addToFavorite:(NSString*)favType withStoreId:(NSString*)storeId withFolderId:(NSString*)folderId{
	NSString *urlString=[NSString stringWithFormat:@"%@411&userId=%@&favType=%@&storeId=%@&folderId=%@&ln=%@",DefaultUrlString,DefaultUserId,favType,storeId,folderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}

//413
+(BOOL)deleteLifeFavoriteItem:(NSString*)folderId withItemId:(NSString*)itemId{
	NSString *urlString=[NSString stringWithFormat:@"%@413&userId=%@&itemId=%@&folderId=%@&ln=%@",DefaultUrlString,DefaultUserId,itemId,folderId,DefaultLanguage];
	NSLog(urlString);
	JSONObject *thisJSONObject=[JSONObject new];
	NSString *jsonString=[thisJSONObject stringWithUrl:[NSURL URLWithString:urlString]];
	
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	BOOL returnResult=((NSInteger)[rootDic objectForKey:@"ret"]==0)?NO:YES;
	[thisJSONObject release];
	return returnResult;
}
//決定要顯示哪個 我的最愛 detail 畫面
+(MyFavoriteDetailTable*)chooseFavoriteDetailViewController:(NSInteger)categoryType withDataObject:(DirectoryObject*)thisDataObject{
	MyFavoriteDetailTable *returnViewController;
	switch (categoryType) {
		case busQuery:
			returnViewController=[[MyFavoriteBusDetail alloc]initWithcategory:categoryType withFolder:thisDataObject.folderName withFolderId:thisDataObject.folderId];
			break;
		case parkingQuery:
			returnViewController=[[MyFavoriteParkDetail alloc]initWithcategory:categoryType withFolder:thisDataObject.folderName withFolderId:thisDataObject.folderId];
			break;
		default:
			returnViewController=[[MyFavoriteLifeDetail alloc]initWithcategory:categoryType withFolder:thisDataObject.folderName withFolderId:thisDataObject.folderId];
			break;
	}
	return [returnViewController autorelease];
}

+(NSString*)converCategoryIntToString:(NSInteger)queryType{
	NSString *returnString;
	switch (queryType) {
		default:
		case busQuery:
			returnString=@"bus";
			break;
		case parkingQuery:
			returnString=@"park";
			break;
		case govermentQuery:
			returnString=@"100";
			break;
		case educationQuery:
			returnString=@"400";
			break;
		case financeQuery:
			returnString=@"300";
			break;
		case enterTainmentQuery:
			returnString=@"500";
			break;
		case accommodationQuery:
			returnString=@"600";
			break;
		case transportationQuery:
			returnString=@"700";
			break;
	}
	return returnString;
}

+(NSInteger)converCategoryStringToInt:(NSString*)queryMainType{
	NSInteger returnQueryType=-1;
	
	if([queryMainType isEqualToString:@"bus"])
		returnQueryType=busQuery;
	else if([queryMainType isEqualToString:@"park"])
		returnQueryType=parkingQuery;
	else if([queryMainType isEqualToString:@"100"])
		returnQueryType=govermentQuery;
	else if([queryMainType isEqualToString:@"300"])
		returnQueryType=financeQuery;
	else if([queryMainType isEqualToString:@"400"])
		returnQueryType=educationQuery;
	else if([queryMainType isEqualToString:@"500"])
		returnQueryType=enterTainmentQuery;
	else if([queryMainType isEqualToString:@"600"])
		returnQueryType=accommodationQuery;
	else if([queryMainType isEqualToString:@"700"])
		returnQueryType=transportationQuery;
		
	return returnQueryType;
}

+(NSString*)getCategoryName:(NSInteger)queryType{
	NSString *returnString;
	switch (queryType) {
		default:
		case busQuery:
			returnString=AMLocalizedString(@"BusInfo",nil);
			break;
		case parkingQuery:
			returnString=AMLocalizedString(@"ParkingInfo",nil);
			break;
		case govermentQuery:
			returnString=AMLocalizedString(@"Goverment",nil);
			break;
		case educationQuery:
			returnString=AMLocalizedString(@"Education",nil);
			break;
		case financeQuery:
			returnString=AMLocalizedString(@"Finance",nil);
			break;
		case enterTainmentQuery:
			returnString=AMLocalizedString(@"EnterTainment",nil);
			break;
		case accommodationQuery:
			returnString=AMLocalizedString(@"Accommodation",nil);
			break;
		case transportationQuery:
			returnString=AMLocalizedString(@"Transportation",nil);
			break;
	}
	return returnString;
}
@end
