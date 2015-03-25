//
//  NSFormatterExtend.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSFormatter (NSFormatterExtend)
+(NSDateFormatter*)getFormatterByFormateString:(NSString*)formatString;
@end
