//
//  ExhibitorEventDatoObject.m
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorEventDatoObject.h"

@implementation ExhibitorEventDatoObject
@synthesize title;
@synthesize status;
@synthesize eventId;
@synthesize attender;
@synthesize mobile;
@synthesize bAdmited;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
