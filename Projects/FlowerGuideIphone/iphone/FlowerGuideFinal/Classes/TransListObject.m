//
//  TransListObject.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TransListObject.h"


@implementation TransListObject
@synthesize transId,transName;

-(void)dealloc{
	[transId release];
	[transName release];
	[super dealloc];
}
@end
