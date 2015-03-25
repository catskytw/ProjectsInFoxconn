//
//  CommonItem.m
//  FloraExpo2010
//
//  Created by Liao Change on 8/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommonItem.h"


@implementation CommonItem
@synthesize itemKey;
@synthesize itemName;
@synthesize itemPic;

-(id)initWithItemKey:(NSString*)key withItemName:(NSString*)name{
	if((self=[super init])){
		itemKey=[[NSString stringWithString:key]retain];
		itemName=[[NSString stringWithString:name]retain];
		itemPic=nil;
	}
	return self;
}

-(id)initWithItemKey:(NSString*)key withItemName:(NSString*)name withItemPic:(NSString*)picName{
	if((self=[super init])){
		itemKey=[[NSString stringWithString:key]retain];
		itemName=[[NSString stringWithString:name]retain];
		itemPic=[[NSString stringWithString:picName]retain];
	}
	return self;
}

-(void)dealloc{
	[itemKey release];
	[itemName release];
	if(itemPic!=nil)
		[itemPic release];
 	[super dealloc];
}
@end
