//
//  FlowerDataObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerDataObject.h"


@implementation FlowerDataObject
@synthesize flowerId,name,desc;

-(void)dealloc{
	[flowerId release];
	[name release];
	[desc release];
	[super dealloc];
}
@end
