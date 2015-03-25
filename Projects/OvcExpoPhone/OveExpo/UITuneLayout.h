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
+(NSString*) getHMTimeString:(NSString*)timestampString;
+(NSString*) getDateString:(NSString*)timestampString;
+(NSString*) getTimestamp:(NSString*)timestampString withKey:(NSString*) skey;
+(void)linkTwoLabel:(UILabel*)first fontsize:(int) fsize secondLabel:(UILabel*)second;
+(void)delWaitCursor;
+(void)addWaitCursor;
+(void)runWaitCursor;
+(NSString*) checkQueryStr:(NSString*)input;
+(NSString*)floorName:(NSInteger)floorType;
@end
