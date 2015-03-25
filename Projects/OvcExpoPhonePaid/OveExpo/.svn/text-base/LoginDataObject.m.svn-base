//
//  LoginDataObject.m
//  WMBT
//
//  Created by link on 2011/6/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginDataObject.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "Tools.h"
#define PLIST_FILE_PATH @"Account.plist"
@implementation LoginDataObject
@synthesize sessionId, userId, memberType, nickName,memberId,storeId, storeName;
static LoginDataObject *sharedInstance = nil;
static NSString *loginId=@"";
static NSString *password=@"";
static BOOL bLogin = NO;
+(LoginDataObject*)sharedInstance {
    @synchronized( [ LoginDataObject class ] ) {
        if( sharedInstance == nil ){
            sharedInstance = [ [ LoginDataObject alloc ] init ];
			NSLog(@"%@ sharedInstance: Creating login data singleton.. ",[self class]);
        }
    }
    return sharedInstance;
}


-( id )init {
    @synchronized( [ LoginDataObject class ] ) {
        self = [ super init ];
        if( self != nil ) {
        }
		
        return self;
    }
}

+(BOOL)isLogin{
    return bLogin;
}


+(void)setUserandPwd:(NSString*)InUser andPwd:(NSString*)InPwd
{
    loginId =InUser;
    password = InPwd;
}

-(void)cleanLogData{
    loginId =@"";
    password = @"";
    bLogin = NO;
}
- (void)readPlist
{
    //NSString *filePath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Account.plist"];
    
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self createEditableCopyOfPlistIfNeeded]];
    
    loginId = [[plistDict objectForKey:@"loginId"] copy];
    password = [[plistDict objectForKey:@"password"] copy];

    if (plistDict) {
        [plistDict release];
    }
    /* You could now call the string "value" from somewhere to return the value of the string in the .plist specified, for the specified key. */
}
-(NSString*)createEditableCopyOfPlistIfNeeded{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir=[paths objectAtIndex:0];
    NSString *writeDBPath=[documentDir stringByAppendingPathComponent:PLIST_FILE_PATH];
    NSLog(@"writeDBPath %@",writeDBPath);
    if([fileManager fileExistsAtPath:writeDBPath isDirectory:NO])
        return writeDBPath; //有檔案了
    
    NSString *defaultDatabasePath=[[NSBundle mainBundle] pathForResource:PLIST_FILE_PATH ofType:@""];
    NSError *error;
    [fileManager removeItemAtPath:writeDBPath error:&error];
    NSLog(@"defaultDatabasePath %@",defaultDatabasePath);    
    BOOL r=[fileManager copyItemAtPath:defaultDatabasePath toPath:writeDBPath error:&error];
    if(!r) NSLog(@"Copy database file failure!");
    return writeDBPath;
}

- (void)writeToPlist
{
   // NSString *filePath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[self createEditableCopyOfPlistIfNeeded]];
    //NSLog(filePath);
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:[self createEditableCopyOfPlistIfNeeded]];
    
    [plistDict setValue:loginId forKey:@"loginId"];
    [plistDict setValue:password forKey:@"password"];
    [plistDict writeToFile:[self createEditableCopyOfPlistIfNeeded] atomically: YES];
    if (plistDict) {
        [plistDict release];
    }
    /* This would change the firmware version in the plist to 1.1.1 by initing the NSDictionary with the plist, then changing the value of the string in the key "ProductVersion" to what you specified */
}
- (BOOL)checkLogin
{

    if ([loginId length]==0 || [password length]==0) {
        bLogin = NO;
        return bLogin;
    }
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];

   // NSString *lowercaseId = [loginId lowercaseString];
	[accountQuery prepareDic:loginQuery(loginId, password)];
    userId = loginId;
    @try {
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])&&[accountQuery getNumberUnderNode:@"session" withKey:@"id"]>0) {
            sessionId =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"session" withKey:@"id" withIndex:0]]copy];
            NSLog(@"sessionId: %@", sessionId);
            nickName =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"session" withKey:@"nickname" withIndex:0]]retain];
            NSString* test =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"session" withKey:@"ste" withIndex:0]]retain];
            NSLog(@"get err field %@",test);
            //memberType =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"session" withKey:@"type" withIndex:0]]retain];
            //memberId = [[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"defaultPrincipal" withKey:@"id" withIndex:0]]retain];
            bLogin = YES;
            [self writeToPlist];
        }else{
            bLogin = NO;
            
        }

    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
       [accountQuery release];
        
    }
    return bLogin; 
}

@end
