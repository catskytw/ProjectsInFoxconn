//
//  ParkingInfoObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ParkingInfoObject.h"

/*
 @property(nonatomic,retain)NSString *parkId;
 @property(nonatomic,retain)NSString *parkingName;
 @property(nonatomic,retain)NSString *address;
 @property(nonatomic)BOOL isPublic;
 @property(nonatomic)NSInteger spaces;
 @property(nonatomic)NSInteger totoalSpace;
 @property(nonatomic,retain)NSString *lat;
 @property(nonatomic,retain)NSString *lon;
 */
@implementation ParkingInfoObject
@synthesize parkId;
@synthesize address;
@synthesize isPublic;
@synthesize parkingName;
@synthesize spaces;
@synthesize totoalSpace;
@synthesize lon;
@synthesize lat;
-(id)initWithParkingName:(NSString*)thisName withSpace:(NSInteger)thisSpace isPublic:(BOOL)isPublicFlag{
	if((self=[super init])){
		parkingName=[[NSString stringWithString:thisName]retain];
		isPublic=isPublicFlag;
		spaces=thisSpace;
	}
	return self;
}

-(void)dealloc{
	[parkingName release];
	[super dealloc];
}
@end
