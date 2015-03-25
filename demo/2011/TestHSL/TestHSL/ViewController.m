//
//  ViewController.m
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/10/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Tools.h"
#import "CameraURL.h"
#import "DesktopURL.h"
/*
#define DESKTOPURL @"http://10.62.12.161:8080/desktop.mpjpeg"
#define SNGURL @"http://10.62.12.161:18298/live/livestream.m3u8"
 */

@interface ViewController(PrivateMethod)
- (void) moviePlayBackDidFinish:(NSNotification*)notification;
-(void)addNewHSLPlayer:(NSInteger)whichOne withNSURL:(NSURL*)url;
-(void)addNewCamera;
-(void)addNewDesktop;
-(void)stopAll;
-(void)addMJPEG;
-(void)tuneLayout;
@end
@implementation ViewController
@synthesize cameraPlayer,desktopPlayer;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewDidLoad{
    [super viewDidLoad];
    isLandscape=NO;
    self.title=@"視訊串流";
    UIColor *myColor=[UIColor colorWithRed:(CGFloat)84.0f/256.0f green:(CGFloat)98.0f/256.0f blue:(CGFloat)124.0f/256.0f alpha:1];
    frame1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 640, 480)];
    [frame1 setBackgroundColor:myColor];
    frame2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 640, 480)];
    [frame2 setBackgroundColor:myColor];
    [self.view addSubview:frame1];
    [self.view addSubview:frame2];
    
    [self addNewCamera];
    [self addMJPEG];
    [self tuneLayout];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)tuneLayout{
    if(isLandscape){
        [webView setFrame:CGRectMake(3, 3, 506, 378)];
        [cameraPlayer.view setFrame:CGRectMake(3, 3, 506, 378)];
        [frame1 setFrame:CGRectMake(0, 160, 512, 384)];
        [frame2 setFrame:CGRectMake(513, 160, 512, 384)];
    }else{
        [webView setFrame:CGRectMake(3, 3, 634, 474)];
        [cameraPlayer.view setFrame:CGRectMake(3, 3, 634, 474)];
        [frame1 setFrame:CGRectMake(64, 0, 640, 480)];
        [frame2 setFrame:CGRectMake(64, 481, 640, 480)];
    }
    [frame2 sizeToFit];
    [frame1 sizeToFit];
}
-(void)addMJPEG{
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(3, 3, 634, 474)];
    NSString *urlString=[NSString stringWithFormat:@"%@/desktop.mpjpeg",[DesktopURL desktopURL]];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    webView.scalesPageToFit=YES;
    [frame2 addSubview:webView];
}
-(void)addNewCamera{
    //NSURL *cameraUrl=[NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    NSString *urlString=[NSString stringWithFormat:@"%@/live/livestream.m3u8",[CameraURL cameraURL]];
    NSURL *cameraUrl=[NSURL URLWithString:urlString];
    [self addNewHSLPlayer:0 withNSURL:cameraUrl];
}
-(void)addNewDesktop{
        //http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8
    //NSURL *desktopURL=[NSURL URLWithString:@"http://10.62.12.161:18298/screen/stream.m3u8"];
    NSURL *desktopURL=[NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    [self addNewHSLPlayer:1 withNSURL:desktopURL];
}
-(void)addNewHSLPlayer:(NSInteger)whichOne withNSURL:(NSURL*)url{
    //whichOne 0:camera
    //         1:desktop
    MPMoviePlayerController *player;
    if(whichOne==0){
        cameraPlayer=[[MPMoviePlayerController alloc] initWithContentURL:url];
        player=cameraPlayer;
    }
    else{
        desktopPlayer=[[MPMoviePlayerController alloc] initWithContentURL:url];
        player=desktopPlayer;
    }
    [player setContentURL:url];
    player.scalingMode = MPMovieScalingModeAspectFit;
    player.controlStyle =MPMovieControlStyleEmbedded;	
    player.backgroundView.backgroundColor = [UIColor clearColor];
    player.repeatMode = MPMovieRepeatModeOne;
    player.useApplicationAudioSession =NO;
    [player setMovieSourceType:MPMovieSourceTypeStreaming];
    
    CGRect targetFrame=CGRectMake(3, 3, 634, 474);
    [player.view setFrame:targetFrame];
    [frame1 addSubview:player.view];
    [player setShouldAutoplay:YES];
    [player play];
}

-(IBAction)cameraPlay:(id)sender{
    [self stopAll];
    [cameraPlayer play];
}
-(IBAction)desktopPlay:(id)sender{
    [self stopAll];
    [desktopPlayer play];
}
-(void)stopAll{
    [desktopPlayer stop];
    [cameraPlayer stop];
}
- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    isLandscape=(interfaceOrientation==UIInterfaceOrientationPortrait || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)?NO:YES;
    [self tuneLayout];
    return YES;
}
-(void)setNaviTitle{
    UIViewController *ctrl = self;
    CGSize _stringSize=[Tools estimateStringSize:ctrl.navigationItem.title withFontSize:24.0f withMaxSize:CGSizeMake(180, 44)];
    CGRect frame = CGRectMake(0,0, _stringSize.width, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:24.0]];
    label.shadowColor = [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor= [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:1];
    
    ctrl.navigationItem.titleView = label;
    
    
    label.text= ctrl.navigationItem.title;
    [ctrl.navigationController.navigationBar setTintColor:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:0]]; 
}
@end
