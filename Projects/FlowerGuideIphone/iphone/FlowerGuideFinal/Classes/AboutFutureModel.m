//
//  AboutFutureModel.m
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AboutFutureModel.h"
#import "Vars.h"
#import "JSON.h"
#import "JSONObject.h"
#import "ContentDetailObject.h"
#import "NewsListObject.h"
#import "FeatureDataObject.h"
#import "ToolsFunction.h"
#import "CommonDescriptionObject.h"
#import "AreaListObject.h"
#import "FlowerDataObject.h"
#import "LocalizationSystem.h"
#import "Queue.h"
#import "NSString.h"
@implementation AboutFutureModel
//API 201
+(NSArray*)getNewsList{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@getNewsList%@",DefaultUrlString,InterrLangSurfix];
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return returnArray;
	
	NSArray *objectInfo=(NSArray*)[rootDic objectForKey:@"newsList"];
	for(NSDictionary *newsDic in objectInfo){
		NewsListObject *newsObject=[NewsListObject new];
		newsObject.newsId=[NSString stringWithNullString:(NSString*)[newsDic objectForKey:@"newsId"]];
#ifdef HASTIMESTAMP
		long timestamp=[((NSString*)[newsDic objectForKey:@"newsDate"]) longLongValue]/1000;
		NSDate *newDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
		NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
		[formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
		
		newsObject.date=[formatter stringFromDate:newDate];
#else if
		newsObject.date=[NSString stringWithString:(NSString*)[newsDic objectForKey:@"newsDate"]];
#endif
		newsObject.subject=[NSString stringWithNullString:(NSString*)[newsDic objectForKey:@"subject"]];
		[returnArray addObject:[newsObject autorelease]];
#ifdef HASTIMESTAMP
		[formatter release];
#endif
	}
	return returnArray;
}

//API 202
+(ContentObject*)getNewsContent:(NSString*)newsKey{
	ContentObject *returnObject=[ContentObject new];
	returnObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@getNewsInfo?newsId=%@%@",DefaultUrlString,newsKey,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnObject autorelease];
	
	returnObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *description=(NSArray*)[rootDic objectForKey:@"description"];
	for(NSDictionary *descriptionDic in description){
		ContentDetailObject *thisDetailObject=[ContentDetailObject new];
		thisDetailObject.subject=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"subject"]];
		thisDetailObject.content=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"content"]];
		[returnObject.contentArray addObject:[thisDetailObject autorelease]];
	}
	return [returnObject autorelease];
}

//API 203
+(ContentObject*)getExhibitFeature{
	ContentObject *thisDescriptionObject=[ContentObject new];
	thisDescriptionObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	
	NSString *urlString=[NSString stringWithFormat:@"%@getExhibitionFeature%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [thisDescriptionObject autorelease];
	
	thisDescriptionObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *description=(NSArray*)[rootDic objectForKey:@"description"];
	for(NSDictionary *descriptionDic in description){
		FeatureDataObject *fdo=[FeatureDataObject new];
		fdo.featureId=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"featureId"]];
		fdo.featureName=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"featureName"]];

		int resType=[((NSString*)[descriptionDic objectForKey:@"resType"]) intValue];
			//1為圖片
		if(resType==1)
			fdo.featureImageUrlString=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"resUrl"]];
		[thisDescriptionObject.contentArray addObject:[fdo autorelease]];
	}
	return [thisDescriptionObject autorelease];
}

//API 210
+(ContentObject*)getFeatureContent:(NSString*)featureId{
	ContentObject *thisDescriptionObject=[ContentObject new];
	thisDescriptionObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	
	NSString *urlString=[NSString stringWithFormat:@"%@getFeatureContent?featureId=%@%@",DefaultUrlString,featureId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [thisDescriptionObject autorelease];
	
	thisDescriptionObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *description=(NSArray*)[rootDic objectForKey:@"description"];
	for(NSDictionary *descriptionDic in description){
		CommonDescriptionObject *commonDescription=[CommonDescriptionObject new];
		commonDescription.subject=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"subject"]];
		commonDescription.content=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"content"]];
		[thisDescriptionObject.contentArray addObject:[commonDescription autorelease]];
	}
	
	NSArray *resList=(NSArray*)[rootDic objectForKey:@"resList"];
	for(NSDictionary *resDic in resList){
		int resType=[((NSString*)[resDic objectForKey:@"resType"]) intValue];
		if(resType==1){
			thisDescriptionObject.picUrl=[NSString stringWithNullString:(NSString*)[resDic objectForKey:@"resURL"]];
			break;
		}
	}
	return [thisDescriptionObject autorelease];
}

