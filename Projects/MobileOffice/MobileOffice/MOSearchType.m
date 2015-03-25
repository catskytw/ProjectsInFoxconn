//
//  MOSearchType.m
//  MobileOffice
//
//  Created by  on 11/9/15.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MOSearchType.h"

@implementation MOSearchType
@synthesize filterType, filterName, items;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void) dealloc
{
    [filterName release];
    [filterType release];
    [items release];
    [super dealloc];
}
@end
