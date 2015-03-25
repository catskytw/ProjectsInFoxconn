//
//  FutureDataObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeatureDataObject.h"


@implementation FeatureDataObject
@synthesize featureId,featureName,featureImageUrlString;

-(void)dealloc{
	[featureId release];
	[featureName release];
	[featureImageUrlString release];
	[super dealloc];
}
@end
