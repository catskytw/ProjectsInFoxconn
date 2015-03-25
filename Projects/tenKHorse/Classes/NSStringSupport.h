//
//  NSString.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/4/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString(Support)
- (NSComparisonResult) psuedoNumericCompare:(NSString *)otherString;
@end
