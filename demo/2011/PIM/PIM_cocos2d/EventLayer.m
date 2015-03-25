//
//  EventLayer.m
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "EventLayer.h"
#import "FcConfig.h"
#import "FcSprite.h"
static EventLayer *singltonEventLayer=nil;
@implementation EventLayer
@synthesize events;
+(EventLayer*)share{
    if(singltonEventLayer==nil){
        singltonEventLayer=[[EventLayer node] retain];
    }
    return  singltonEventLayer;
}
+(void)releaseEventLayer{
    [singltonEventLayer release];
    singltonEventLayer=nil;
}
-(id)init{
    if((self=[super init])){
        events=[[NSMutableArray array]retain];
    }
    return self;
}

-(void)dealloc{
    [events release];
    [super dealloc];
}

-(void)test_Add_Event{
    for(int i=0;i<300;i++){
        int itemNum=(arc4random()%3)+1;
        int position=arc4random()%24;
        int day=arc4random()%24;
        CCTexture2D *texture=[[CCTextureCache sharedTextureCache]addImage:[NSString stringWithFormat:@"info_icon_00%i.png",itemNum]];
        FcSprite *item=[FcSprite spriteWithTexture:texture];
        item.fc_position=position; // 代表是幾點的事件
        item.fc_angle=7.5+(day*15);
        item.fc_radian=M_PI*item.fc_angle/180.0;
        [events addObject:item];
    }
    [self drawEvent];
}

-(void)drawEvent{
    for (FcSprite *event in events) {
        event.fc_radius=_InnerCircleRadius+_SPACE*event.fc_position; //h
        [event caculateXYFromRadiusAndRadian];
        [self addChild:event];
    }
}

-(void)tuneEventDistance:(NSInteger)distance{
    for (FcSprite *sprite in events) {
        sprite.fc_radius=sprite.fc_radius+distance;
        if (sprite.fc_radius<3) {
            sprite.visible=NO;
            continue;
        }else
            sprite.visible=YES;
        [sprite caculateXYFromRadiusAndRadian];
    }
}
-(void)tuneEventRadian:(double)radian{
    
    for (FcSprite *sprite in events) {
        sprite.fc_radian+=radian;
        [sprite caculateXYFromRadiusAndRadian];
    }
}
@end
