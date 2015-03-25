//
//  UITuneLayout.m
//  WMBT
//
//  Created by link on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "MobileOfficeAppDelegate.h"
static UIView *waitView;
@implementation UITuneLayout
//set Navigation bar title font 
+(void) setNaviTitle: (id)controller{
    CGRect frame = CGRectMake(0,0, 180, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    //label.font = [UIFont boldSystemFontOfSize:21];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:26.0]];
    label.shadowColor = [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor= [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:1];
    UIViewController *ctrl = (UIViewController*)controller;
    ctrl.navigationItem.titleView = label;
    label.text= ctrl.navigationItem.title;
    [ctrl.navigationController.navigationBar setTintColor:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:0]]; 
}
+(void) setBackground:(id)view{
    //設定背景圖示 [UIImage imageNamed:thumbnailPath]]
    UIImage *img = [UIImage imageNamed:@"contentui_bg_gary_background.png"];
	[view setBackgroundColor:[UIColor colorWithPatternImage:img]];
	//[img release];
}
// takes 0x123456
+(UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}
// takes @"#123456"
+(UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}
+(NSString *)getMoneyString:(NSString *)str {
    NSString* returnStr = [NSString stringWithFormat:@"%@: %@",AMLocalizedString(@"money_unit", nil), str];
    return returnStr;
}
+(void)runWaitCursor{
    NSAutoreleasePool *cursorPool=[[NSAutoreleasePool alloc] init];
    NSInteger _screenH = [[UIScreen mainScreen] bounds].size.width;
    NSInteger _screenW = [[UIScreen mainScreen] bounds].size.height;
    UIDeviceOrientation _orientation = [[UIDevice currentDevice] orientation];
    //UIDeviceOrientationPortrait
	waitView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _screenW, _screenH)];
	[waitView setUserInteractionEnabled:YES];
	[waitView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]];
	
	UIActivityIndicatorView *waitCursor=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 32, 32)]autorelease];
	[waitCursor setCenter:CGPointMake(_screenW/2,_screenH/2)];
	[waitCursor setHidesWhenStopped:YES];
	[waitCursor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[waitCursor startAnimating];
	[waitView addSubview:waitCursor];
	
	UILabel *waitLabel=[[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)]autorelease];
	[waitLabel setCenter:CGPointMake(_screenW/2,_screenH/2+30)];
	[waitLabel setText:AMLocalizedString(@"PleaseWait",nil)];
	[waitLabel setTextColor:[UIColor whiteColor]];
	[waitLabel setTextAlignment:UITextAlignmentCenter];
	[waitLabel setBackgroundColor:[UIColor clearColor]];
	[waitView addSubview:waitLabel];
	[waitView setTag:1000];
    //[(((OveExpoAppDelegate*)[[UIApplication sharedApplication] delegate]).tabBarController).view addSubview:waitView];
    [((MobileOfficeAppDelegate*)[[UIApplication sharedApplication] delegate]).window.rootViewController.view addSubview:waitView];
	[cursorPool release];
}

+(void)addWaitCursor{
    if(waitView!=nil)
        return;
    [NSThread detachNewThreadSelector:@selector(runWaitCursor) toTarget:[UITuneLayout class] withObject:nil];
}

+(void)delWaitCursor{
	//[[[((MobileOfficeAppDelegate*)[[UIApplication sharedApplication] delegate]).viewController].view viewWithTag:1000]removeFromSuperview];	
    [waitView removeFromSuperview];
	[waitView release];
	waitView=nil;
    
}
@end
