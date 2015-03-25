//
//  MobileOfficeAppDelegate.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MobileOfficeAppDelegate.h"

#import "MobileOfficeViewController.h"
#import "LocalizationSystem.h"
#import "MOLoginViewController.h"
#import "FcConfig.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
@implementation MobileOfficeAppDelegate


@synthesize window=_window;
@synthesize _navigationController;
@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    LocalizationSetLanguage(@"zh-Hant-TW");
    //self.window.rootViewController = self.viewController;
    MOLoginViewController *loginView = [[MOLoginViewController alloc] initWithNibName:nil bundle:nil];
    
    [loginView setDelegate:self];
//    self.window.rootViewController = _navigationController;
    self.window.rootViewController=loginView;
    [self.window makeKeyAndVisible];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowActivityIndicatorNotification:) name:SHOW_ACTIVITY_INDICATOR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCloseActivityIndicatorNotification:) name:CLOSE_ACTIVITY_INDICATOR object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)didReceiveLoginResult:(BOOL)isOK
{
    NSLog(isOK?@"Login Success!":@"Login Failed!");
    //if (isOK == YES) 
    self.window.rootViewController = _navigationController;
}

-(void)receiveShowActivityIndicatorNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:SHOW_ACTIVITY_INDICATOR]) {
        NSLog(@"received ShowActivityIndicator");
        [UITuneLayout addWaitCursor];
    }
}
-(void)receiveCloseActivityIndicatorNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:CLOSE_ACTIVITY_INDICATOR]) {
        NSLog(@"received CloseActivityIndicator");
        NSDictionary *dic=notification.userInfo;
        QueryPattern *query=[(QueryPattern*)[dic valueForKey:@"QueryPatternSelf"]retain];
        NSString *response = [query getValue:@"response" withIndex:0];
        if([response isEqualToString:@"0"]){
            NSLog(@"receiveCloseActivityIndicatorNotification response 0");
        }else if([response isEqualToString:@"ACCT002"]){
            NSString *_message = [query getValue:@"message" withIndex:0];
            UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"失敗", nil) message:_message delegate:self cancelButtonTitle:AMLocalizedString(@"確定", nil) otherButtonTitles:nil];
            [_alert show];
            [_alert release];
            
            MOLoginViewController *loginView = [[MOLoginViewController alloc] initWithNibName:nil bundle:nil];
            [loginView setDelegate:self];
            self.window.rootViewController=loginView;
            //loginView = [MOLoginViewController new];
            //[self.tabBarController.view addSubview:loginView.view];
        }
        else
        {
            NSString *_message = [query getValue:@"message" withIndex:0];
            UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"失敗", nil) message:_message delegate:self cancelButtonTitle:AMLocalizedString(@"確定", nil) otherButtonTitles:nil];
            [_alert show];
            [_alert release];
        }
        [UITuneLayout delWaitCursor];
        [query release];
    }
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
