//
//  NSString.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/4/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "NSStringSupport.h"


@implementation NSString(Support)
- (NSComparisonResult) psuedoNumericCompare:(NSString *)otherString {
    
    NSString *left  = self;
    NSString *right = otherString;
    NSInteger leftNumber, rightNumber;
    
    
    NSScanner *leftScanner = [NSScanner scannerWithString:left];
    NSScanner *rightScanner = [NSScanner scannerWithString:right];
    
    // if both begin with numbers, numeric comparison takes precedence
    if ([leftScanner scanInteger:&leftNumber] && [rightScanner scanInteger:&rightNumber]) {
        if (leftNumber < rightNumber)
            return NSOrderedAscending;
        if (leftNumber > rightNumber)
            return NSOrderedDescending;
        
        // if numeric values tied, compare the rest 
        left = [left substringFromIndex:[leftScanner scanLocation]];
        right = [right substringFromIndex:[rightScanner scanLocation]];
    }
    
    return [left caseInsensitiveCompare:right];
}
@end
