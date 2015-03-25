//
//  TestUnit.h
//  TestUnit
//
//  Created by 廖 晨志 on 2011/7/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>


@interface TestUnit : SenTestCase {
@private
    
}
-(NSInteger)detectBaseValue:(int)value withPlusBase:(BOOL)plus;
@end
