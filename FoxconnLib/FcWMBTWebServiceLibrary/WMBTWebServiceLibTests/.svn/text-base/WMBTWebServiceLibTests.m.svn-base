//
//  WMBTWebServiceLibTests.m
//  WMBTWebServiceLibTests
//
//  Created by 廖 晨志 on 2011/6/9.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "WMBTWebServiceLibTests.h"
#import "WMBTWebService.h"
#import "OrderDtlObject.h"

@implementation WMBTWebServiceLibTests

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
    OrderDtlObject *o=[OrderDtlObject new];
    o.prodId=@"2D38C91DA4A74F96834B86B7BC88AE48";
    o.prodPrice=@"5499";
    o.prodQty=@"2";
    WMBTWebService *webService=[WMBTWebService new];
    [webService createAdvance:[NSArray arrayWithObjects:o, nil] withCpy:@"ABEF0FC10A868251016BA008C479159A" withMember:@"57457C2E0AB513B9014807739872A35A"];
    [webService release];
    NSLog(@"test!!");
}

@end
