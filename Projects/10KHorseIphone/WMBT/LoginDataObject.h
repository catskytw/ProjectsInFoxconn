//
//  LoginDataObject.h
//  WMBT
//
//  Created by link on 2011/6/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginDataObject : NSObject {
    NSString *sessionId;
	NSString *loginId;
    NSString *memberType;
    NSString *nickName;
    NSString *memberId;
    NSString *storeId;
    NSString *storeName;
}

@property(nonatomic,retain)NSString *sessionId, *loginId,*memberType,*nickName,*memberId,*storeId, *storeName;
- (void)checkLogin;
+(BOOL)isLogin;
-(void)logout;
-(void)cleanLogData;
+(id)sharedInstance;
+(void)setUserandPwd:(NSString*)InUser andPwd:(NSString*)InPwd;
@end
