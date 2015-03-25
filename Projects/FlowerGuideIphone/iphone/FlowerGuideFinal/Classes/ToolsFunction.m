//
//  ToolsFunction.m
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 2009/11/3.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#import <mach/mach.h>
#import "ToolsFunction.h"
#import "DownloadThreadObject.h"
#import "LocalizationSystem.h"
#import "Vars.h"
static UIView *waitView;

@implementation ToolsFunction

/**
 ascending sorting
 */
+(NSArray*)getOneASCSortDescriptor:(NSString*)key{
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key
												  ascending:YES] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	return sortDescriptors;
}
/**
 deascending sorting
 */
+(NSArray*)getOneDeascSortDescriptor:(NSString*)key{
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:key
												  ascending:NO] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	return sortDescriptors;
}


+(int)getIntFromLittleNSData:(NSData*)data{
	int result;
	if([data length]<=2){
		short i;
		[data getBytes:&i length:2];
#ifdef USELITTLEENDIAN
		i=NSSwapHostShortToBig(i);
#endif
		result=i;
	}else{
		[data getBytes:&result length:4];
#ifdef USELITTLEENDIAN
		result=NSSwapHostIntToBig(result);
#endif
	}
	return result;
}

+(void)getImageFromURL:(NSString*)urlString withTargetUIImageView:(UIImageView*)targetImageView{
	DownloadThreadObject *downloadObject=[DownloadThreadObject new];
#ifdef USEPREFIXIMAGE
	[downloadObject start:[NSString stringWithFormat:@"%@%@",URLHead,urlString] withTargetView:targetImageView];
#else if
	[downloadObject start:urlString withTargetView:targetImageView];
#endif
	[downloadObject autorelease];
}
+(void)getImageFromURL:(NSString*)urlString withTargetUIImageView:(UIImageView*)targetImageView withNotificationString:(NSString*)notificationString{
	DownloadThreadObject *downloadObject=[DownloadThreadObject new];
	downloadObject.notificationName=notificationString;
#ifdef USEPREFIXIMAGE
	[downloadObject start:[NSString stringWithFormat:@"%@%@",URLHead,urlString] withTargetView:targetImageView];
#else if
	[downloadObject start:urlString withTargetView:targetImageView];
#endif
	[downloadObject autorelease];
}

+(void)getImageFromURL:(NSString*)urlString withTargetButton:(UIButton*)targetButton{
	DownloadThreadObject *downloadObject=[DownloadThreadObject new];
#ifdef USEPREFIXIMAGE
	[downloadObject start:[NSString stringWithFormat:@"%@%@",URLHead,urlString] withTargetButton:targetButton];
#else if
	[downloadObject start:urlString withTargetButton:targetImageView];
#endif
	[downloadObject autorelease];
}

+(CGSize)getContentTextSize:(NSString*)stringText withWidth:(NSInteger)width withFontSize:(NSInteger)fontSize{
	CGSize maxSize = { width, 100000 };
	CGSize actualSize=[stringText sizeWithFont:[UIFont fontWithName:@"Arial" size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	return actualSize;
}
+(CGSize)getContentTextWidthSize:(NSString*)stringText withHeight:(NSInteger)height withFontSize:(NSInteger)fontSize{
	CGSize maxSize = { 1000000, height };
	CGSize actualSize=[stringText sizeWithFont:[UIFont fontWithName:@"Arial" size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	
	return actualSize;
}
+(UIImage*)getBatteryImage:(NSInteger)batteryIndex{
	UIImage *batteryPic;
	switch (batteryIndex) {
		default:
		case 1:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery1.png"];
			break;
		case 2:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery2.png"];
			break;
		case 3:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery3.png"];
			break;
		case 4:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery4.png"];
			break;
		case 5:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery5.png"];
			break;
		case 6:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery6.png"];
			break;
		case 7:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery7.png"];
			break;
		case 8:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery8.png"];
			break;
		case 9:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery9.png"];
			break;
		case 10:
			batteryPic=[UIImage imageNamed:@"phoneui_icon_battery10.png"];
			break;
	}
	return batteryPic;
}


+(BOOL)conntectedToNetwork{
	//以0填滿的位址
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress,sizeof(zeroAddress));
	zeroAddress.sin_len=sizeof(zeroAddress);
	zeroAddress.sin_family=AF_INET;
	
	//取得可用的flag
	SCNetworkReachabilityRef defaultRouteReachability=SCNetworkReachabilityCreateWithAddress(NULL,(struct sockaddr*)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags=SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if(!didRetrieveFlags){
		printf("Error,no flags");
		return 0;
	}
	BOOL isReachable=flags&kSCNetworkFlagsReachable;
	BOOL needsConnection=flags&kSCNetworkFlagsConnectionRequired;
	return(isReachable&&!needsConnection)?YES:NO;
}

+(BOOL)hasConnected{
	if(![ToolsFunction conntectedToNetwork]){
		UIAlertView *noNetworkAlert=[[UIAlertView alloc]
									 initWithTitle: AMLocalizedString(@"Warning",nil)
									 message: AMLocalizedString(@"NoConnectionMessage",nil) 
									 delegate: nil
									 cancelButtonTitle: AMLocalizedString(@"Cancel",nil)
									 otherButtonTitles:nil
									 ];
		[noNetworkAlert show];
		((UILabel*)[[noNetworkAlert subviews]objectAtIndex:1]).textAlignment=UITextAlignmentLeft;

		[noNetworkAlert release];
		return NO;
	}
	return YES;
}

+(BOOL)hasCorrectJSON:(NSString*)checkString{
	if(![checkString isEqualToString:@"0"] || checkString==nil){
		NSMutableString *responseString=[NSMutableString stringWithString:checkString];
		[responseString appendString:@"\n"];
		[responseString appendString:AMLocalizedString(@"InCorrectJSONMessage",nil)];
		UIAlertView *incorrectJSONAlert=[[UIAlertView alloc]
									 initWithTitle: AMLocalizedString(@"Warning",nil)
									 message: responseString  
									 delegate: nil
									 cancelButtonTitle: AMLocalizedString(@"Cancel",nil)
									 otherButtonTitles:nil
									 ];
		[incorrectJSONAlert show];
		((UILabel*)[[incorrectJSONAlert subviews]objectAtIndex:1]).textAlignment=UITextAlignmentLeft;
		
		[incorrectJSONAlert release];
		return NO;
	}
	return YES;
}

+(void)report_memory{
	struct task_basic_info info;
	mach_msg_type_name_t size=sizeof(info);
	kern_return_t kerr=task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
	if(kerr==KERN_SUCCESS){
		NSLog(@"Memory userd:%u bytes",info.resident_size);
	}else{
		NSLog(@"ERROR:%s",mach_error_string(kerr));
	}
}

+(NSString*)currentMillionSec{
	return [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
}

+(double)getCurrentTime{
	return [[NSDate date]timeIntervalSince1970];
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
	[cursorPool drain];
}
+(void)delWaitCursor{
	[[[[UIApplication sharedApplication] keyWindow]viewWithTag:1000]removeFromSuperview];		
	[waitView release];
	waitView=nil;
}
@end