//API 101
//areaId若為空字串,則為最上層之分類區域
+(NSArray*)getAreaList:(NSString*)areaId{
	NSMutableArray *returnArray=[[NSMutableArray arrayWithObjects:nil]retain];
	NSString *urlString=([areaId isEqualToString:@""])?
	[NSString stringWithFormat:@"%@getAreaList%@",DefaultUrlString,InterrLangSurfix]:
	[NSString stringWithFormat:@"%@getAreaList?areaId=%@%@",DefaultUrlString,areaId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
#ifdef DEBUG_MODE
	NSLog(jsonString);
#endif
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(rootDic==nil ||![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnArray autorelease];
	
	NSArray *objectInfo=(NSArray*)[rootDic objectForKey:@"areaList"];
	for(NSDictionary *areaDic in objectInfo){
		AreaListObject *areaListObject=[[AreaListObject new]autorelease];
		areaListObject.areaId=[NSString stringWithNullString:(NSString*)[areaDic objectForKey:@"areaId"]];
		areaListObject.exhibitId=[((NSString*)[areaDic objectForKey:@"exhibitPtId"]) intValue];
		areaListObject.name=[NSString stringWithNullString:(NSString*)[areaDic objectForKey:@"name"]];
		areaListObject.x=[((NSString*)[areaDic objectForKey:@"ptX"]) intValue];
		areaListObject.y=[((NSString*)[areaDic objectForKey:@"ptY"]) intValue];
		[returnArray addObject:areaListObject];
	}
	return [returnArray autorelease];
}

//API 103
+(ContentObject*)getFlowerListByAreaId:(NSString*)areaId{
	ContentObject *returnDataObject=[ContentObject new];
	returnDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=
	[NSString stringWithFormat:@"%@getFlowerListByAreaId?areaId=%@%@",DefaultUrlString,areaId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnDataObject autorelease];
	
	NSDictionary *areaInfoDic=(NSDictionary*)[rootDic objectForKey:@"areaInfo"];
	
	returnDataObject.title=[NSString stringWithNullString:(NSString*)[areaInfoDic objectForKey:@"name"]];
	NSArray *objectInfo=[NSMutableArray arrayWithNullArray: (NSArray*)[areaInfoDic objectForKey:@"flowerList"]];
	for(NSDictionary *flowerDic in objectInfo){
		FlowerDataObject *tmpObj=[FlowerDataObject new];
		tmpObj.flowerId=[NSString stringWithNullString:(NSString*)[flowerDic objectForKey:@"flowerId"]];
		tmpObj.name=[NSString stringWithNullString:(NSString*)[flowerDic objectForKey:@"name"]];
		tmpObj.desc=[NSString stringWithNullString:(NSString*)[flowerDic objectForKey:@"description"]];
		[returnDataObject.contentArray addObject:[tmpObj autorelease]];
	}
	return [returnDataObject autorelease];
}

//API 105
+(ContentObject*)getFlowerByName:(NSString*)flowerName{
	ContentObject *returnDataObject=[ContentObject new];
	returnDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@getFlowerByName?name=%@%@",DefaultUrlString,flowerName,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
#ifdef DEBUG_MODE
	NSLog(jsonString);
#endif
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnDataObject autorelease];
	returnDataObject.title=[NSString stringWithNullString:AMLocalizedString(@"SearchResult",nil)];
	NSArray *objectInfo=(NSArray*)[rootDic objectForKey:@"flowerList"];
	for(NSDictionary *flowerDic in objectInfo){
		FlowerDataObject *tmpObj=[FlowerDataObject new];
		tmpObj.flowerId=[NSString stringWithNullString:(NSString*)[flowerDic objectForKey:@"flowerId"]];
		tmpObj.name=[NSString stringWithNullString:(NSString*)[flowerDic objectForKey:@"name"]];
		tmpObj.desc=[NSString stringWithNullString:(NSString*)[flowerDic objectForKey:@"description"]];
		[returnDataObject.contentArray addObject:[tmpObj autorelease]];
	}
	return [returnDataObject autorelease];
}


//API 204
+(ContentObject*)getTicketInfo{
	ContentObject *returnDataObject=[ContentObject new];
	returnDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=
	[NSString stringWithFormat:@"%@getTicketInfoList%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnDataObject autorelease];
	
	returnDataObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *description=(NSArray*)[rootDic objectForKey:@"description"];
	for(NSDictionary *descriptionDic in description){
		CommonDescriptionObject *tmpObject=[CommonDescriptionObject new];
		tmpObject.subject=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"subject"]];
		tmpObject.content=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"content"]];
		[returnDataObject.contentArray addObject:[tmpObject autorelease]];
	}
	return [returnDataObject autorelease];
}

//API 205
+(ContentObject*)getVisitNotice{
	ContentObject *returnDataObject=[ContentObject new];
	returnDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=
	[NSString stringWithFormat:@"%@getVisitNoticeList%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnDataObject autorelease];
	
	returnDataObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *description=(NSArray*)[rootDic objectForKey:@"description"];
	for(NSDictionary *descriptionDic in description){
		CommonDescriptionObject *tmpObject=[CommonDescriptionObject new];
		tmpObject.subject=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"subject"]];
		tmpObject.content=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"content"]];
		[returnDataObject.contentArray addObject:[tmpObject autorelease]];
	}
	return [returnDataObject autorelease];
}
+(ContentObject*)getContactInfo{
	ContentObject *returnDataObject=[ContentObject new];
	returnDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=
	[NSString stringWithFormat:@"%@getContactInfoList%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnDataObject autorelease];
	
	returnDataObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *description=(NSArray*)[rootDic objectForKey:@"description"];
	for(NSDictionary *descriptionDic in description){
		CommonDescriptionObject *tmpObject=[CommonDescriptionObject new];
		tmpObject.subject=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"subject"]];
		tmpObject.content=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"content"]];
		[returnDataObject.contentArray addObject:[tmpObject autorelease]];
	}
	return [returnDataObject autorelease];
}

+(NSArray*)getMarquees{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@getMarguee%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return returnArray;
	
	NSArray *objectInfo=(NSArray*)[rootDic objectForKey:@"marguee"];
	for(NSDictionary *marqueesDic in objectInfo){
		[returnArray addObject:(NSString*)[marqueesDic objectForKey:@"subject"]];
	}
	return returnArray;
	
}
@end
