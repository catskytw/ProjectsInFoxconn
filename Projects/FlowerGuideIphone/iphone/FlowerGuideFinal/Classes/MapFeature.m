//
//  MapFeature.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapFeature.h"


@implementation MapFeature
@synthesize style;
@synthesize styleObject;
@synthesize featureName;
@synthesize points,drawingArray;
@synthesize addInfo;
@synthesize featureId;
@synthesize yValue;

-(void)dealloc{
	[styleObject release];
	[featureName release];
	[points release];
	[drawingArray release];
	[addInfo release];
	[super dealloc];
}


@end