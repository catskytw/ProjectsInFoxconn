//
//  AreaListObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AreaListObject.h"


@implementation AreaListObject
@synthesize areaId,exhibitId,name,x,y;

-(void)dealloc{
	[areaId release];
	[name release];
	[super dealloc];
}
@end
