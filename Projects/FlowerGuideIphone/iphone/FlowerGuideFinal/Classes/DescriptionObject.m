//
//  DescriptionObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DescriptionObject.h"


@implementation DescriptionObject
@synthesize descriptionType;
@synthesize textString;
-(id)initWithType:(NSInteger)type withText:(NSString*)text{
	if((self=[super init])){
		descriptionType=type;
		textString=[[NSString stringWithString:text]retain];
	}
	return self;
}
-(void)dealloc{
	[textString release];
	[super dealloc];
}
@end
