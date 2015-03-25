//
//  QRCodeSingletonObject.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "QRCodeSingletonObject.h"
#import "QueryPattern.h"
#import "LoginDataObject.h"
#import "FcConfig.h"
#import "ExhibitorInfoViewController.h"
#import "FeatureCtrlCollections.h"
static QRCodeSingletonObject *qrcodeSingletonObject=nil;
@implementation QRCodeSingletonObject
@synthesize functionType;
+(QRCodeSingletonObject*)current{
    if(qrcodeSingletonObject==nil){
        qrcodeSingletonObject=[QRCodeSingletonObject new];
        qrcodeSingletonObject.functionType=-1;//代表沒有任何功能
    }
    return qrcodeSingletonObject;
}

-(NSString*)addFriendNameCard:(NSString*)_uuid{
    NSString *responseString=@"";
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
    [qp prepareDic:addFriendBusinessCard(loginDO.sessionId, _uuid)];
    if([[qp getValue:@"response" withIndex:0] isEqualToString:@"ACCT003"])
        responseString=@"exist";
    else
        responseString=[qp getValue:@"businessCardId" withIndex:0];
    [qp release];
    //TODO judge adding success?
    return responseString;
}
-(void)getPointFromQRCode:(NSString*)_uuid{
    
}

-(NSString*)getExhibitorIdFromQRCode:(NSString*)_uuid{
    QueryPattern *qp=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
    [qp prepareDic:getLocationByQRCode(loginDO.sessionId,_uuid)];
    NSString *_exhibitorId=[NSString stringWithString:[qp getValue:@"target" withIndex:0]];
    [qp release];
    return _exhibitorId;
}

+(void)releaseSingleton{
    if(qrcodeSingletonObject!=nil){
        [qrcodeSingletonObject release];
        qrcodeSingletonObject=nil;
    }
}
@end
