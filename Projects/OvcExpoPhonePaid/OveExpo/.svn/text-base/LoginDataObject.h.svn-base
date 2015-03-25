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
	NSString *userId;
    NSString *memberType;
    NSString *nickName;
    NSString *memberId;
    
}

@property(nonatomic,retain)NSString *sessionId, *userId,*memberType,*nickName,*memberId,*storeId, *storeName;
- (BOOL)checkLogin;
+(BOOL)isLogin;

-(void)cleanLogData;
+(LoginDataObject*)sharedInstance;
-(void)writeToPlist;
-(void)readPlist;
-(NSString*)createEditableCopyOfPlistIfNeeded;
+(void)setUserandPwd:(NSString*)InUser andPwd:(NSString*)InPwd;
@end
