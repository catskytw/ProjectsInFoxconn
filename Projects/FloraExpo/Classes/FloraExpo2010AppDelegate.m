//
//  FloraExpo2010AppDelegate.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FloraExpo2010AppDelegate.h"
#import "RootViewController.h"
#import "Vars.h"
@implementation FloraExpo2010AppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

