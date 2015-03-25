//
//  testJSONQuery.m
//  testJSONQuery
//
//  Created by 廖 晨志 on 2011/5/31.
//  Copyright 2011年 foxconn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "testJSONQuery.h"
#import "QueryPattern.h"
@interface testJSONQuery(PrivateMethod)
@end
@implementation testJSONQuery

- (void)setUp
{
    [super setUp];
    queryPattern=[QueryPattern new];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [queryPattern release];
    [super tearDown];
}
-(void)testGetValue{
    [queryPattern prepareDic:@"http://58.246.162.126:8080/service/productService.getAllProductTypeList?rnd=1804289383"];
    
    NSString *arg1=[queryPattern getValue:@"id" withIndex:0]);
    NSLog(@"%@",arg1);
//    NSAssert2([arg1 isEqualToString:@"change"], @"test ....", nil, nil);
}

-(void)testUIImage{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [queryPattern getImageData:@"http://58.246.162.126:8080/A1CCD5B18FE5239CE040760A28FD6FED_small.jpg" withUIComponent:imageView withNotificationName:nil];
}

@end
