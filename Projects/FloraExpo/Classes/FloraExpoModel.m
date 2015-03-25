//
//  FloraExpoModel.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloraExpoModel.h"
#import "AreaExhibitionObject.h"
#import "ExhibitionObject.h"
#import "Vars.h"
#import "JSONObject.h"
#import "JSON.h"
#import "NewsObject.h"
#import "DescriptionObject.h"
#import "CommonItem.h"
#import "HotelObject.h"
@implementation FloraExpoModel
+(NSMutableArray*)getFloraExpoContentItemsTitle{
	NSMutableArray *allItems=[NSMutableArray arrayWithObjects:
							  AMLocalizedString(@"News",nil),
							  AMLocalizedString(@"AboutFlora",nil),
							  AMLocalizedString(@"ExhibitionInfo",nil),
							  //AMLocalizedString(@"FlowerInfo",nil),
							  /*
							  @"最新消息",
							  @"關於花博",
							  @"展館資訊",
							  @"花卉資訊",
							  @"有獎問答",
							  @"交通路線規畫",
							  @"參觀路徑導引",
							  @"社群討論",
							  @"花博遊戲",
							  @"手機相關資源",
							  */
							  nil];
	return allItems;
}

-(NSMutableArray*)getFloraExpoContentItemsPicName{
	NSMutableArray *allItems=[NSMutableArray arrayWithObjects:
							  @"contentui_ic_menu_a1.png",
							  @"contentui_ic_menu_a2.png",
							  @"contentui_ic_menu_a3.png",
							  @"contentui_ic_menu_a4.png",
							  @"contentui_ic_menu_a5.png",
							  @"contentui_ic_menu_a6.png",
							  @"contentui_ic_menu_a7.png",
							  @"contentui_ic_menu_a8.png",
							  @"contentui_ic_menu_a9.png",
							  @"contentui_ic_menu_a10.png",
							  nil];
	return allItems;
}

-(NSString*)getFloraExpoContentTitle:(NSInteger)index{
	NSMutableArray *titles=[FloraExpoModel getFloraExpoContentItemsTitle];
	return (NSString*)[titles objectAtIndex:index];
}
-(NSString*)getFloraExpoContentPicName:(NSInteger)index{
	NSMutableArray *pics=[self getFloraExpoContentItemsPicName];
	return (NSString*)[pics objectAtIndex:index];
}

-(NSString*)getFLoraExpoNewsDate:(NSInteger)index{
	return @"";
}
-(NSString*)getFloraExpoNewsContent:(NSInteger)index{
	return @"";
}
+(NSMutableArray*)totalAboutFloratitles{
	NSMutableArray *titles=[NSMutableArray arrayWithObjects:
							AMLocalizedString(@"FloraOrigin",nil),
							AMLocalizedString(@"VisitTime",nil),
							AMLocalizedString(@"VisitNotice",nil),
							AMLocalizedString(@"TicketInfo",nil),
							AMLocalizedString(@"ContactInfo",nil),
							AMLocalizedString(@"Transpostation",nil),
							AMLocalizedString(@"FloraHotel",nil),
							//@"其他縣市花卉情報",
							nil];
	return titles;
}
+(NSString*)getFloraAboutFloraTitle:(NSInteger)index{
	NSMutableArray *titles=[FloraExpoModel totalAboutFloratitles];
	NSString *returnString=(NSString*)[titles objectAtIndex:index];
	return returnString;
}

