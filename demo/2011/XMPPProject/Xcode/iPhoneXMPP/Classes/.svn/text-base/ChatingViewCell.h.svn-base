//
//  ChatingViewCell.h
//  iPhoneXMPP
//
//  Created by 廖 晨志 on 2011/6/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#if TARGET_OS_IPHONE
#import "AQPlayer.h"
#endif//TARGET_OS_IPHONE

@interface ChatingViewCell : UITableViewCell {
    IBOutlet UILabel *name;
    IBOutlet UILabel *content;
    IBOutlet UIButton *playBtn;
    NSString *voiceUrl;
#if TARGET_OS_IPHONE
    AQPlayer*		player;
#endif//TARGET_OS_IPHONE
    BOOL			playbackWasInterrupted;
	BOOL			playbackWasPaused;
}
@property (nonatomic, retain)  UIButton *playBtn;
@property(nonatomic,retain)UILabel *name,*content;
@property(nonatomic,retain)NSString *voiceUrl;
#if TARGET_OS_IPHONE
@property (readonly)			AQPlayer			*player;
#endif//TARGET_OS_IPHONE
@property						BOOL				playbackWasInterrupted;
@property						BOOL				playbackWasPaused;
- (IBAction)playvoice:(id)sender;
-(void)stopPlayQueue;
-(void)pausePlayQueue;
- (void)initVoice;
@end
