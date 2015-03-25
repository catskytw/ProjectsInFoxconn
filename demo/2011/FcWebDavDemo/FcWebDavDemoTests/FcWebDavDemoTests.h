//
//  FcWebDavDemoTests.h
//  FcWebDavDemoTests
//
//  Created by 廖 晨志 on 2011/7/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FMWebDAVRequest.h"

@interface FcWebDavDemoTests : SenTestCase {
@private
    
}
- (void)requestDidFetchDirectoryListingAndTestAuthenticationDidFinish:(FMWebDAVRequest*)req;
@end
