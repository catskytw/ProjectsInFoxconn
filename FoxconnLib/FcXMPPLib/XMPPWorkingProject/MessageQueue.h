//
//  MessageQueue.h
//  iPhoneXMPP
//
//  Created by 廖 晨志 on 2011/6/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"
#import "XMPPMessage.h"
@interface MessageQueue : NSObject {
    
}
+(NSMutableArray*)share;
+(NSMutableDictionary*)shareDic;
+(NSMutableDictionary*)shareUnreadDic;
+(void)releaseMessageQueue;
+(void)saveMessage:(XMPPMessage *)msg withJID:(NSString*)jidString;
@end
 