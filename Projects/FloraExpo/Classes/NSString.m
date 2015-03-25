//
//  NSString.m
//  FloraExpo2010
//
//  Created by Change Liao on 2010/10/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString.h"

//+ (id)stringWithString:(NSString *)string;
@implementation NSString (NSNull)
+ (NSString*)stringWithNullString:(NSString *)string{
	if((id)string==[NSNull null])
		return [NSString stringWithString:@""];
	else if((id)string==nil)
		return nil;
	return [NSString stringWithString:string];
}
@end
