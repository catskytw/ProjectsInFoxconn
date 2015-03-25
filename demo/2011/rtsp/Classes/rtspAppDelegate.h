//
//  rtspAppDelegate.h
//  rtsp
//
//  Created by Felix  Enriquez on 14/07/10.
//  Copyright Generamobile 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTSPClientSession.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoDecoder.h"

@interface rtspAppDelegate : NSObject <UIApplicationDelegate, RTSPSubsessionDelegate > {
    UIWindow *window;
	MPMoviePlayerController *player; 
	NSMutableData		*data;  
	RTSPClientSession *session;
    VideoDecoder *decoder;
    IBOutlet UIImageView *image;
	char* rawsdp;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic,retain)IBOutlet UIImageView *image;
-(IBAction) click;
-(IBAction) click2;
-(IBAction) click3;
-(IBAction) click4;
-(IBAction) click5;

@end