+(NSString*)getFloraAboutFloraPicName:(NSInteger)index{
	NSMutableArray *picnames=[NSMutableArray arrayWithObjects:
							  @"contentui_ic_menu_a2_1.png",
							  @"contentui_ic_menu_a2_2.png",
							  @"contentui_ic_menu_a2_3.png",
							  @"contentui_ic_menu_a2_4.png",
							  @"contentui_ic_menu_a2_5.png",
							  @"contentui_ic_menu_a2_6.png",
							  @"contentui_ic_menu_a2_7.png",
							  @"contentui_ic_menu_a2_8.png",
							  nil];
	NSString *returnString=(NSString*)[picnames objectAtIndex:index];
	return returnString;
}
+(DescriptionPageDataObject*)getAllAreaExhibitionName{
	DescriptionPageDataObject *thisPageDataObject=[DescriptionPageDataObject new];
	thisPageDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@105&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *groupArray=(NSArray*)[rootDic objectForKey:@"Group"];
	for(int i=0;i<[groupArray count];i++){
		//展館資料之結構相似,借用
		AreaExhibitionObject *thisDataObject=[AreaExhibitionObject new];
		thisDataObject.areaNme=[NSString stringWithFormat:(NSString*)[subjectArray objectAtIndex:i]];
		thisDataObject.allExhibitionNames=[NSMutableArray arrayWithObjects:nil];
		NSDictionary *groupDic=(NSDictionary*)[groupArray objectAtIndex:i];
		NSArray *areaArray=(NSArray*)[groupDic objectForKey:@"Area"];
		for(NSDictionary *exhibiDic in areaArray){
			ExhibitionObject *thisExhibitionObject=[ExhibitionObject new];
			thisExhibitionObject.exhibitionName=[NSString stringWithString:(NSString*)[exhibiDic objectForKey:@"ExhibitionName"]];
			thisExhibitionObject.exhibitionPicName=[NSString stringWithString:(NSString*)[exhibiDic objectForKey:@"PicName"]];
			thisExhibitionObject.key=[NSString stringWithString:(NSString*)[exhibiDic objectForKey:@"id"]];
			[thisDataObject.allExhibitionNames addObject:thisExhibitionObject];
			[thisExhibitionObject release];
		}
		[thisPageDataObject.contentArray addObject:thisDataObject];
		[thisDataObject release];
	}
	thisPageDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisPageDataObject autorelease];
}
//deprecate!
+(ExhibitionDescriptionObject*)getExhibitionDescription:(NSString*)key{
	ExhibitionDescriptionObject *returnObject=[[ExhibitionDescriptionObject alloc]init];
	returnObject.title=@"美術館";
	returnObject.brief=@"大自然與花卉富含人文氣息:美術館";
	returnObject.picName=@"content_img_museum_1.png";
	returnObject.descriptionText=@"花博展出期間將配合主題推出系列「大自然與花卉」美術展出與競賽活動，以美麗與靈感為規劃與展示主題，配合花博以自然環境、地球、綠議題、人文、直觀色彩、東方為策展主軸，規劃六大主題特展，透過莫內與高更的畫筆，欣賞藝術巨擘眼中的大自然。廣邀國內、外之美術工作者、藝術家與相關科系之學生，參與不同定位的演講、研討和競賽等活動。";
	return [returnObject autorelease];
}
//deprecate!
-(NSArray*)getFlowerArea{
	NSArray *returnArray=[NSArray arrayWithObjects:
						  @"熱帶/亞熱帶植物區",
						  @"多肉植物區",
						  @"高山植物區",
						  @"溫帶植物區",
						  @"蘭花展示區",
						  nil];
	return returnArray;
}
//deprecate!
-(NSArray*)getAllFlowerKind{
	NSArray *returnArray=[NSArray arrayWithObjects:
						  @"鬱金香",
						  @"金花石蒜",
						  @"茉莉花",
						  @"百合花",
						  @"蘭花",
						  nil];
	return returnArray;
}
//deprecate!
-(NSArray*)searchFlowerByKey:(NSString*)key{
	NSArray *returnArray=[NSArray arrayWithObjects:
						  @"金針花",
						  @"金花石蒜",
						  @"金線蘭",
						  nil];
	return returnArray;
}

//107
+(NSMutableArray*)getExpoLatestNewList{
	//總共要取幾筆
	int top=20;
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@107&top=%i&ln=%@",DefaultUrlString,top,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	
	NSArray *newsArray=[rootDic objectForKey:@"News"];
	for(NSDictionary *newsDic in newsArray){
		NewsObject *thisNewsObject=[NewsObject new];
		thisNewsObject.dateString=[NSString stringWithString:(NSString*)[newsDic objectForKey:@"Date"]];
		thisNewsObject.newsKey=[NSString stringWithString:(NSString*)[newsDic objectForKey:@"id"]];
		thisNewsObject.newsTitle=[NSString stringWithString:(NSString*)[newsDic objectForKey:@"NewsTitle"]];
		[returnArray addObject:thisNewsObject];
		[thisNewsObject release];
	}
	return returnArray;
}

