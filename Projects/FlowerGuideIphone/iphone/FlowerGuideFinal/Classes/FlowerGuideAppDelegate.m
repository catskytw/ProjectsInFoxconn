//
//  FlowerGuideAppDelegate.m
//  FlowerGuide
//
//  Created by Change Liao on 9/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FlowerGuideAppDelegate.h"
#import "FeatureCtrlCollections.h"
#import "AllContentPointProperties.h"
#import "LocalizationSystem.h"
#import "Vars.h"

@implementation FlowerGuideAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    // Override point for customization after app launch 
	[[UIApplication sharedApplication]setStatusBarHidden:YES animated:NO];
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];

	//設定zh_TW為預設語言
	LocalizationSetLanguage(@"zh_TW");
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	//release the singlton object
	if([FeatureCtrlCollections current]!=nil)
		[[FeatureCtrlCollections current]release];
	if([AllContentPointProperties current]!=nil)
		[[AllContentPointProperties current]release];

	[navigationController release];
	[window release];
	[super dealloc];
}


@end

