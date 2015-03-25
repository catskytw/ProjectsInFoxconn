//
//  NSMutableArray+Queue.h
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/3.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end

