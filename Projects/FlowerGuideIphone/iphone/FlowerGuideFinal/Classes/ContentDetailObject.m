//
//  ContentDetailObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentDetailObject.h"


@implementation ContentDetailObject
@synthesize subject,content;

-(void)dealloc{
	[subject release];
	[content release];
	[super dealloc];
}
@end
