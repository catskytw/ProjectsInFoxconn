//
//  PSListDataObject.m
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PSListDataObject2.h"

@implementation PSListDataObject2
@synthesize startTime,endTime, bookingStatus, type, location, name;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
