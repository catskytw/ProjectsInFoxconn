//
//  PlayingScene.m
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "PlayingScene.h"
#import "ActionLayer.h"
#import "BackgroundLayer.h"
@implementation PlayingScene
+(CCScene*)scene{
	PlayingScene *newInstance=[PlayingScene node];
	
	BackgroundLayer *bkLayer=(BackgroundLayer*)[BackgroundLayer layer];
	[newInstance addChild:bkLayer];
	
	ActionLayer *actionLayer=[ActionLayer node];
	[newInstance addChild:actionLayer];
	return newInstance;
}
@end
