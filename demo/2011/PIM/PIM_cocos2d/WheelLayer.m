//
//  HelloWorldLayer.m
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/27.
//  Copyright foxconn 2011年. All rights reserved.
//


// Import the interfaces
#import "WheelLayer.h"
#import "WheelDisk.h"
#import "HomeScene.h"
#import "FcConfig.h"
// HelloWorldLayer implementation
@implementation WheelLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        [[WheelDisk share] settingLayer:self];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
