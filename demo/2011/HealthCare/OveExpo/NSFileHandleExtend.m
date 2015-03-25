//
//  NSFileHandleExtend.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSFileHandleExtend.h"


@implementation NSFileHandle(ExtendValue)
-(NSData*)readDataWithNSRange:(NSRange)range{
	[self seekToFileOffset:range.location];
	return [self readDataOfLength:range.length];
}
@end
