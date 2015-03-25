//
//  TestUnit.m
//  TestUnit
//
//  Created by 廖 晨志 on 2011/7/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "TestUnit.h"
@implementation TestUnit

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in TestUnit");
    NSLog(@"number:%i",[self detectBaseValue:289 withPlusBase:NO]);
    NSLog(@"number:%i",[self detectBaseValue:289 withPlusBase:YES]);
}

-(NSInteger)detectBaseValue:(int)value withPlusBase:(BOOL)plus{
    if (value<10) 
        return 0;
    NSString *valueString=[NSString stringWithFormat:@"%i",value];
    NSInteger length=[valueString length];
    NSString *startChar=[valueString substringWithRange:NSMakeRange(0, 1)];
    if(plus)
        startChar= [NSString stringWithFormat:@"%i",[startChar intValue]+1];
    for(int i=0;i<length-1;i++){
        startChar=[startChar stringByAppendingFormat:@"%@",@"0"];
    }
    return [startChar intValue];
}
@end
