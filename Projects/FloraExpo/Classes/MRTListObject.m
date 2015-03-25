//
//  MRTListObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MRTListObject.h"


@implementation MRTListObject
@synthesize picName;
@synthesize mrtLineName;
@synthesize mrtLineId;
-(id)initWithPicName:(NSString*)myPicName withMRTLineName:(NSString*)myMRTLineName withMRTLineId:(NSString*)lineId{
	if((self=[super init])){
		picName=[[NSString stringWithString:myPicName]retain];
		mrtLineName=[[NSString stringWithString:myMRTLineName]retain];
		mrtLineId=[[NSString stringWithString:lineId]retain];
	}
	return self;
}

-(void)dealloc{
	[picName release];
	[mrtLineName release];
	[super dealloc];
}
@end
