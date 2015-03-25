//
//  MapRegion.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapRegion.h"


@implementation MapRegion
@synthesize regionLine;
-(id)initWithColorData:(NSData*)colorData withLineData:(NSData*)lineData{
	if((self=[super initWithColorData:colorData])){
		regionLine=[[MapLine alloc]initWithColorData:[lineData subdataWithRange:NSMakeRange(0, 4)] withWidth:[lineData subdataWithRange:NSMakeRange(5, 1)] withPattern:[lineData subdataWithRange:NSMakeRange(4, 1)]];
	}
	return self;
}

-(void)dealloc{
	[regionLine release];
	[super dealloc];
}
@end
