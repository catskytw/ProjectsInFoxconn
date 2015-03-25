//
//  RecordViewController.h
//  iPhoneXMPP
//
//  Created by Link Chang on 2011/7/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "AQLevelMeter.h"
#ifdef __APPLE__
#include "TargetConditionals.h"
#endif

#if TARGET_OS_IPHONE
#import "AQPlayer.h"
#import "AQRecorder.h"
#endif//TARGET_OS_IPHONE

#import "XMPPJID.h"
@interface RecordViewController : UIViewController {
    
    IBOutlet UIButton *recBtn;
    IBOutlet UIButton *cancelBtn;
    IBOutlet UIButton *sendBtn;
#if TARGET_OS_IPHONE
    AQPlayer*		player;
	AQRecorder*		recorder;
#endif// TARGET_OS_IPHONE

	BOOL			playbackWasInterrupted;
	BOOL			playbackWasPaused;
    BOOL            bPlay;
    BOOL            bRec;
    NSString        *recName;
    XMPPJID *targetJid;
    NSString *targetDisplayName;
	CFStringRef					recordFilePath;	
    IBOutlet  UIButton *playBtn;
}
- (IBAction)recUp:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)sendVoice:(id)sender;
- (IBAction)play:(id)sender;
@property (nonatomic, retain) UIButton *playBtn;
@property (nonatomic, retain)  UIButton *recBtn;
@property (nonatomic, retain)  UIButton *cancelBtn;
@property (nonatomic, retain)  UIButton *sendBtn;
@property (nonatomic, retain)  NSString *recName;
#if TARGET_OS_IPHONE
@property (readonly)			AQPlayer			*player;
@property (readonly)			AQRecorder			*recorder;
#endif //TARGET_OS_IPHONE
@property						BOOL				playbackWasInterrupted;
@property(nonatomic,retain)XMPPJID *targetJid;
@property(nonatomic,retain)NSString *targetDisplayName;
@end
