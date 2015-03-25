#import "iPhoneXMPPAppDelegate.h"
#import "RootViewController.h"
#import "SettingsViewController.h"

#import "GCDAsyncSocket.h"
#import "XMPP.h"
#import "XMPPCapabilitiesCoreDataStorage.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPvCardAvatarModule.h"
#import "XMPPvCardCoreDataStorage.h"

#import "DDLog.h"
#import "DDTTYLogger.h"
#import "Queue.h" //A19 toolkit
#import "MessageQueue.h"
#import <CFNetwork/CFNetwork.h>
#import "ChattingViewController.h"
#import "TURNSocket.h"
// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
@interface iPhoneXMPPAppDelegate()

- (void)setupStream;

- (void)goOnline;
- (void)goOffline;

@end

#pragma mark -
@implementation iPhoneXMPPAppDelegate

@synthesize xmppStream;
@synthesize xmppCapabilities;
@synthesize xmppRoster;
@synthesize xmppIBBStream;
@synthesize xmppPubSub;
@synthesize xmppvCardAvatarModule;
@synthesize xmppvCardTempModule;

@synthesize window;
@synthesize navigationController;
@synthesize settingsViewController;
@synthesize loginButton;
@synthesize inputBox;
@synthesize selectedJID;
@synthesize delDialog;
	
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // reg a notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendMessageNotification:) name:@"sendMessageNotification" object:nil];
	// Configure logging framework
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
    
	// Setup the view controllers

	[window setRootViewController:navigationController];
	[window makeKeyAndVisible];
    delDialog = [[UIAlertView alloc ]initWithTitle:@"Warning" message:@"Are you Sure? Delete a friend" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [delDialog addButtonWithTitle:@"OK"];
	// Setup the XMPP stream

	[self setupStream];

	if (![self connect]) {
		[navigationController presentModalViewController:settingsViewController animated:YES];
	}
		
	return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"sendMessageNotification" object:nil];
	[xmppStream removeDelegate:self];
	[xmppRoster removeDelegate:self];

	[xmppStream disconnect];
	[xmppvCardAvatarModule release];
	[xmppvCardTempModule release];
    [xmppCapabilities release];
	[xmppStream release];
	[xmppRoster release];
    [xmppIBBStream release];
    [xmppPubSub release];
    
	[password release];
	[loginButton release];
	[settingsViewController release];
	[navigationController release];
    [[MessageQueue share] release];
	[window release];
    [delDialog release];
    
	[super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Private
-(void)sendMessageNotification:(NSNotification*)notification{
    NSDictionary *dic=notification.userInfo;
    NSString *m_message=[dic valueForKey:@"_message"];
    XMPPJID *m_jid=[dic valueForKey:@"_jid"];
    [[MessageQueue share] enqueue: [self sendMessage:xmppStream messageString:m_message toUserID:m_jid]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Configure the xmpp stream
- (void)setupStream
{
	// Initialize variables
    
	xmppStream = [[XMPPStream alloc] init];
    xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:[XMPPCapabilitiesCoreDataStorage sharedInstance]];
	xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:[XMPPRosterCoreDataStorage sharedInstance]];
	xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:[XMPPvCardCoreDataStorage sharedInstance]];
	xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:xmppvCardTempModule];
    xmppIBBStream = [[XMPPIBBStream alloc] initWithStream:xmppStream myJID:nil];
    //xmppPubSub = [[XMPPPubSub alloc]initWithDispatchQueue:dispatch_get_main_queue()];
	// Configure modules

    xmppCapabilities.autoFetchHashedCapabilities = YES;
    xmppCapabilities.autoFetchNonHashedCapabilities = NO;
	[xmppRoster setAutoRoster:YES];

	/**
	 * Add XMPPRoster as a delegate of XMPPvCardAvatarModule to cache roster photos in the roster.
	 * This frees the view controller from having to save photos on the main thread.
	**/
	[xmppvCardAvatarModule addDelegate:xmppRoster delegateQueue:xmppRoster.moduleQueue];


	// Activate xmpp modules
    [xmppCapabilities activate:xmppStream];
	[xmppRoster activate:xmppStream];
	[xmppvCardTempModule activate:xmppStream];
	[xmppvCardAvatarModule activate:xmppStream];
    [xmppIBBStream activate:xmppStream];
    //[xmppPubSub activate:xmppStream];

	// Add ourself as a delegate to anything we may be interested in

	[xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
	[xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    //[xmppIBBStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    //[xmppPubSub addDelegate:self delegateQueue:dispatch_get_main_queue()];
	// Optional:
	// 
	// Replace me with the proper domain and port.
	// The example below is setup for a typical google talk account.
	// 
	// If you don't supply a hostName, then it will be automatically resolved using the JID (below).
	// For example, if you supply a JID like 'user@quack.com/rsrc'
	// then the xmpp framework will follow the xmpp specification, and do a SRV lookup for quack.com.
	// 
	// If you don't specify a hostPort, then the default (5222) will be used.
	//	[xmppStream setHostName:@"talk.google.com"];
	//	[xmppStream setHostPort:5222];	
	NSString *serverHost = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyServerHost];
    [xmppStream setHostName:serverHost];
    [xmppStream setHostPort:5222];
    
	// You may need to alter these settings depending on the server you're connecting to
	allowSelfSignedCertificates = NO;
	allowSSLHostNameMismatch = NO;
}

