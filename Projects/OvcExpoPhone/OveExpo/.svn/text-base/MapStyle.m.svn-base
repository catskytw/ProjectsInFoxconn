//
//  MapFeature.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapStyle.h"


@implementation MapStyle
@synthesize red;
@synthesize blue;
@synthesize green;
@synthesize alpha;
-(id)initWithColorData:(NSData*)colorData{
	if((self=[super init])){
		[colorData getBytes:&alpha range:NSMakeRange(0, 1)];
		[colorData getBytes:&red range:NSMakeRange(1, 1)];
		[colorData getBytes:&green range:NSMakeRange(2, 1)];
		[colorData getBytes:&blue range:NSMakeRange(3, 1)];
	}
	return self;
}

@end
