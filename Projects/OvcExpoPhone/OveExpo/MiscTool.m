//
//  MiscTool.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MiscTool.h"
#import "FcConfig.h"
#import "NSDataString.h"
@implementation MiscTool
+(int)getIntFromLittleNSData:(NSData*)data{
	int result;
	if([data length]<=2){
		short i;
		[data getBytes:&i length:2];
#ifdef USELITTLEENDIAN
		i=NSSwapHostShortToBig(i);
#endif
		result=i;
	}else{
		[data getBytes:&result length:4];
#ifdef USELITTLEENDIAN
		result=NSSwapHostIntToBig(result);
#endif
	}
    //NSLog(@"int value:%i  int hex:%@",result,[data stringWithHexBytes]);
	return result;
}

/**
 deascending sorting
 */
+(NSArray*)getOneDeascSortDescriptor:(NSString*)key{
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key
												  ascending:NO] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	return sortDescriptors;
}
@end
