//
//  MapLine.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapLine.h"


@implementation MapLine
@synthesize width;
@synthesize pattern;
-(id)initWithColorData:(NSData*)colorData withWidth:(NSData*)widthData withPattern:(NSData*)patternData{
	if((self=[super initWithColorData:colorData])){
		[widthData getBytes:&width range:NSMakeRange(0, 1)];
		[patternData getBytes:&pattern range:NSMakeRange(0, 1)];
	}
	return self;
}
@end
