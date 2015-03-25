//
//  WheelDisk.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "WheelDisk.h"
#import "ProjectTool.h"
#import "FcConfig.h"
static WheelDisk *singleton=nil;
@interface WheelDisk(PrivateMethod)
-(CGImageRef)drawWheel;
-(void)drawingArc:(NSInteger)drawingArc_radius;
@end
@implementation WheelDisk
+(WheelDisk*)share{
    if(singleton==nil){
        singleton=[WheelDisk new];
        singleton->context=[ProjectTool createBitmapContext:_WIDTH withHeight:_WIDTH];
        CGContextSetShouldAntialias(singleton->context, YES);
        singleton->_offset=0;
        CGContextSetRGBFillColor(singleton->context, 0.832, 0.852, 0.89, 1);
        CGContextSetLineWidth(singleton->context, 1);
    }
    return singleton;
}

+(void)releaseWheelDisk{
    [singleton release];
    singleton=nil;
}

-(CGImageRef)performWholeWheel:(NSInteger)distance{
    _offset+=distance;
    return [self drawWheel];
}
-(void)drawingArc:(NSInteger)drawingArc_radius{
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context,(CGFloat) 238.0f/256.0f, (CGFloat)240.0f/256.0f, (CGFloat)244.0f/256.0f, 1.0f);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddArc(context, 0, 0, drawingArc_radius, 0, 90, 0);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context,(CGFloat) 202.0f/256.0f, (CGFloat)205.0f/256.0f, (CGFloat)210.0f/256.0f, 1);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddArc(context, 0, 0, drawingArc_radius+1, 0, 90, 0);
    CGContextClosePath(context);
    CGContextStrokePath(context);
}
-(CGImageRef)drawWheel{
    NSInteger m_offset=(NSInteger)ceil((double) _offset);
    
    NSInteger m_clipOffset=m_offset%_SPACE;
    NSInteger m_radius=_InnerCircleRadius+m_clipOffset;
    CGContextClearRect(context, CGRectMake(0, 0, _WIDTH, _WIDTH));
    CGContextFillRect(context,CGRectMake(0, 0, _WIDTH, _WIDTH));
    do {
        if (m_radius>=_InnerCircleRadius) {
            [self drawingArc:m_radius];
        }
        m_radius+=_SPACE;
    } while (m_radius<=_WIDTH);
    
    return CGBitmapContextCreateImage(context);
}

@end
