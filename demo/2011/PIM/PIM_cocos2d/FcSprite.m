//
//  FcSprite.m
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcSprite.h"
#import <math.h>
#import "FcConfig.h"
@implementation FcSprite
@synthesize fc_position,fc_scale,fc_angle,fc_radian,fc_radius;
-(void)caculateXYFromRadiusAndRadian{
    CGPoint loc=CGPointMake(sin((double)self.fc_radian)*self.fc_radius,cos((double)self.fc_radian)*self.fc_radius);
    CGPoint real_loc=ccpAdd(loc, TABLE_ORIGIN_POINT);
    self.position=real_loc;
}
@end
