//
//  Tools.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FcConfig.h"
//#define DefaultFontName @"STHeitiTC-Light"

@interface Tools : NSObject {

}
+(CGContextRef)createBitmapContext:(NSInteger)pixelsWide withHeight:(NSInteger)pixelsHigh;
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize;
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize;
@end