//116取得新聞詳細內容
+(DescriptionPageDataObject*)getExpoNewsInfo:(NSString*)newsId{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@116&newsId=%@&ln=%@",DefaultUrlString,newsId,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:
								[[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[rootDic objectForKey:@"Subject"]]autorelease],
								[[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[rootDic objectForKey:@"Content"]]autorelease],
								nil];
	return [thisDataObject autorelease];
}

//101
+(DescriptionPageDataObject*)getExpoOriginDesc{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@101&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	for(int i=0;i<[subjectArray count];i++){
		DescriptionObject *subject=[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[subjectArray objectAtIndex:i]];
		DescriptionObject *content=[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[contentArray objectAtIndex:i]];
		[thisDataObject.contentArray addObject:subject];
		[thisDataObject.contentArray addObject:content];
		[subject release];
		[content release];
	}
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisDataObject autorelease];
}

//102參觀時間
+(DescriptionPageDataObject*)getExpoVisittimeDesc{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@102&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	for(int i=0;i<[subjectArray count];i++){
		DescriptionObject *subject=[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[subjectArray objectAtIndex:i]];
		DescriptionObject *content=[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[contentArray objectAtIndex:i]];
		[thisDataObject.contentArray addObject:subject];
		[thisDataObject.contentArray addObject:content];
		[subject release];
		[content release];
	}
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisDataObject autorelease];
}

//111
+(DescriptionPageDataObject*)getExpoContact{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@111&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	for(int i=0;i<[subjectArray count];i++){
		DescriptionObject *subject=[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[subjectArray objectAtIndex:i]];
		DescriptionObject *content=[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[contentArray objectAtIndex:i]];
		[thisDataObject.contentArray addObject:subject];
		[thisDataObject.contentArray addObject:content];
		[subject release];
		[content release];
	}
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisDataObject autorelease];
}

//112
+(DescriptionPageDataObject*)getExpoTicketInfo{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@112&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	for(int i=0;i<[subjectArray count];i++){
		DescriptionObject *subject=[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[subjectArray objectAtIndex:i]];
		DescriptionObject *content=[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[contentArray objectAtIndex:i]];
		[thisDataObject.contentArray addObject:subject];
		[thisDataObject.contentArray addObject:content];
		[subject release];
		[content release];
	}
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisDataObject autorelease];
}

//113
+(DescriptionPageDataObject*)getExpoTrafficInfo{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@113&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	for(int i=0;i<[subjectArray count];i++){
		DescriptionObject *subject=[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[subjectArray objectAtIndex:i]];
		DescriptionObject *content=[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[contentArray objectAtIndex:i]];
		[thisDataObject.contentArray addObject:subject];
		[thisDataObject.contentArray addObject:content];
		[subject release];
		[content release];
	}
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisDataObject autorelease];
}

