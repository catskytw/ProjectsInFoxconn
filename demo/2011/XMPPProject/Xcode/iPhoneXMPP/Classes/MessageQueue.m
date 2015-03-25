//
//  MessageQueue.m
//  iPhoneXMPP
//
//  Created by 廖 晨志 on 2011/6/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MessageQueue.h"
#import "Queue.h"
static NSMutableArray *_messageQueue;
static NSMutableDictionary *_messageDic;
static NSMutableDictionary *_unreadDic; //key:name vaule:unread count
@implementation MessageQueue
+(NSMutableArray*)share{
    if(_messageQueue==nil) 
        _messageQueue=[[NSMutableArray array]retain];
    return _messageQueue;
}
+(NSMutableDictionary*)shareDic{
    if(_messageDic==nil)
        _messageDic=[[NSMutableDictionary dictionary]retain];
    return _messageDic;
}
+(NSMutableDictionary*)shareUnreadDic{
    if(_unreadDic==nil)
        _unreadDic=[[NSMutableDictionary dictionary]retain];
    return _unreadDic;
}
+(void)setMessageWithJID:(XMPPMessage *)msg withJID:(NSString*)jid{
    if(!msg)
        return;
    [MessageQueue shareDic];
    NSMutableArray* messageArray = [_messageDic objectForKey:jid];
    if (messageArray==nil) {
        NSMutableArray *qArray = [[NSMutableArray arrayWithObjects:nil]retain];
        [qArray addObject:msg];
        [_messageDic setValue:qArray forKey:jid];
    }else{
        [messageArray addObject:msg];
    }
}
+(void)releaseMessageQueue{
    if(_messageQueue!=nil){
        [_messageQueue release];
    }
    if(_unreadDic!=nil){
        [_unreadDic release];
    }
    if(_messageDic!=nil){
        for (NSMutableArray *qArray in _messageDic) {
            if (qArray!=nil) {
                [qArray release];
            }
        }
        [_messageDic release];
    }

}
@end
