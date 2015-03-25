//
//  Queue.m
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 2009/11/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"

@implementation NSMutableArray (QueueAddOn)
// Queues are first-in-first-out, so we remove objects from the head

- (id) dequeue {
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
        [[headObject retain]autorelease]; // so it isn't dealloc'ed on remove
        [self removeObjectAtIndex:0];
    }
    return headObject;
}

// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject {
	@try{
		[self addObject:anObject];
	}@catch (id theException) {
		NSLog(@"%@",theException);
	}
    //this method automatically adds to the end of the array
}
@end
@implementation NSMutableArray (NullArray)
+(NSMutableArray*)arrayWithNullArray:(NSArray*)sourceArray{
	NSMutableArray *arrayWithNullArray;
	if((id)sourceArray==[NSNull null]){
		arrayWithNullArray=[NSMutableArray arrayWithObjects:nil];
	}else{
		arrayWithNullArray=[NSMutableArray arrayWithArray:sourceArray];
	}
	return arrayWithNullArray;
}
@end
