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

+(NSString*)getProductListString:(NSString*)sKey withSortType:(NSString*)sortString withBrand:(NSString*)brandString withColor:(NSString*)colorString withPrice:(NSString*)priceString;
+(UIColor*)convertString2UIColor:(NSString*)colorString;
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize withFontName:(NSString*)fontName;
+(NSString*)urlEncoding:(NSString*)url;
+(NSString*)formatMoneyString:(NSString*)moneyString;
+(void)FcMessageWindows:(NSString*)contentString withParentView:(UIView*)parentView;
+(void)delWaitCursor;
+(void)addWaitCursor;
+(void)runWaitCursor;
+(NSInteger)detectBaseValue:(int)value withPlusBase:(BOOL)plus;
@end
