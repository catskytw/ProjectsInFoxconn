//
//  RegistrySelectedRecord.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RegistrySelectedRecord.h"
static RegistrySelectedRecord *singletonRegistrySelectedRecord=nil;
@implementation RegistrySelectedRecord
@synthesize hospitablName,departmentName;
+(RegistrySelectedRecord*)share{
    if(singletonRegistrySelectedRecord==nil)
        singletonRegistrySelectedRecord=[RegistrySelectedRecord new];
    return singletonRegistrySelectedRecord;
}
@end
