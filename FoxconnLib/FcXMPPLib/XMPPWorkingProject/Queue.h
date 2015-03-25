//
//  Queue.h
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 2009/11/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (QueueAddOn)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end

@interface NSMutableArray (NullArray)
+(NSMutableArray*)arrayWithNullArray:(NSArray*)sourceArray;
@end
