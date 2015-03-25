//
//  FcWebDavDemoTests.m
//  FcWebDavDemoTests
//
//  Created by 廖 晨志 on 2011/7/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcWebDavDemoTests.h"
#import "FMWebDAVRequest.h"
#define defaultURL @"http://10.62.13.31:8080/repository/default/"
@implementation FcWebDavDemoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [FMWebDAVRequest requestToURL:NSStringToURL(defaultURL)
                         delegate:self
                      endSelector:@selector(requestDidFetchDirectoryListingAndTestAuthenticationDidFinish:)
                      contextInfo:nil];
    [super tearDown];
}
- (void)requestDidFetchDirectoryListingAndTestAuthenticationDidFinish:(FMWebDAVRequest*)req {
    
    NSArray *directoryListing = [req directoryListing];
    
    for (NSString *file in directoryListing) {
        NSLog(@"file: %@", file);
    }
}
- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in FcWebDavDemoTests");
}

@end
