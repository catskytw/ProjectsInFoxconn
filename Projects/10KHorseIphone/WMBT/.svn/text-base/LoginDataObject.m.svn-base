//
//  LoginDataObject.m
//  WMBT
//
//  Created by link on 2011/6/14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoginDataObject.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "ShoppingListController.h"
#import "Tools.h"
@implementation LoginDataObject
@synthesize sessionId, loginId, memberType, nickName,memberId,storeId, storeName;
static LoginDataObject * sharedInstance = nil;
static NSString *username;
static NSString *password;
static BOOL bLogin = NO;
+( id )sharedInstance {
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
    username =InUser;
    password = InPwd;
}
- (void)logout
{
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];

	[accountQuery prepareDic:logoutQuery(sessionId)];
    @try {
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])){
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"logout_alert_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"logout_alert_msg",nil)]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"logout_alert_ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
        }
    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [accountQuery release];
    }
        
    [self cleanLogData];
}
-(void)cleanLogData{
    username =@"";
    password = @"";
    bLogin = NO;
    [ShoppingListController removeallShoppingCart];
}
- (void)checkLogin
{

    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];

    NSString *lowercaseId = [username lowercaseString];
	[accountQuery prepareDic:loginQuery(lowercaseId, password)];
    //NSLog(@"response %@",[accountQuery getValue:@"response" withIndex:0]);
    //NSLog(@"session number %d",[accountQuery getNumberUnderNode:@"sessionInfo" withKey:@"id"]);
    @try {
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])&&[accountQuery getNumberUnderNode:@"sessionInfo" withKey:@"id"]>0) {
            sessionId =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"sessionInfo" withKey:@"id" withIndex:0]]retain];
            loginId =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"sessionInfo" withKey:@"loginId" withIndex:0]]retain];
            nickName =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"sessionInfo" withKey:@"nickname" withIndex:0]]retain];
            memberType =[[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"sessionInfo" withKey:@"type" withIndex:0]]retain];
            memberId = [[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"defaultPrincipal" withKey:@"id" withIndex:0]]retain];
            storeId = [[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"recruitStore"  withKey:@"id" withIndex:0]]retain];
            storeName = [[NSString stringWithFormat:@"%@",[accountQuery getValueUnderNode:@"recruitStore"  withKey:@"name" withIndex:0]]retain];
            bLogin = YES;
        }else{
            bLogin = NO;
        }

    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
       [accountQuery release];
    }

}

@end
