//
//  FcXMPPStream.h
//  FcXMPPLib
//
//  Created by Liao Chen-chih on 2011/11/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#define RESOURCE_ID @"foxconn"
#define SHARE_STREAM [FcXMPPStream share]

#import <Foundation/Foundation.h>
#import "XMPPStream.h"
#import "XMPPRoster.h"
#import "TURNSocket.h"
#import "XMPPCapabilitiesCoreDataStorage.h"
@class XMPPRosterCoreDataStorage;
@class XMPPMessage;
@interface FcXMPPStream : NSObject<XMPPRosterDelegate,
TURNSocketDelegate>{
    XMPPStream *stream;
    XMPPCapabilities *xmppCapabilities;
	XMPPRoster *xmppRoster;
    
    //private Var
    NSString *jid_Password,*domainName;
    NSInteger command_no;
    NSString *notAuthenticatedNotiName,*notRegistryNotiName,*receiveMessageNotiName,*receiveFileNotiName,*addFriendNotiName,*presenceNotiName;
    NSXMLElement *localPathProperty;
}
@property(nonatomic,retain)XMPPStream *stream;
@property(nonatomic,retain)NSString 
/**
 登入失敗之notificationName
 */
*notAuthenticatedNotiName,
/**
 註冊失敗之notificationName
 */
*notRegistryNotiName,
/**
 收到訊息之notificationName
 */
*receiveMessageNotiName,
/**
 收到檔案訊息之notificationName
 */
*receiveFileNotiName,
/**
 別人加入朋友之notificationName
 */
*addFriendNotiName,
/**
 roster清單之notificationName
 */
*presenceNotiName;

+(FcXMPPStream*)share;
#pragma mark - setting & login
/**
 設定xmppstream之參數
 */
-(void)setupStream:(NSString*)host withPort:(NSInteger)port withDomainName:(NSString*)myDomainName;
/**
 login API
 @param account,帳號
 @param password,密碼
 @param notiName,notificationName,完成後會post該notification
*/
-(void)login:(NSString*)account withPassword:(NSString*)password withNotAuthenticateNotificationName:(NSString*)notiName;
/**
 registry API
 @param account,帳號
 @param password,密碼
 @param notiName,notificationName,完成後會post該notification
 */
 
-(void)registry:(NSString*)account withPassword:(NSString*)password withNotRegistryNotificationName:(NSString*)notiName;
#pragma mark - Status
/**
 顯示上線
 */
-(void)goOnline;
/**
 顯示離線
 */
-(void)goOffline;

#pragma mark - Message
/**
 送訊息給對方
 @param messageString:訊息內容
 @param targetName:對方名稱,帳號名稱即可. e.g. zack
 */
-(XMPPMessage*)sendMessage:(NSString*)messageString withTarget:(NSString*)targetName;
/**
 送檔案給對方
 @param fileName:顯示之檔案名稱
 @param fileData:NSData,該檔案之binary內容
 @param targetName:對方帳號名稱
 */
-(BOOL)sendFile:(NSString*)fileName withData:(NSData*)fileData withTarget:(NSString*)targetName;
#pragma mark - Roster
/**
 加入對方朋友
 @param targetName: 對方帳號
 */
-(void)addFriend:(NSString*)targetName;
/**
 從朋友清單中,刪除對方
 @param targetName: 對方帳號
 */
-(void)removeFriend:(NSString*)targetName;
/**
 同意對方加入朋友
 @param targetName: 對方帳號
 */
-(void)acceptFriend:(NSString*)targetName;
/**
 拒絕對方加入朋友
 @param targetName: 對方帳號
 */
-(void)rejectFriend:(NSString*)targetName;


-(NSString*)contructTargetFullName:(NSString*)targetName;
@end
