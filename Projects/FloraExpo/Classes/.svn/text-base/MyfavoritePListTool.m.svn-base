//
//  MyfavoritePListTool.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyfavoritePListTool.h"
#import "MyFavoriteBusObject.h"
#import "Vars.h"
@implementation MyfavoritePListTool
//加入一筆bus favorite資料進plist
//讀出bus favorite array

+(void)writeAllDictionaryToPListFile:(NSDictionary*)inputDictionary{
	[inputDictionary writeToFile:[[NSBundle mainBundle]pathForResource:@"MyFavorite" ofType:@"plist"] atomically:YES];
}

+(NSMutableArray*)getAllDirectoryByCategory:(NSInteger)type{
	NSString *path=[[NSBundle mainBundle]pathForResource:@"MyFavorite" ofType:@"plist"];
	NSMutableDictionary *allDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];
	NSMutableArray *targetArray=(NSMutableArray*)[[allDic valueForKey:[MyfavoritePListTool convertPoitypeToPoistring:type]] allKeys];
	return targetArray;
}

+(NSString*)convertPoitypeToPoistring:(NSInteger)poiType{
	NSString *returnString=nil;
	switch (poiType) {
		case poiBusType:
			returnString=@"Bus";
			break;
		case poiParkType:
			returnString=@"Parking";
			break;
		default:
			break;
	}
	return returnString;
}
@end
