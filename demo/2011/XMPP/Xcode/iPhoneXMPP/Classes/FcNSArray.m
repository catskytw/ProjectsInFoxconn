//
//  FcNSArray.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcNSArray.h"


@implementation NSArray(Reverse)
-(NSArray*)reverseArray{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumberator=[self reverseObjectEnumerator];
    for(id element in enumberator){
        [array addObject:element];
    }
    return array;
}
@end
