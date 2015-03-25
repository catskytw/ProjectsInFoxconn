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
#import "SyncProcess.h"
#import "NSString+extension.h"
#import "FMResultSet.h"
#import "SingletonDBConnect.h"
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
    [self test];
    [[NSNotificationCenter defaultCenter]addObserver:[Tools class] selector:@selector(addWaitCursor) name:BeforeSync object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:[Tools class] selector:@selector(delWaitCursor) name:AfterSync object:nil];
    return YES;
}

-(void)test{
    //NSString *sql= @"SELECT ID,image46,image110,image250 FROM T_PRODUCT_IMAGE0 WHERE SORT_NUMBER=1 AND REF_product=\"1C5035E9DA6E43F1B295B50DD25D1A3B\"";
    NSString *sql=@"SELECT * FROM T_PRODUCT WHERE ID=\"E299CF59B83C4FB495D5D67082A85FAF\"";
    FMResultSet *rs=[[SingletonDBConnect share]executeQuery:sql];
    while ([rs next]) {
        NSLog(@"ID:%@",[rs stringForColumn:@"ID"]);
        NSLog(@"NAME:%@",[rs stringForColumn:@"PRODUCT_NAME"]);
        NSLog(@"COLOR:%@",[rs stringForColumn:@"COLOR"]);
    }
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


 // Optional UITabBarControllerDelegate method

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [tabBarController retain];
    if(tabBarController.selectedIndex!=0){
        [Tools FcMessageWindows:AMLocalizedString(@"NotOfferThisFunction", nil) withParentView:viewController.view];
        tabBarController.selectedIndex=0;
    }
    [tabBarController release];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(tabBarController.selectedIndex!=0){
        [Tools FcMessageWindows:AMLocalizedString(@"NotOfferThisFunction", nil) withParentView:viewController.view];
    }
    return NO;
}

/*
 // Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
 */

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end
