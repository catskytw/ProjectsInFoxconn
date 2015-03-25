//
//  Meeting.m
//  OveExpo
//
//  Created by  on 11/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Meeting.h"

@implementation Meeting
@synthesize 
meetingId,
title,
subTitle,
speaker,
desc,
date,
timeFrom,
timeTo,
location,
scale,
meetingType,
isJoined,
joinStatus,
joinName;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
