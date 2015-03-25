//
//  GoFutureModel.m
//  FlowerGuide
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoFutureModel.h"
#import "Vars.h"
#import "ExhibitionCellObject.h"
#import "JSON.h"
#import "JSONObject.h"
#import "ExhibitPtObject.h"
#import "CommonDescriptionObject.h"
#import "FlowerEntityObject.h"
#import "LocalizationSystem.h"
#import "TransListObject.h"
#import "NSString.h"
#import "NSNullExtend.h"
#import "ToolsFunction.h"
@implementation GoFutureModel

//106
+(ExhibitionInfoObject*)getExhibitPointInfo:(NSString*)exhibitPtId{
	ExhibitionInfoObject *thisObject=[ExhibitionInfoObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@getExhibitPointInfo?areaId=%@%@",DefaultUrlString,exhibitPtId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
#ifdef DEBUG_MODE
	NSLog(jsonString);
#endif
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]]){
		[thisObject release];
		thisObject=nil;
		return thisObject;
	}
	NSDictionary *objectInfo=[rootDic objectForKey:@"exhibitPointInfo"];
	NSArray *neighborArray=(NSArray*)[objectInfo objectForKey:@"neighbor"];
	thisObject.ptName=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"ptName"]];
	thisObject.ptDesc=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"ptDesc"]];
	thisObject.direction=[((NSString*)[objectInfo objectForKey:@"direction"]) intValue];
	thisObject.hasFlower=[((NSString*)[objectInfo objectForKey:@"hasFlower"]) intValue]!=0?YES:NO;
	thisObject.areaId=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"areaId"]];
	thisObject.areaName=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"areaName"]];
	thisObject.neighbor=[NSMutableArray arrayWithObjects:nil];
	for(NSDictionary *neighborDic in neighborArray){
		ExhibitionCellObject *thisNeighbor=[[ExhibitionCellObject new]autorelease];
		thisNeighbor.nExhibitPtId=[NSString stringWithNullString:(NSString*)[neighborDic objectForKey:@"nExhibitPtId"]];
		thisNeighbor.nPtName=[NSString stringWithNullString:(NSString*)[neighborDic objectForKey:@"nPtName"]];
		thisNeighbor.nPtDesc=[NSString stringWithNullString:(NSString*)[neighborDic objectForKey:@"nPtDesc"]];
		[thisObject.neighbor addObject:thisNeighbor];
	}
	return [thisObject autorelease];
}

//108
+(NSMutableArray*)getExhibitPtFacilityList{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@getExhibitPtFacilityList%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return returnArray;
	NSArray *objectInfo=(NSArray*)[rootDic objectForKey:@"objInfo"];
	for(NSDictionary *exhibitPt in objectInfo){
		ExhibitPtObject *ptObject=[ExhibitPtObject new];
		ptObject.exhibitPtId=[NSString stringWithNullString:(NSString*)[exhibitPt objectForKey:@"exhibitptId"]];
		ptObject.exhibitPtName=[NSString stringWithNullString:(NSString*)[exhibitPt objectForKey:@"exhibitPtName"]];
		[returnArray addObject:[ptObject autorelease]];
	}
	return returnArray;
}
//API 102
+(AreaInfoObject*)getAreaInfo:(NSString*)areaId{
	AreaInfoObject *returnObject=[AreaInfoObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@getAreaInfo?areaId=%@%@",DefaultUrlString,areaId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnObject autorelease];
	
	NSDictionary *objectInfo=(NSDictionary*)[rootDic objectForKey:@"areaInfo"];
	NSArray *descList=(NSArray*)[objectInfo objectForKey:@"contentList"];
	NSArray *resList=(NSArray*)[objectInfo objectForKey:@"resourceList"];
	
	returnObject.areaId=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"areaId"]];
	//id tmp=[objectInfo objectForKey:@"parentAreaId"];
	returnObject.parentAreaId=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"parentAreaId"]];
	returnObject.title=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"name"]];
	returnObject.descList=[NSMutableArray arrayWithObjects:nil];
	for(NSDictionary *desc in descList){
		CommonDescriptionObject *thisDesc=[CommonDescriptionObject new];
		thisDesc.subject=[NSString stringWithNullString:(NSString*)[desc objectForKey:@"subject"]];
		thisDesc.content=[NSString stringWithNullString:(NSString*)[desc objectForKey:@"content"]];
		[returnObject.descList addObject:[thisDesc autorelease]];
	}
	
	for(NSDictionary *resDic in resList){
		NSInteger typeString=[((NSString*)[resDic objectForKey:@"type"]) intValue];
		//圖片,取一張
		if(typeString==1){
			returnObject.picURL=[NSString stringWithNullString:(NSString*)[resDic objectForKey:@"url"]];
			break;
		}
	}
	
	return [returnObject autorelease];
}

