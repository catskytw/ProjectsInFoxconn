//
//  WheelDisk.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WheelDisk : NSObject {
    @public
    CGFloat _offset;
    CGContextRef context;
}
+(WheelDisk*)share;
+(void)releaseWheelDisk;
-(CGImageRef)performWholeWheel:(NSInteger)distance;
@end
