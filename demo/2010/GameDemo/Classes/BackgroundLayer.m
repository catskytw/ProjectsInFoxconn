//
//  BackgroundLayer.m
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer
+(CCLayer*)layer{
	BackgroundLayer *instance=[BackgroundLayer node];
	
	CCSprite *bk=[CCSprite spriteWithFile:@"animal_bkg.png"];
	bk.anchorPoint=CGPointZero;
	bk.position=CGPointMake(0, 98);
	[instance addChild:bk];
	return instance;
}
@end
