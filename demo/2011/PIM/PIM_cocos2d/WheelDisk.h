//
//  ＷheelDisk.h
//  PIM
//
//  Created by 廖 晨志 on 2011/7/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WheelDisk : NSObject {
    @public
    NSMutableArray *pics;
    CCSprite *wheel;
}
+(WheelDisk*)share;
+(void)releaseWheelDisk;
-(void)settingLayer:(CCLayer*)layer;
-(void)settingPic;
-(void)performWholeWheel:(NSInteger)distance;
-(NSInteger)checkRealDistance:(NSInteger)raduis withDistance:(NSInteger)distance;
@end
