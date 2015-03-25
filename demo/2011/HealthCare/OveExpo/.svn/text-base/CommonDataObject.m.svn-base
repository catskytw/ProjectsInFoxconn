//
//  CommonDataObject.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommonDataObject.h"

@implementation CommonDataObject
@synthesize objId,objName;
-(id)initWithId:(NSString*)_id withName:(NSString*)_name{
    if((self=[super init])){
        objId=[[NSString stringWithString:_id] retain];
        objName=[[NSString stringWithString:_name] retain];
    }
    return self;
}
-(void)dealloc{
    [objId release];
    [objName release];
    [super dealloc];
}
@end