//API 107
+(FlowerAreaObject*)getFlowerListByExhibitPtId:(NSString*)exhibitPtId{
	FlowerAreaObject *returnObject=[FlowerAreaObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@getFlowerListByExhibitPtId?areaId=%@&sizeType=1%@",DefaultUrlString,exhibitPtId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
#ifdef DEBUG_MODE
	NSLog(jsonString);
#endif
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnObject autorelease];
	
	NSDictionary *areaInfoDic=(NSDictionary*)[rootDic objectForKey:@"areaInfo"];
	returnObject.bgImageString=[NSString stringWithString:(NSString*)[areaInfoDic objectForKey:@"bgImg"]];
	NSArray *flowerList=(NSArray*)[areaInfoDic objectForKey:@"flowerList"];
	returnObject.flowerEntity=[NSMutableArray arrayWithObjects:nil];
	for(NSDictionary *flowerObject in flowerList){
		FlowerEntityObject *ptObject=[FlowerEntityObject new];
		ptObject.flowerId=[NSString stringWithNullString:(NSString*)[flowerObject objectForKey:@"flowerId"]];
		ptObject.flowerName=[NSString stringWithNullString:(NSString*)[flowerObject objectForKey:@"name"]];
		ptObject.imgUrl=[NSString stringWithNullString:(NSString*)[flowerObject objectForKey:@"imgUrl"]];
		ptObject.ptX=[((NSString*)[flowerObject objectForKey:@"ptX"]) intValue];
		ptObject.ptY=[((NSString*)[flowerObject objectForKey:@"ptY"]) intValue];

		[returnObject.flowerEntity addObject:[ptObject autorelease]];
	}
	return [returnObject autorelease];
}

