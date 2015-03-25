//
//  Edge.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"


@implementation Edge
@synthesize startPoint;
@synthesize endPoint;
@synthesize edgeName;
@synthesize parent;
@synthesize fValue;
@synthesize hValue;

-(id)initWithStartpoint:(NSString*)thisStartPoint withEndpoint:(NSString*)thisEndpoint withCost:(NSInteger)cost withEdgename:(NSString*)thisEdgename{
	if((self=[super init])){
		startPoint=[[NSString stringWithFormat:@"%@", thisStartPoint]retain];
		endPoint=[[NSString stringWithFormat:@"%@", thisEndpoint]retain];
		hValue=cost;
		edgeName=[[NSString stringWithFormat:@"%@", thisEdgename]retain];
	}
	return self;
}
-(void)dealloc{
	[startPoint release];
	[endPoint release];
	[edgeName release];
	[super dealloc];
}
@end
