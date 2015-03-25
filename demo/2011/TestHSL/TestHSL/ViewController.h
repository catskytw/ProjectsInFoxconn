//
//  ViewController.h
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/10/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController : UIViewController{
    MPMoviePlayerController *cameraPlayer;
    MPMoviePlayerController *desktopPlayer;
    UIWebView *webView;
    
    UIView *frame1,*frame2;
    BOOL isLandscape;
}
@property(nonatomic,retain)MPMoviePlayerController *cameraPlayer,*desktopPlayer;
-(IBAction)cameraPlay:(id)sender;
-(IBAction)desktopPlay:(id)sender;
@end

