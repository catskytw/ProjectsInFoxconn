//
//  FlowerContentObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerContentObject.h"


@implementation FlowerContentObject
@synthesize flowerName,flowerContent,flowerImageURL,areaName,exhibitPtId;

-(void)dealloc{
	[areaName release];
	[flowerImageURL release];
	[flowerContent release];
	[flowerName release];
	[super dealloc];
}
@end