//117
+(DescriptionPageDataObject*)getExpoVisitNotice{
	DescriptionPageDataObject *thisDataObject=[DescriptionPageDataObject new];
	thisDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@117&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	for(int i=0;i<[subjectArray count];i++){
		DescriptionObject *subject=[[DescriptionObject alloc]initWithType:DescriptionTypeTitle withText:(NSString*)[subjectArray objectAtIndex:i]];
		DescriptionObject *content=[[DescriptionObject alloc]initWithType:DescriptionTypeContent withText:(NSString*)[contentArray objectAtIndex:i]];
		[thisDataObject.contentArray addObject:subject];
		[thisDataObject.contentArray addObject:content];
		[subject release];
		[content release];
	}
	thisDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisDataObject autorelease];
}
//103
+(DescriptionPageDataObject*)getExpoHotelAreaList{
	DescriptionPageDataObject *thisPageDataObject=[DescriptionPageDataObject new];
	thisPageDataObject.contentArray=[NSMutableArray arrayWithObjects:nil];
	NSString *urlString=[NSString stringWithFormat:@"%@103&ln=%@",DefaultUrlString,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *groupArray=(NSArray*)[rootDic objectForKey:@"Group"];
	for(int i=0;i<[subjectArray count];i++){
		//展館資料之結構相似,借用
		AreaExhibitionObject *thisDataObject=[AreaExhibitionObject new];
		thisDataObject.areaNme=[NSString stringWithFormat:(NSString*)[subjectArray objectAtIndex:i]];
		thisDataObject.allExhibitionNames=[NSMutableArray arrayWithObjects:nil];
		
		NSArray *regionId=(NSArray*)[(NSDictionary*)[groupArray objectAtIndex:i] objectForKey:@"RegionId"];
		NSArray *regionNames=(NSArray*)[(NSDictionary*)[groupArray objectAtIndex:i] objectForKey:@"RegionNames"];
		for(int j=0;j<[regionId count];j++){
			ExhibitionObject *thisHotelArea=[ExhibitionObject new];
			thisHotelArea.key=(NSString*)[regionId objectAtIndex:j];
			thisHotelArea.exhibitionName=(NSString*)[regionNames objectAtIndex:j];
			[thisDataObject.allExhibitionNames addObject:thisHotelArea];
			[thisHotelArea release];
		}
		[thisPageDataObject.contentArray addObject:thisDataObject];
		[thisDataObject release];
	}
	thisPageDataObject.title=(NSString*)[rootDic objectForKey:@"Title"];
	return [thisPageDataObject autorelease];
}

+(NSMutableArray*)getExpoHotelListWithKey:(NSString*)key{
	NSMutableArray *returnArray=[NSMutableArray arrayWithObjects:nil];	
	NSString *urlString=[NSString stringWithFormat:@"%@104&districtId=%@&ln=%@",DefaultUrlString,key,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSLog(@"%@",jsonString);
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *group=(NSArray*)[rootDic objectForKey:@"Group"];
	NSDictionary *groupDic=(NSDictionary*)[group objectAtIndex:0];
	NSArray *hotels=(NSArray*)[groupDic objectForKey:@"Hotels"];
	for(NSDictionary *hotel in hotels){
		HotelObject *thisHotelObject=[HotelObject new];
		thisHotelObject.hotelName=(NSString*)[hotel objectForKey:@"HotelName"];
		thisHotelObject.hotelAddress=(NSString*)[hotel objectForKey:@"Address"];
		thisHotelObject.hotelTel=(NSString*)[hotel objectForKey:@"Tel"];
		[returnArray addObject:thisHotelObject];
		[thisHotelObject release];
	}
	return returnArray;
}

//109
+(ExhibitionDescriptionObject*)getExpoExhibitionInfo:(NSString*)exhibitId{
	ExhibitionDescriptionObject *thisDataObject=[ExhibitionDescriptionObject new];
	NSString *urlString=[NSString stringWithFormat:@"%@109&exhibitId=%@&ln=%@",DefaultUrlString,exhibitId,DefaultLanguage];
	NSLog(@"%@",urlString);
	JSONObject *myJson=[JSONObject new];
	NSString *jsonString=[myJson stringWithUrl: [NSURL URLWithString:urlString]];
	NSDictionary *rootDic=(NSDictionary*)[jsonString JSONValue];
	NSArray *subjectArray=(NSArray*)[rootDic objectForKey:@"Subject"];
	NSArray *contentArray=(NSArray*)[rootDic objectForKey:@"Content"];
	
	NSString *desc=[NSString string];
	for(NSString *contentString in contentArray){
		desc=[desc stringByAppendingString:[NSString stringWithFormat:@"%@\n",contentString]];
	}
	thisDataObject.brief=[NSString stringWithString: (NSString*)[rootDic objectForKey:@"Title"]];
	thisDataObject.descriptionText=[NSString stringWithString:desc];
	thisDataObject.picName=[NSString stringWithString:(NSString*)[rootDic objectForKey:@"PicName"]];
	thisDataObject.title=[NSString stringWithString:(NSString*)[subjectArray objectAtIndex:0]];
	return [thisDataObject autorelease];
}
  
@end
