//
//  ParkingInfoObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParkingInfoObject : NSObject {
	//停車場id
	NSString *parkId;
	//停車場名稱
	NSString *parkingName;
	//地址
	NSString *address;
	
	BOOL isPublic;
	//目前幾個空格
	NSInteger spaces;
	NSInteger totoalSpace;
	
	//經緯度
	NSString *lat;
	NSString *lon;
}
@property(nonatomic,retain)NSString *parkId;
@property(nonatomic,retain)NSString *parkingName;
@property(nonatomic,retain)NSString *address;
@property(nonatomic)BOOL isPublic;
@property(nonatomic)NSInteger spaces;
@property(nonatomic)NSInteger totoalSpace;
@property(nonatomic,retain)NSString *lat;
@property(nonatomic,retain)NSString *lon;
-(id)initWithParkingName:(NSString*)thisName withSpace:(NSInteger)thisSpace isPublic:(BOOL)isPublicFlag;
@end
