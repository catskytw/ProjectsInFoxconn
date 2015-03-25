//
//  UITuneLayout.h
//  WMBT
//
//  Created by link on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UITuneLayout : NSObject {
    
}
+(void) setNaviTitle: (id)controller;
+(void) setBackground:(id)view;
+(UIColor *)colorWithHex:(UInt32)col;
+(UIColor *)colorWithHexString:(NSString *)str;
+(NSString *)getMoneyString:(NSString *)str;
+(void)delWaitCursor;
+(void)addWaitCursor;
+(void)runWaitCursor;

@end
