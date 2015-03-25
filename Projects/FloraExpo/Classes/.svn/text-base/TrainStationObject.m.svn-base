//
//  TrainStationObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrainStationObject.h"


@implementation TrainStationObject
@synthesize stationPassPic;
@synthesize stationLinePic;
@synthesize stationName;
@synthesize arrivedTime;
@synthesize stationId;
-(id)initWithStationName:(NSString*)station withArrivedTime:(NSString*)arriving withStationLine:(NSString*)linePic withStationPass:(NSString*)passPic withStationId:(NSString*)thisStationId{
	if((self=[super init])){
		stationName=[[NSString stringWithString:station]retain];
		arrivedTime=[[NSString stringWithString:arriving]retain];
		stationPassPic=[[NSString stringWithString:passPic]retain];
		stationLinePic=[[NSString stringWithString:linePic]retain];
		stationId=[[NSString stringWithString:thisStationId]retain];
	}
	return self;
}

-(void)dealloc{
	[stationName release];
	[arrivedTime release];
	[stationPassPic release];
	[stationLinePic release];
	[stationId release];
	[super dealloc];	
}
@end
