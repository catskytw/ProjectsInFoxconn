//
//  NSString+extension.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "NSString+extension.h"


@implementation NSString (extension)
+(NSString*)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+(NSString*)fetchFileName:(NSString*)subPath{
    NSArray *s=[subPath componentsSeparatedByString:@"/"];
    return [s objectAtIndex:[s count]-1];
}
@end