// It's easy to create XML elments to send and to read received XML elements.
// You have the entire NSXMLElement and NSXMLNode API's.
// 
// In addition to this, the NSXMLElement+XMPP category provides some very handy methods for working with XMPP.
// 
// On the iPhone, Apple chose not to include the full NSXML suite.
// No problem - we use the KissXML library as a drop in replacement.
// 
// For more information on working with XML elements, see the Wiki article:
// http://code.google.com/p/xmppframework/wiki/WorkingWithElements

- (void)goOnline
{
	XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
	
	[[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
	XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	
	[[self xmppStream] sendElement:presence];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Connect/disconnect
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)connect
{
  if (![xmppStream isDisconnected]) {
    return YES;
  }
  
  NSString *_myJID = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
  NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword];
  myJID = [XMPPJID jidWithString:_myJID resource:@"iphone"];
  //
  // If you don't want to use the Settings view to set the JID, 
  // uncomment the section below to hard code a JID and password.
  //
  // Replace me with the proper JID and password:
  //	myJID = @"user@gmail.com/xmppframework";
  //	myPassword = @"";
  	//myJID = @"reach@reach";
  	//myPassword = @"1234";
    
  if (_myJID == nil || myPassword == nil) {
    DDLogWarn(@"JID and password must be set before connecting!");
    
    return NO;
  }
  
  [xmppStream setMyJID:myJID];
  password = myPassword;
  
  NSError *error = nil;
  if (![xmppStream connect:&error])
  {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting" 
                                                        message:@"See console for error details." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Ok" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
    DDLogError(@"Error connecting: %@", error);
    
    return NO;
  }
  
  return YES;
}

- (void)disconnect {
  [self goOffline];
  
  [xmppStream disconnect];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIApplicationDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)applicationDidEnterBackground:(UIApplication *)application 
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state 
   information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
   */
  DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
  
#if TARGET_IPHONE_SIMULATOR
  DDLogError(@"The iPhone simulator does not process background network traffic.  Inbound traffic is queued until the keepAliveTimeout:handler: fires.");
#endif
  
  if ([application respondsToSelector:@selector(setKeepAliveTimeout:handler:)]) 
  {
    [application setKeepAliveTimeout:600 handler:^{
      DDLogVerbose(@"KeepAliveHandler");
      
      // Do other keep alive stuff here.
    }];
  }
}

