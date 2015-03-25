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
@implementation MessageQueue
+(NSMutableArray*)share{
    if(_messageQueue==nil)
        _messageQueue=[[NSMutableArray array]retain];
    return _messageQueue;
}
+(void)releaseMessageQueue{
    if(_messageQueue!=nil){
        [_messageQueue release];
    }
}
@end
