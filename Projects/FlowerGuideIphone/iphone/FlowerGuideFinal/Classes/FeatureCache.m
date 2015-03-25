//
//  FeatureCache.m
//  FlowerGuide
//
//  Created by Liao Change on 10/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeatureCache.h"

static NSMutableDictionary *pointFeatureCache;
static NSMutableDictionary *lineFeatureCache;
static NSMutableDictionary *regionFeatureCache;
@implementation FeatureCache
+(NSMutableDictionary*)currentPointFeatureCache{
	if(pointFeatureCache==nil)
		pointFeatureCache=[[NSMutableDictionary dictionaryWithObjectsAndKeys:nil]retain];
	return pointFeatureCache;
}
+(NSMutableDictionary*)currentLineFeatureCache{
	if(lineFeatureCache==nil)
		lineFeatureCache=[[NSMutableDictionary dictionaryWithObjectsAndKeys:nil]retain];
	return lineFeatureCache;
}
+(NSMutableDictionary*)currentRegionFeatureCache{
	if(regionFeatureCache==nil)
		regionFeatureCache=[[NSMutableDictionary dictionaryWithObjectsAndKeys:nil]retain];
	return regionFeatureCache;
}

+(void)releaseCache{
	[pointFeatureCache removeAllObjects];
	[lineFeatureCache removeAllObjects];
	[regionFeatureCache removeAllObjects];
	[pointFeatureCache release];
	[lineFeatureCache release];
	[regionFeatureCache release];
}
@end
