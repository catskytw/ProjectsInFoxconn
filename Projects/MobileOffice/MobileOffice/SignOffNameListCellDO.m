//
//  SignOffNameListCellDO.m
//  MobileOffice
//
//  Created by Chang Link on 11/9/5.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffNameListCellDO.h"

@implementation SignOffNameListCellDO
@synthesize name;
@synthesize bChecked;
@synthesize index;
@synthesize taskId;
@synthesize flowName;
@synthesize flowType,flowEnum;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
