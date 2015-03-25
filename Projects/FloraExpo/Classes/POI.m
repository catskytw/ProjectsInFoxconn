//
//  POI.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "POI.h"


@implementation POI
@synthesize title,key;
@synthesize subTitle,mainCategoryKey,subCategoryKey;
@synthesize coordinate;
@synthesize poiType;
-(id)initWithCoords:(CLLocationCoordinate2D)coords withTitle:(NSString*)poiTitle withSubTitle:(NSString*)poiSubTitle{
	if((self=[super init])){
		coordinate=coords;
		title=[[NSString stringWithString:poiTitle]retain];
		subTitle=[[NSString stringWithString:poiSubTitle]retain];
	}
	return self;
}

-(void)dealloc{
	[title release];
	[subTitle release];
	[super dealloc];
}
@end
