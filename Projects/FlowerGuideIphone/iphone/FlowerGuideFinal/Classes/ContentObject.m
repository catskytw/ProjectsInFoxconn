//
//  ContentObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ContentObject.h"


@implementation ContentObject
@synthesize title,contentArray,picUrl;

-(void)dealloc{
	if(picUrl!=nil)
		[picUrl release];
	if(title!=nil)
		[title release];
	if(contentArray!=nil)
		[contentArray release];
	[super dealloc];
}
@end
