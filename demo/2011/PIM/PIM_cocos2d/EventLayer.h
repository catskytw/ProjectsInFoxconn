//
//  EventLayer.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface EventLayer : CCLayer {
    NSMutableArray *events;
}
@property(nonatomic,retain)NSMutableArray *events;
+(EventLayer*)share;
+(void)releaseEventLayer;
-(void)test_Add_Event;
-(void)drawEvent;
-(void)tuneEventDistance:(NSInteger)distance;
-(void)tuneEventRadian:(double)radian;
@end
