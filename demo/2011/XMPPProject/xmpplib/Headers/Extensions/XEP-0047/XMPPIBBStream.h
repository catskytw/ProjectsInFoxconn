//
//  XMPPIbbStream.h
//  iPhoneXMPP
//
//  Created by reachhu on 2011/7/5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMPPStream;
@class XMPPJID;
@class XMPPIQ;
@class XMPPMessage;
@class XMPPModule;

@interface XMPPIBBStream : XMPPModule {
    //XMPPStream *xmppStream;
    int state;
    dispatch_queue_t xmppIBBQueue;
    
    XMPPJID  *myJID;
    XMPPJID  *toJID;
    XMPPJID  *fromJID;
    NSString *uuid;//send id.
    NSString *type;
    NSString *protocol;//
    int       block_size;//default : 4096
    NSString *sid;//session id
    NSString *stanza;
    int       dataSeqNum;
    NSString *send_data;
    NSTimer *_timer;
}
- (id)initWithStream:(XMPPStream *)aXmppStream myJID:(XMPPJID *)jid;

@property (nonatomic, retain) XMPPJID *toJID;

- (void *)openIBB : (XMPPJID *)jid;
- (void *)closeIBB;
- (void *)sendData:(NSString *)data;//base64 binary data.
- (void *)sendOpenRes:(NSString *)res_uuid WithOpenResType:(int)resType;//Send open confirm
//- (NSString *)unsubscribeFromNode:(NSString *)node;
//- (NSString *)createNode:(NSString *)node withOptions:(NSDictionary *)options;
//- (NSString *)deleteNode:(NSString *)node;
//- (NSString *)configureNode:(NSString *)node;
//- (NSString *)allItemsForNode:(NSString *)node;
@end

@protocol XMPPIBBStreamDelegate
@optional

- (void)xmppIBBStream:(XMPPIBBStream *)sender didReceiveData:(XMPPIQ *)iq;
- (void)xmppIBBStream:(XMPPIBBStream *)sender didReceiveError:(XMPPIQ *)iq;
- (void)xmppIBBStream:(XMPPIBBStream *)sender didReceiveResult:(XMPPIQ *)iq;

@end
