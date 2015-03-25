#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "XMPPRoster.h"
#import "TURNSocket.h"
#import "XMPPIBBStream.h"
#import "XMPPPubSub.h"

@class SettingsViewController;
@class XMPPStream;
@class XMPPCapabilities;
@class XMPPRosterCoreDataStorage;
@class XMPPvCardAvatarModule;
@class XMPPvCardTempModule;
@class XMPPMessage;

@interface iPhoneXMPPAppDelegate : NSObject <
UIApplicationDelegate,
UIAlertViewDelegate,
XMPPRosterDelegate,
TURNSocketDelegate
> {
	XMPPStream *xmppStream;
    XMPPCapabilities *xmppCapabilities;
	XMPPRoster *xmppRoster;
    XMPPIBBStream *xmppIBBStream;
    XMPPPubSub *xmppPubSub;
    TURNSocket *socket5;
    
    XMPPvCardAvatarModule *xmppvCardAvatarModule;
    XMPPvCardTempModule *xmppvCardTempModule;
	
	NSString *password;
	NSString *inputBox;
    XMPPJID *selectedJID;
    XMPPJID *myJID;
    UIAlertView *delDialog;
	BOOL allowSelfSignedCertificates;
	BOOL allowSSLHostNameMismatch;
	
	BOOL isOpen;
	
	UIWindow *window;
	UINavigationController *navigationController;
    SettingsViewController *loginViewController;
    UIBarButtonItem *loginButton;
}

@property (nonatomic, readonly) XMPPStream *xmppStream;
@property (nonatomic, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, readonly) XMPPRoster *xmppRoster;
@property (nonatomic, readonly) XMPPIBBStream *xmppIBBStream;
@property (nonatomic, readonly) XMPPPubSub *xmppPubSub;
@property (nonatomic, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, retain) NSString *inputBox;
@property (nonatomic, retain) XMPPJID *selectedJID;
@property (nonatomic, retain) UIAlertView *delDialog;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet SettingsViewController *settingsViewController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *loginButton;

-(IBAction) addFriend;
-(IBAction) delFriend;
-(IBAction) chatWithFriend;
-(IBAction) sendFile;
-(IBAction) talkBox;

- (BOOL)connect;
- (void)disconnect;
- (XMPPMessage *)sendMessage:(XMPPStream *)sender messageString:(NSString *)message toUserID:(XMPPJID *)jid;
@end