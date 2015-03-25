//
//  AresStationObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AreaStationObject.h"


@implementation AreaStationObject
@synthesize areaName;
@synthesize stationArray;
-(id)initWithAreaName:(NSString*)name withStationArray:(NSMutableArray*)stations{
	if((self=[super init])){
		areaName=[[NSString stringWithFormat:@"%@",name]retain];
		stationArray=[[NSArray arrayWithArray:stations]retain];
	}
	return self;
}

-(void)dealloc{
	[areaName release];
	[stationArray release];
	[super dealloc];
}
@end
