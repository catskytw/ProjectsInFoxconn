//
//  ParkingAreaListCellObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ParkingAreaListCellObject.h"


@implementation ParkingAreaListCellObject
@synthesize areaName;
@synthesize publicNumber;
@synthesize privateNumber;

-(id)initWithAreName:(NSString*)thisAreaName withPublicNumber:(NSInteger)thisPublicNumber withPrivateNumber:(NSInteger)thisPrivateNumber{
	if((self=[super init])){
		areaName=[[NSString stringWithString:thisAreaName]retain];
		publicNumber=thisPublicNumber;
		privateNumber=thisPrivateNumber;
	}
	return self;
}

-(void)dealloc{
	[areaName release];
	[super dealloc];
}
@end
