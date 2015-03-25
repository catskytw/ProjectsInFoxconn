//
//  Tools.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tools : NSObject {

}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize;
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize;
+(NSString *)getMoneyString:(NSString *)str;
+(NSString *)getMoneyStringF32:(Float32)f32;

+(UIColor*)convertString2UIColor:(NSString*)colorString;

+(NSString*)urlEncoding:(NSString*)url;

+(void)delWaitCursor;
+(void)addWaitCursor;
+(void)runWaitCursor;
+(BOOL)checkQureyResponse:(NSString*)sResponse;
+(BOOL)isPopToRoot;
+(void)setPopToRoot:(BOOL)bRoot;
@end
