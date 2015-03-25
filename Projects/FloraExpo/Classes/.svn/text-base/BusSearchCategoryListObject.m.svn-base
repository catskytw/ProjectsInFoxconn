//
//  BusSearchCategoryListObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BusSearchCategoryListObject.h"


@implementation BusSearchCategoryListObject
@synthesize busLineName;
@synthesize busLineDescription;
@synthesize picName;
@synthesize lineId;
-(id)initWithPicName:(NSString*)pic withBusName:(NSString*)busName withBusDescription:(NSString*)busDescription withLineId:(NSString*)thisLineId{
	if((self=[super init])){
		picName=[[NSString stringWithFormat:@"%@",pic]retain];
		busLineName=[[NSString stringWithFormat:@"%@",busName]retain];
		busLineDescription=[[NSString stringWithFormat:@"%@",busDescription]retain];
		lineId=[[NSString stringWithString:thisLineId]retain];
	}
	return self;
}

-(void)deaclloc{
	[picName release];
	[busLineName release];
	[busLineDescription release];
	[lineId release];
	[super dealloc];
}
@end
