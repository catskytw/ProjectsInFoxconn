//
//  Hello_SOAPAppDelegate.m
//  Hello_SOAP
//
//  Created by Dave McAnall on 11/2/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "Hello_SOAPAppDelegate.h"
#import "Hello_SOAPViewController.h"

@implementation Hello_SOAPAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
    [window addSubview:viewController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}


@end
