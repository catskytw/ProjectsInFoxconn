//
//  ExhibitionObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExhibitionObject.h"


@implementation ExhibitionObject
@synthesize exhibitionPicName;
@synthesize exhibitionName;
@synthesize key;

-(id)initWithName:(NSString*)name withPicName:(NSString*)bitmapName withKey:(NSString*)keyString{
	if((self=[super init])){
		exhibitionName=[[NSString stringWithString:name] retain];
		exhibitionPicName=[[NSString stringWithString:bitmapName]retain];
		key=[[NSString stringWithString:keyString]retain];
	}
	return self;
}
-(void)dealloc{
	[exhibitionName release];
	[exhibitionPicName release];
	[key release];
	[super dealloc];
}
@end
