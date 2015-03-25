//
//  Tools.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "Tools.h"
#import "iPhoneXMPPAppDelegate.h"
#import "RootViewController.h"
#import "SettingsViewController.h"
static UIView *waitView;

@implementation Tools
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize{
	CGSize maxSize=CGSizeMake(768, fontSize);
	return [examString sizeWithFont:[UIFont fontWithName:@"STHeitiTC-Light" size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize{
	return [examString sizeWithFont:[UIFont fontWithName:@"STHeitiTC-Light" size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize withFontName:(NSString*)fontName{
	return [examString sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(UIColor*)convertString2UIColor:(NSString*)colorString{
    //the colorString's syntax: #ffffff
    if([colorString isEqualToString:@"-"])
        return [UIColor clearColor];
    unsigned r=0,g=0,b=0;
    NSScanner *scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&r];
    scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&g];
    scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&b];
    return [UIColor colorWithRed:(CGFloat)r/255.0f green:(CGFloat)g/255.0f blue:(CGFloat)b/255.0f alpha:1];
}

+(void)runWaitCursor{
    NSAutoreleasePool *cursorPool=[[NSAutoreleasePool alloc] init];
	waitView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	[waitView setUserInteractionEnabled:YES];
	[waitView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]];
	
	UIActivityIndicatorView *waitCursor=[[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 32, 32)]autorelease];
	[waitCursor setCenter:CGPointMake(160,240)];
	[waitCursor setHidesWhenStopped:YES];
	[waitCursor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[waitCursor startAnimating];
	[waitView addSubview:waitCursor];
	
	UILabel *waitLabel=[[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)]autorelease];
	[waitLabel setCenter:CGPointMake(160,270)];
	[waitLabel setText:@"Please Wait..."];
	[waitLabel setTextColor:[UIColor whiteColor]];
	[waitLabel setTextAlignment:UITextAlignmentCenter];
	[waitLabel setBackgroundColor:[UIColor clearColor]];
	[waitView addSubview:waitLabel];
	[waitView setTag:1000];
    [((SettingsViewController*)((iPhoneXMPPAppDelegate*)[[UIApplication sharedApplication] delegate]).settingsViewController).view addSubview:waitView];
	[cursorPool release];
}
+(void)addWaitCursor{
    if(waitView!=nil)
        return;
    [NSThread detachNewThreadSelector:@selector(runWaitCursor) toTarget:[Tools class] withObject:nil];
}

+(void)delWaitCursor{
	[[((SettingsViewController*)((iPhoneXMPPAppDelegate*)[[UIApplication sharedApplication] delegate]).settingsViewController).view viewWithTag:1000]removeFromSuperview];	
	[waitView release];
	waitView=nil;
    
}

@end
