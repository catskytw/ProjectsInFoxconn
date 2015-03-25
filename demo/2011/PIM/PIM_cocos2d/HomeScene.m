//
//  HomeScene.m
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "HomeScene.h"
#import "WheelDisk.h"
#import "WheelLayer.h"
#import "FcConfig.h"
#import "MaskLayer.h"
#import "EventLayer.h"
@implementation HomeScene
-(id)init{
    if((self=[super init])){
        WheelLayer *layer = [WheelLayer node];
        MaskLayer *maskLayer=[[MaskLayer node]retain];
        [maskLayer addTimeMeter];
        [[EventLayer share] test_Add_Event];
        [self addChild: layer z:WheelLayer_NUM];
        [self addChild: [EventLayer share] z:EventLayer_NUM];
        [self addChild: maskLayer z:MaskLayer_NUM];
    }
    return self;
}
-(void)dealloc{
    [super dealloc];
}
@end