//API 104
+(FlowerContentObject*)getFlowerInfo:(NSString*)flowerId{
	FlowerContentObject *returnObject=[FlowerContentObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@getFlowerInfo?flowerId=%@%@",DefaultUrlString,flowerId,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
#ifdef DEBUG_MODE
	NSLog(jsonString);
#endif
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnObject autorelease];
	
	NSDictionary *objectInfo=(NSDictionary*)[rootDic objectForKey:@"flowerInfo"];
	NSArray *resList=(NSArray*)[objectInfo objectForKey:@"resourceList"];
	for(NSDictionary *resDic in resList){
		NSString *typeString=(NSString*)[resDic objectForKey:@"type"];
		if([typeString intValue]==1){
			returnObject.flowerImageURL=[NSString stringWithNullString:(NSString*)[resDic objectForKey:@"url"]];
			break;
		}
	}
	returnObject.areaName=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"areaName"]];
	returnObject.flowerName=[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"name"]];
	
	NSMutableString *contentString=[NSMutableString string];
	//英文名
	/*
	[contentString appendString:AMLocalizedString(@"f_nameEng",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"eName"]]];
	[contentString appendString:@"\n"];
	 */
	//學名
	[contentString appendString:AMLocalizedString(@"f_scientificName",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"scientificName"]]];
	[contentString appendString:@"\n"];
	//別名
	[contentString appendString:AMLocalizedString(@"f_alias",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"alias"]]];
	[contentString appendString:@"\n"];
	//園藝分類
	[contentString appendString:AMLocalizedString(@"f_category",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"category"]]];
	[contentString appendString:@"\n"];
	//花色
	[contentString appendString:AMLocalizedString(@"f_color",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"color"]]];
	[contentString appendString:@"\n"];
	//花卉描述
	[contentString appendString:AMLocalizedString(@"f_description",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"description"]]];
	[contentString appendString:@"\n"];
	//花期
	[contentString appendString:AMLocalizedString(@"f_duration",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"duration"]]];
	[contentString appendString:@"\n"];
	//科別
	[contentString appendString:AMLocalizedString(@"f_family",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"family"]]];
	[contentString appendString:@"\n"];
	//用途
	[contentString appendString:AMLocalizedString(@"f_fusage",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"usage"]]];
	[contentString appendString:@"\n"];
	//花語
	[contentString appendString:AMLocalizedString(@"f_langOfFlower",nil)];
	[contentString appendString:[NSString stringWithNullString:(NSString*)[objectInfo objectForKey:@"langOfFlower"]]];
	[contentString appendString:@"\n"];
	//備註
	[contentString appendString:AMLocalizedString(@"f_memo",nil)];
	[contentString appendString:([[objectInfo objectForKey:@"memo"] isEqual:[NSNull null]])?@"":(NSString*)[objectInfo objectForKey:@"memo"]];
	[contentString appendString:@"\n"];
	//性狀描述
	[contentString appendString:AMLocalizedString(@"f_shapeDesc",nil)];
	[contentString appendString:([[objectInfo objectForKey:@"shapeDesc"] isEqual:[NSNull null]])?@"":(NSString*)[objectInfo objectForKey:@"shapeDesc"]];
	[contentString appendString:@"\n"];
	//來源
	[contentString appendString:AMLocalizedString(@"f_source",nil)];
	[contentString appendString:([[objectInfo objectForKey:@"source"] isEqual:[NSNull null]])?@"":(NSString*)[objectInfo objectForKey:@"source"]];
	[contentString appendString:@"\n"];
	//特別描述
	[contentString appendString:AMLocalizedString(@"f_specialDesc",nil)];
	[contentString appendString:([[objectInfo objectForKey:@"specialDesc"] isEqual:[NSNull null]])?@"":(NSString*)[objectInfo objectForKey:@"specialDesc"]];
	[contentString appendString:@"\n"];
	returnObject.flowerContent=[NSString stringWithNullString:contentString];
	//exhibitPtId
	returnObject.exhibitPtId=([[objectInfo objectForKey:@"exhibitPtId"] isEqual:[NSNull null]])?-1:[((NSString*)[objectInfo objectForKey:@"exhibitPtId"]) intValue];
	return [returnObject autorelease];
}

//API 207
+(NSArray*)getTransportationTypeList{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@getTransportationTypeList%@",DefaultUrlString,InterrLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return returnArray;
	NSArray *transportation=(NSArray*)[rootDic objectForKey:@"transportation"];
	for(NSDictionary *transDic in transportation){
		TransListObject *tmpObject=[TransListObject new];
		tmpObject.transId=[NSString stringWithNullString:(NSString*)[transDic objectForKey:@"id"]];
		tmpObject.transName=[NSString stringWithNullString:(NSString*)[transDic objectForKey:@"name"]];
		[returnArray addObject:[tmpObject autorelease]];
	}
	return returnArray;
}

//API 208
+(ContentObject*)getTransportationInfo:(NSString*)transKey{
	ContentObject *returnDataObject=[ContentObject new];
	returnDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=
	[NSString stringWithFormat:@"%@getTransportationInfoList?transportationTypeId=%@%@",DefaultUrlString,transKey,AndLangSurfix];
#ifdef DEBUG_MODE
	NSLog(urlString);
#endif
	JSONObject *myJson=[[JSONObject new]autorelease];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	if(![ToolsFunction hasCorrectJSON:(NSString*)[rootDic objectForKey:@"response"]])
		return [returnDataObject autorelease];
	
	returnDataObject.title=[NSString stringWithNullString:(NSString*)[rootDic objectForKey:@"title"]];
	NSArray *descriptionArray=(NSArray*)[rootDic objectForKey:@"transportation"];
	for(NSDictionary *descriptionDic in descriptionArray){
		CommonDescriptionObject *tmpObj=[CommonDescriptionObject new];
		tmpObj.subject=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"subject"]];
		tmpObj.content=[NSString stringWithNullString:(NSString*)[descriptionDic objectForKey:@"content"]];
		[returnDataObject.contentArray addObject:[tmpObj autorelease]];
	}
	return [returnDataObject autorelease];
}
@end
