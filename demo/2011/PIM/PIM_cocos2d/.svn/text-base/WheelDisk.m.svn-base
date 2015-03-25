//
//  ＷheelDisk.m
//  PIM
//
//  Created by 廖 晨志 on 2011/7/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "WheelDisk.h"
#import "FcSprite.h"
#import "FcConfig.h"


static WheelDisk *singleton=nil;
@interface WheelDisk (PrivateMethod)
-(CCSprite*)collectAllSprite;
@end
@implementation WheelDisk
+(WheelDisk*)share{
    if(singleton==nil){
        singleton=[WheelDisk new];
        singleton->wheel=[[CCSprite node]retain];
        singleton->pics=[[NSMutableArray array]retain];
        [singleton settingPic];
    }
    return singleton;
}
+(void)releaseWheelDisk{
    [singleton->wheel release];
    for (FcSprite *r in singleton->pics)
        [r release];
    [singleton->pics release];
    [singleton release];
    singleton=nil;
}
-(void)settingLayer:(CCLayer*)layer{
    for(FcSprite *r in pics){
        r.anchorPoint=CGPointZero;
        r.position=TABLE_ORIGIN_POINT;
        [layer addChild:r];
    }
}
-(void)settingPic{
    BOOL flag=YES;

    for(int i=0;i<_MAXWHEELNUM;i++){
        CCTexture2D *text2d=[[CCTextureCache sharedTextureCache]addImage:(flag)?@"01.png":@"02.png"];
        
        FcSprite *_wheel=[FcSprite spriteWithTexture:text2d];
        flag=!flag;
        
        float radius=_InnerCircleRadius+(24*57)-(_SPACE*i);
        _wheel.fc_position=radius;
        _wheel.scaleX=(radius<_InnerCircleRadius)?_MinCircle:(float)(radius*_BaseRate);
        _wheel.scaleY=_wheel.scaleX;
        _wheel.fc_scale=_wheel.scaleX;
        [pics addObject:[_wheel retain]];
    }
}
-(void)performWholeWheel:(NSInteger)distance{
    for (FcSprite *r in pics) {
        NSInteger radius=r.fc_position;
        NSInteger newRadius=radius+distance;
        r.fc_position=newRadius;
        /*
         pseudo code:
         if(!新舊半徑均在可視範圍之外)
         */
        if(!((newRadius<_InnerCircleRadius && radius< _InnerCircleRadius) || (newRadius>_WIDTH && radius>_WIDTH))){
            float newScale=(float)(newRadius*_BaseRate); 
            r.fc_scale=newScale;
            r.tag=1; // 借用,1表示要做scale; 0則否
        }else r.tag=0;
    }
    
    for (FcSprite *r in pics) {
        if (r.tag) {
            r.scaleX=r.fc_scale;
            r.scaleY=r.fc_scale;
        }
    }
}

-(NSInteger)checkRealDistance:(NSInteger)raduis withDistance:(NSInteger)distance{
    NSInteger total=raduis+distance;
    if (total>_LargeCircleRaduis) {
        return (NSInteger)_LargeCircleRaduis-raduis;
    }else if(total<_WIDTH)
        return (NSInteger)raduis-_WIDTH;
    else
        return distance;
}
@end
