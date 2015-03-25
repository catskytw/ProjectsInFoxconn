//
//  TrainHSListObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrainHSListObject.h"


@implementation TrainHSListObject
@synthesize trainId;
@synthesize categoryPicName;
@synthesize trainName;
@synthesize briefString;
@synthesize durationString;

-(id)initWithTrainName:(NSString*)thisTrainName withCategoryPicName:(NSString*)picName withBrief:(NSString*)brief withDuration:(NSString*)duration{
	if((self=[super init])){
		categoryPicName=[[NSString stringWithFormat:@"%@",picName]retain];
		trainName=[[NSString stringWithFormat:@"%@",thisTrainName]retain];
		briefString=[[NSString stringWithFormat:@"%@",brief]retain];
		durationString=[[NSString stringWithFormat:@"%@",duration]retain];
	}
	return self;
}

-(void)dealloc{
	[categoryPicName release];
	[trainName release];
	[briefString release];
	[durationString release];
	[super dealloc];
}
@end
