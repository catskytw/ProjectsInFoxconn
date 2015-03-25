//
//  MaskLayer.m
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MaskLayer.h"
#import "WheelDisk.h"
#import "EventLayer.h"
#import "FcConfig.h"
#define INIT_X 42
#define INIT_Y 77
#define SPACE 57
@implementation MaskLayer
-(id)init{
    if((self=[super init])){
        movableSprites=[[NSMutableArray array]retain];
    }
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    return self;
}
-(void)dealloc{
    [movableSprites release];
    [super dealloc];
}
- (CCSprite*)selectSpriteForTouch:(CGPoint)touchLocation {
    selSprite=nil;
    unSelSprite=nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            selSprite = sprite;
        }else
            unSelSprite= sprite;
    }    
    return  selSprite;
}
-(void)addTimeMeter{
    CCTexture2D *_h_timeMeter_texture=[[CCTextureCache sharedTextureCache] addImage:@"time_1.png"];
    CCTexture2D *_v_timeMeter_texture=[[CCTextureCache sharedTextureCache] addImage:@"time_2.png"];
    CCSprite *_h_timeMeter=[CCSprite spriteWithTexture:_h_timeMeter_texture];
    CCSprite *_v_timeMeter=[CCSprite spriteWithTexture:_v_timeMeter_texture];
    
    CCSprite *_h_mask=[CCSprite spriteWithFile:@"time_1_M_.png"];
    CCSprite *_v_mask=[CCSprite spriteWithFile:@"time_2_M_.png"];
    _h_timeMeter.tag=0;//0代表水平
    _v_timeMeter.tag=1;//1代表垂直
    
    _h_timeMeter.anchorPoint=CGPointZero;
    _v_timeMeter.anchorPoint=CGPointZero;
    _h_mask.anchorPoint=CGPointZero;
    _v_mask.anchorPoint=CGPointZero;
    
    _h_timeMeter.position=CGPointMake(42, 53);
    _v_timeMeter.position=CGPointMake(10, 77);
    
    _h_mask.position=CGPointMake(0, 40);
    _v_mask.position=CGPointMake(8, 0);
    
    CCSprite *calendar=[CCSprite spriteWithFile:@"Calendar_BK.png"];
    calendar.anchorPoint=CGPointZero;
    calendar.position=CGPointZero;
    
    [self addChild:calendar];
    
    [self addChild:_h_timeMeter z:0];
    [self addChild:_v_timeMeter z:0];
    
    [self addChild:_h_mask z:1];
    [self addChild:_v_mask z:1];
    [movableSprites addObject:_h_timeMeter];
    [movableSprites addObject:_v_timeMeter];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
	return YES;
}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    CGPoint originPoint=TABLE_ORIGIN_POINT;
    if(selSprite!=nil){
        if([self isReachBound:selSprite withTranslation:translation])
            return;
        
        selSprite.position=[self meterSpritePosition:translation withSprite:selSprite];
        unSelSprite.position=(selSprite.tag==0)?CGPointMake(unSelSprite.position.x, unSelSprite.position.y+translation.x):CGPointMake(unSelSprite.position.x+translation.y, unSelSprite.position.y);
        
        [[WheelDisk share] performWholeWheel:(selSprite.tag==0)?translation.x:translation.y];
        [[EventLayer share] tuneEventDistance:(selSprite.tag==0)?translation.x:translation.y];
    }else if( CGRectContainsPoint(CGRectMake(originPoint.x, originPoint.y, _WIDTH, _WIDTH), touchLocation) && CGRectContainsPoint(CGRectMake(originPoint.x, originPoint.y, _WIDTH, _WIDTH), oldTouchLocation)){
        CGPoint subPoint1=ccpSub(oldTouchLocation, originPoint);
        CGPoint subPoint2=ccpSub(touchLocation, originPoint);
        double radian=[self caculateRadian:subPoint2 withPoint2:subPoint1];
        if(radian!=radian) return;
        [[EventLayer share] tuneEventRadian:radian];
    }
}

-(CGPoint)meterSpritePosition:(CGPoint)translation withSprite:(CCSprite*)thisSprite{
    return (thisSprite.tag==0)?
    CGPointMake(thisSprite.position.x+translation.x, thisSprite.position.y):CGPointMake(thisSprite.position.x, thisSprite.position.y+translation.y);
}

-(BOOL)isReachBound:(CCSprite*)_selSprite withTranslation:(CGPoint)_translation{
    BOOL r=NO;
    if(_selSprite.tag==0){
        CGFloat x=_selSprite.position.x+_translation.x;
        if(x<(INIT_X-(SPACE*14)) || x>INIT_X) r=YES;
    }else{
        CGFloat y=_selSprite.position.y+_translation.y;
        if(y<(INIT_Y-(SPACE*14)) || y>INIT_Y) r=YES;
    }
    return r;
}


-(double)caculateRadian:(CGPoint)point1 withPoint2:(CGPoint)point2{
    double radian1=atan((double)point1.y/(double)point1.x);
    double radian2=atan((double)point2.y/(double)point2.x);
    return radian2-radian1;
}
@end
