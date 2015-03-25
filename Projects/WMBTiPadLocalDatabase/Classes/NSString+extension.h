//
//  NSString+extension.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (extension)
+(NSString*)documentPath;
+(NSString*)fetchFileName:(NSString*)subPath;
@end
