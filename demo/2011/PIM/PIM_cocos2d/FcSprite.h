//
//  FcSprite.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface FcSprite : CCSprite {
    NSInteger fc_position; //用來紀錄各種不同情況下sprite的位置
    float fc_scale;
    float fc_angle;
    float fc_radius;
    double fc_radian;
}
@property(nonatomic)NSInteger fc_position;
@property(nonatomic)float fc_scale,fc_angle,fc_radius;
@property(nonatomic)double fc_radian;
-(void)caculateXYFromRadiusAndRadian;
@end