- (void)applicationWillEnterForeground:(UIApplication *)application 
{
  DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPRosterDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppRoster:(XMPPRoster *)sender didReceiveBuddyRequest:(XMPPPresence *)presence
{
  DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
  
  NSString *displayName = [[xmppRoster userForJID:[presence from]] displayName];
  NSString *jidStrBare = [presence fromStr];
  NSString *body = nil;
  
  if (![displayName isEqualToString:jidStrBare]) 
  {
    body = [NSString stringWithFormat:@"Buddy request from %@ <%@>", displayName, jidStrBare];
  } 
  else 
  {
    body = [NSString stringWithFormat:@"Buddy request from %@", displayName];
  }
  
  
  if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
  {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
                                                        message:body 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Not implemented" 
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
  } 
  else 
  {
    // We are not active, so use a local notification instead
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Not implemented";
    localNotification.alertBody = body;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    [localNotification release];
  }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPStream Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket 
{
  // Allows the application to receive inbound XMPP traffic while in the background.
  [socket performBlock:^{
    [socket enableBackgroundingOnSocket];
  }];
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	if (allowSelfSignedCertificates)
	{
		[settings setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
	}
	
	if (allowSSLHostNameMismatch)
	{
		[settings setObject:[NSNull null] forKey:(NSString *)kCFStreamSSLPeerName];
	}
	else
	{
		// Google does things incorrectly (does not conform to RFC).
		// Because so many people ask questions about this (assume xmpp framework is broken),
		// I've explicitly added code that shows how other xmpp clients "do the right thing"
		// when connecting to a google server (gmail, or google apps for domains).
		
		NSString *expectedCertName = nil;
		
		NSString *serverDomain = xmppStream.hostName;
		NSString *virtualDomain = [xmppStream.myJID domain];
		
		if ([serverDomain isEqualToString:@"talk.google.com"])
		{
			if ([virtualDomain isEqualToString:@"gmail.com"])
			{
				expectedCertName = virtualDomain;
			}
			else
			{
				expectedCertName = serverDomain;
			}
		}
		else if (serverDomain == nil)
		{
			expectedCertName = virtualDomain;
		}
		else
		{
			expectedCertName = serverDomain;
		}
		
		if (expectedCertName)
		{
			[settings setObject:expectedCertName forKey:(NSString *)kCFStreamSSLPeerName];
		}
	}
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	isOpen = YES;
	
	NSError *error = nil;
	
    if([settingsViewController isRegister] == YES)
    {
        if(![[self xmppStream] registerWithPassword:password error:&error])
        {
            DDLogError(@"Error authenticating: %@", error);
        }
    }
    else
	{
        if(![[self xmppStream] authenticateWithPassword:password error:&error])
        {
            DDLogError(@"Error authenticating: %@", error);
        }
	}
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	[self goOnline];
}

/* sender : 
 * messageString : message content
 * jid : target user id.(eg. [user name]@[service])
 */
- (XMPPMessage *) sendMessage:(XMPPStream *)sender messageString:(NSString *)message toUserID:(XMPPJID *)jid 
{
	NSString *messageStr = message;
     
     if([messageStr length] > 0)
     {
         NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
         [body setStringValue:messageStr];     
         NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
         [message addAttributeWithName:@"type" stringValue:@"chat"];
         [message addAttributeWithName:@"to" stringValue:[jid full]];
         [message addChild:body];
         [xmppStream sendElement:message];
         return [XMPPMessage messageFromElement:message];
     }
     else
     {
         return nil;
     }
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
	DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [iq elementID]);
	
	return NO;
}

/* 
 * eg. Get message content
 *  NSString *body = [[message elementForName:@"body"] stringValue];    
 *  NSString *displayName = [[xmppRoster userForJID:[message from]] displayName];
 */
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    NSLog(@"receive message!!");
    [[MessageQueue share] enqueue:message];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadConversationTable" object:nil userInfo:nil];
    
    // (XXXX) 1.Check the target queue for this message.
    // 2. Put the message to queue.
    // 3. Notify UI to update.
    // eg. :
    //  NSString *body = [[message elementForName:@"body"] stringValue];    
    //  NSString *displayName = [[xmppRoster userForJID:[message from]] displayName];

  // A simple example of inbound message handling.
  
  /*if ([message isChatMessageWithBody])
  {
    NSString *body = [[message elementForName:@"body"] stringValue];    
    NSString *displayName = [[xmppRoster userForJID:[message from]] displayName];

    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
    {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
                                                          message:body 
                                                         delegate:nil 
                                                cancelButtonTitle:@"Ok" 
                                                otherButtonTitles:nil];
      [alertView show];
      [alertView release];
    } else {
      // We are not active, so use a local notification instead
      UILocalNotification *localNotification = [[UILocalNotification alloc] init];
      localNotification.alertAction = @"Ok";
      localNotification.alertBody = [NSString stringWithFormat:@"From: %@\n\n%@",displayName,body];
      
      [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
      [localNotification release];
    }
  }*/
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
	DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [presence fromStr]);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	if (!isOpen)
	{
		DDLogError(@"Unable to connect to server. Check xmppStream.hostName");
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark TurnSocket Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket
{
    DDLogError(@"didSucceed...");
}

- (void)turnSocketDidFail:(TURNSocket *)sender
{
    DDLogError(@"turnSocketDidFail...");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UIBuilder item Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)addFriend
{
    XMPPJID *friend;
    DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, inputBox);
    friend = [XMPPJID jidWithString:inputBox];
    
    [xmppRoster addBuddy:friend withNickname:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    buttonIndex = buttonIndex;
    if (buttonIndex == 1) {
        XMPPJID *friend = selectedJID;
        [xmppRoster removeBuddy:friend];
    }
    
}

- (IBAction)delFriend
{
    [delDialog show];    
}

- (IBAction)chatWithFriend
{
    XMPPJID *friend = selectedJID;
    ChattingViewController *nextViewController=[ChattingViewController new];
    nextViewController.targetJid=friend;
    nextViewController.targetDisplayName=[friend full];
    nextViewController.navigationItem.title=[friend full];
    [self.navigationController pushViewController:nextViewController animated:YES];
    [nextViewController autorelease];
}

- (IBAction)sendFile
{
    XMPPJID *friend = selectedJID;
    [xmppIBBStream openIBB:friend];
    //[xmppIBBStream setToJID:friend];
    //[xmppIBBStream sendData:@"Hello"];
    //socket5 = [[TURNSocket alloc] initWithStream:xmppStream toJID:friend];
    //socket5 connection:<#(NSURLConnection *)#> didCancelAuthenticationChallenge:<#(NSURLAuthenticationChallenge *)#>
}

- (IBAction)talkBox
{
    //XXXX : Need to implement
    XMPPJID *friend = selectedJID;
}

@end