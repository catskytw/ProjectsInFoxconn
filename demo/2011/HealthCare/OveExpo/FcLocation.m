//
//  FcLocation.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcLocation.h"
static CLLocation *nowLocation=nil;
@implementation FcLocation
+(void)setNowLocation:(CLLocation*)_location{
    if(nowLocation!=nil){
        [nowLocation release];
        nowLocation=nil;
    }
    nowLocation=[_location retain];
}
+(CLLocation*)nowLocation{
    return nowLocation;
}
@end
