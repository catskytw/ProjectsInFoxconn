//
//  TenKHorseAppDelegate.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/24.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "TenKHorseAppDelegate.h"
#import "LocalizationSystem.h"
#import "Configure.h"
#import "QueryPattern.h"
@implementation TenKHorseAppDelegate

@synthesize window;
@synthesize tabBarController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch.
    
    // Add the tab bar controller's current view as a subview of the window
	//LocalizationSetLanguage(@"zh_TW");
    LocalizationSetLanguage(@"zh-Hans-CN");
	tabBarController.delegate=self;
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    tabBarController.selectedIndex=0;
    
    [[NSNotificationCenter defaultCenter]addObserver:[Tools class] selector:@selector(addWaitCursor) name:BeforeSync object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:[Tools class] selector:@selector(delWaitCursor) name:AfterSync object:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]removeObserver:[Tools class] name:BeforeSync object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:[Tools class] name:AfterSync object:nil];
    /*
     Called when the application is about to terminate.
     */
}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods
/*
 // Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/
/*
 // Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
 */

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

