//
//  FcXMPPStream.m
//  FcXMPPLib
//
//  Created by Liao Chen-chih on 2011/11/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcXMPPStream.h"
#import "Command.h"
#import "XMPPPresence.h"
#import "GCDAsyncSocket.h"
#import "MessageQueue.h"
#import "MessageQueue.h"

#define fullTargetName(targetName) [[FcXMPPStream share]contructTargetFullName:targetName]

static FcXMPPStream *singletonFcXMPPStrem=nil;
@interface FcXMPPStream(PrivateMethod)
- (NSXMLElement *) createProperty:(NSString *)name withValue:(NSString *)value valueType:(NSString *)valueType;
@end
@implementation FcXMPPStream
@synthesize stream,notAuthenticatedNotiName,notRegistryNotiName,receiveMessageNotiName,receiveFileNotiName,addFriendNotiName,presenceNotiName;
#pragma mark - LifeCycle
+(FcXMPPStream*)share{
    if(singletonFcXMPPStrem==nil)
        singletonFcXMPPStrem=[FcXMPPStream new];
    return singletonFcXMPPStrem;
}
-(id)init{
    if((self=[super init])){
        stream = [[XMPPStream alloc] init];
        xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:[XMPPRosterCoreDataStorage sharedInstance]];
        xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:[XMPPCapabilitiesCoreDataStorage sharedInstance]];
        
        xmppCapabilities.autoFetchHashedCapabilities = YES;
        xmppCapabilities.autoFetchNonHashedCapabilities = NO;
        [xmppRoster setAutoRoster:YES];
        
        [xmppRoster activate:stream];
        [xmppCapabilities activate:stream];
        jid_Password=nil;
    }
    return self;
}
-(void)dealloc{
    [jid_Password release];
    [stream release];
    [super dealloc];
}
#pragma -
#pragma mark - Setting
-(void)setupStream:(NSString*)host withPort:(NSInteger)port withDomainName:(NSString*)myDomainName{
    [stream setHostName:host];
    [stream setHostPort:port];
    domainName=myDomainName;
    [stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
-(void)login:(NSString*)account withPassword:(NSString*)password withNotAuthenticateNotificationName:(NSString*)notiName{
    self.notAuthenticatedNotiName=notiName;
    XMPPJID *jid=[XMPPJID jidWithString:fullTargetName(account) resource:RESOURCE_ID];
    [stream setMyJID:jid];

    jid_Password=[[NSString stringWithString:password] retain];
    
    command_no=COMMAND_LOGIN;
    
    NSError *error=nil;
    [stream connect:&error];
}
-(void)registry:(NSString*)account withPassword:(NSString*)password withNotRegistryNotificationName:(NSString*)notiName{
    self.notRegistryNotiName=notiName;
    XMPPJID *jid=[XMPPJID jidWithString:fullTargetName(account) resource:RESOURCE_ID];
    [stream setMyJID:jid];
    jid_Password=[[NSString stringWithString:password] retain];
    
    command_no=COMMAND_LOGIN;
    
    NSError *error=nil;
    [stream connect:&error];
}
#pragma -
#pragma mark -delegateMethod
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    if (![stream.myJID.user isEqualToString:[message to].user]) 
        return; // The message is not sent to me.
    [MessageQueue saveMessage:message withJID:[message from].user];
    NSDictionary *_dic=[NSDictionary dictionary];
    [_dic setValue:message forKey:[message from].user];
    [[NSNotificationCenter defaultCenter] postNotificationName:receiveMessageNotiName object:nil userInfo:_dic];
}
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket 
{
    [socket performBlock:^{
        [socket enableBackgroundingOnSocket];
    }];
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
    //not use
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
    //not use
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"conntected to XMPP server done!");
    NSError *error=nil;
    BOOL result=NO;
    switch (command_no) {
        case COMMAND_LOGIN:
            result=[stream authenticateWithPassword:jid_Password error:&error];
            break;
        case COMMAND_REGISTRY:
            result=[stream registerWithPassword:jid_Password error:&error];
            break;
    }
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    [[NSNotificationCenter defaultCenter] postNotificationName:notAuthenticatedNotiName object:nil]; //通知外部
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    [self goOnline];
}
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSError *error;
    [stream authenticateWithPassword:jid_Password error:&error];
}
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error{
    [[NSNotificationCenter defaultCenter]postNotificationName:notRegistryNotiName object:nil]; //通知外部註冊失敗
}
- (void)xmppRoster:(XMPPRoster *)sender didReceiveBuddyRequest:(XMPPPresence *)presence
{
    NSMutableDictionary *_dic=[NSMutableDictionary dictionary];
    [_dic setValue:[presence from] forKey:@"presenceJID"];
    [[NSNotificationCenter defaultCenter]postNotificationName:presenceNotiName object:nil userInfo:_dic];
}
#pragma -
#pragma mark - status
- (void)goOnline{
	XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
	[stream sendElement:presence];
}

