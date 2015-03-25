//
//  StationInfoObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StationInfoObject : NSObject {
	NSString *stationId;
	//站點圖片名稱 (ex:起站,一般站,終站),用來區分線段
	NSString *stationLineIcon;
	//站名
	NSString *stationName;
	//進站時間
	NSInteger timeMin;
	//時間單位
	NSString *timeUnit;
	//是否為　我的最愛
	BOOL isFavorite;
	//本站屬於哪條線路
	NSString *stationPassIcon;
	BOOL isUrgent;
	double latitude;
	double longitude;
}
@property(nonatomic,retain)NSString *stationId;
@property(nonatomic,retain)NSString *stationLineIcon;
@property(nonatomic,retain)NSString *stationName;
@property(nonatomic,retain)NSString *stationPassIcon;
@property(nonatomic,retain)NSString *timeUnit;
@property(nonatomic)NSInteger timeMin;
@property(nonatomic)BOOL isFavorite;
@property(nonatomic)BOOL isUrgent;
@property(nonatomic)double latitude;
@property(nonatomic)double longitude;
@end
