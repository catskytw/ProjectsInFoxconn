//
//  Tools.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Tools.h"
#import "LocalizationSystem.h"
#import "DownloadThreadObject.h"
static UIView *waitView;
@implementation Tools
+(UIViewController*)lastSecondUIViewController:(UINavigationController*)inputController{
	NSArray *allViewControllers=[inputController viewControllers];
	return (UIViewController*)[allViewControllers objectAtIndex:[allViewControllers count]-2];
}

+(NSString*)replaceSpaceToPlus:(NSString*)inputTextString{
	return [inputTextString stringByReplacingOccurrencesOfString:@" " 
														   withString:@"+"];
}
+(void)getImageFromURL:(NSString*)urlString withTargetUIImageView:(UIImageView*)targetImageView{
	DownloadThreadObject *downloadObject=[DownloadThreadObject new];
	[downloadObject start:urlString withTargetView:targetImageView];
	[downloadObject autorelease];
}
+(void)addWaitCursor{
	NSAutoreleasePool *cursorPool=[[NSAutoreleasePool alloc] init];
	waitView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	[waitView setUserInteractionEnabled:YES];
	[waitView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]];
	
	UIActivityIndicatorView *waitCursor=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 32, 32)]autorelease];
	[waitCursor setCenter:CGPointMake(160,208)];
	[waitCursor setHidesWhenStopped:YES];
	[waitCursor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[waitCursor startAnimating];
	[waitView addSubview:waitCursor];
	
	UILabel *waitLabel=[[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)]autorelease];
	[waitLabel setCenter:CGPointMake(160,180)];
	[waitLabel setText:AMLocalizedString(@"PleaseWait",nil)];
	[waitLabel setTextColor:[UIColor whiteColor]];
	[waitLabel setTextAlignment:UITextAlignmentCenter];
	[waitLabel setBackgroundColor:[UIColor clearColor]];
	[waitView addSubview:waitLabel];
	[waitView setTag:1000];
	[[[UIApplication sharedApplication] keyWindow]addSubview:waitView];
	[cursorPool release];
}
+(void)delWaitCursor{
	[[[[UIApplication sharedApplication] keyWindow]viewWithTag:1000]removeFromSuperview];	
	[waitView release];
	waitView=nil;
}
@end