-(void)goOffline{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	[stream sendElement:presence];
}
#pragma -

#pragma mark - Message
-(XMPPMessage*)sendMessage:(NSString*)messageString withTarget:(NSString*)targetName{
    XMPPJID *jid=[XMPPJID jidWithString:fullTargetName(targetName) resource:RESOURCE_ID];
    XMPPMessage *_rmsg=[stream sendMessage:stream messageString:messageString toUserID:jid];
    [MessageQueue saveMessage:_rmsg withJID:targetName];
    return _rmsg;
}

-(XMPPMessage*)sendFile:(NSData*)fileData withMessage:(NSString*)myMessage withTarget:(NSString*)targetName withFileName:(NSString*)fileName{
    NSXMLElement *properties = nil;
    if([fileName length] > 0)
    {
        NSString *allTargetName=[NSString stringWithFormat:@"%@/%@",fullTargetName(targetName),RESOURCE_ID];
        NSXMLElement *message = [[NSXMLElement elementWithName:@"message"]retain];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addAttributeWithName:@"to" stringValue:allTargetName];
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:myMessage];
        [message addChild:body];
        
        //Follow Smack properties protocol.
        NSXMLElement *property = nil;
        properties = [NSXMLElement elementWithName:@"properties" xmlns:@"http://www.jivesoftware.com/xmlns/xmpp/properties"];
        
        property = [self createProperty:@"extType" withValue:@"voiceFile" valueType:@"string"];
        [properties addChild:property];
        property = [self createProperty:@"voiceId" withValue:fileName valueType:@"string"];
        [properties addChild:property];
        property = [self createProperty:@"desc" withValue:@"File message" valueType:@"string"];
        [properties addChild:property];
        property = [self createProperty:@"from" withValue:[stream myJID].bare valueType:@"string"];
        [properties addChild:property];
        property = [self createProperty:@"to" withValue:fullTargetName(targetName) valueType:@"string"];
        [properties addChild:property];
        localPathProperty = [self createProperty:@"file_local_path" withValue:fileName valueType:@"string"];
        [properties addChild:localPathProperty];
        [message addChild:properties];
        [stream sendElement:message];
        XMPPMessage *_rmsg=[XMPPMessage messageFromElement:message];
        [MessageQueue saveMessage:_rmsg withJID:targetName];
        return _rmsg;
    }else
        return nil;
}
#pragma -

#pragma mark - Roster
-(void)addFriend:(NSString*)targetName{
    XMPPJID *friend = [XMPPJID jidWithString:fullTargetName(targetName) resource:RESOURCE_ID];
    [xmppRoster addBuddy:friend withNickname:[friend user]];
}
-(void)removeFriend:(NSString*)targetName{
    XMPPJID *friend = [XMPPJID jidWithString:fullTargetName(targetName) resource:RESOURCE_ID];
    [xmppRoster removeBuddy:friend];
}
-(void)acceptFriend:(NSString*)targetName{
    XMPPJID *friend = [XMPPJID jidWithString:fullTargetName(targetName) resource:RESOURCE_ID];
    [xmppRoster acceptBuddyRequest:friend];
}
-(void)rejectFriend:(NSString*)targetName{
    XMPPJID *friend = [XMPPJID jidWithString:fullTargetName(targetName) resource:RESOURCE_ID];
    [xmppRoster rejectBuddyRequest:friend];
}
#pragma mark - privateMethod
    - (NSXMLElement *) createProperty:(NSString *)name withValue:(NSString *)value valueType:(NSString *)valueType
    {
        NSXMLElement *property = nil;
        NSXMLElement *_name = nil;
        NSXMLElement *_value = nil;
        property = [[NSXMLElement elementWithName:@"property"]retain];
        _name = [[NSXMLElement elementWithName:@"name"]retain];
        [_name setStringValue:name];
        _value = [[NSXMLElement elementWithName:@"value"]retain];
        [_value setStringValue:value];
        if (valueType != nil) {
            [_value addAttributeWithName:@"type" stringValue:valueType];
        }
        
        [property addChild:_name];
        [property addChild:_value];
        //[_name release];
        //[_value release];
        //[property autorelease];
        return property;
    }
-(NSString*)contructTargetFullName:(NSString*)targetName{
    return [NSString stringWithFormat:@"%@@%@",targetName,domainName];
}
@end
