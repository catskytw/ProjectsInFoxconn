//
//  OveExpoAppDelegate.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OveExpoAppDelegate.h"
#import "LoginDataObject.h"
#import "AccountLoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "FcUITabbar.h"
#import "FcTabBarItem.h"
#import "FcConfig.h"
#import "MapDAO.h"
#import "QueryPattern.h"
@interface OveExpoAppDelegate(PrivateMethod)
-(void)setAllTabBarItems;
@end
@implementation OveExpoAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    //LocalizationSetLanguage(@"zh-Hans");
    NSLocale *_locale = [NSLocale currentLocale];
    //NSString *_lang =  [_locale displayNameForKey:NSLocaleIdentifier value:[_locale localeIdentifier]];
    NSString *_lang = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([_lang isEqualToString:@"en"] == YES) {
        LocalizationSetLanguage(@"en");
    }
    else //if([_lang isEqualToString:@"Chinese"] == YES)
    {
        LocalizationSetLanguage(@"zh-Hans");
    }
    
    self.window.rootViewController = self.tabBarController;
    [self setAllTabBarItems];
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowActivityIndicatorNotification:) name:SHOW_ACTIVITY_INDICATOR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCloseActivityIndicatorNotification:) name:CLOSE_ACTIVITY_INDICATOR object:nil];
#ifdef USE_iOS5_FIX_PROBLEM
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        [[UINavigationBar appearance] setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 44) forNinePatchNamed:@"img_actionbar"] forBarMetrics:UIBarMetricsDefault]; 
        //或 [navigationController.navigationBar setBackgroundImage:myImage forBarMetrics:UIBarMetricsDefault]
        [[UITabBar appearance] setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 48) forNinePatchNamed:@"img_belowbar"]];
    }
#endif
    return YES;
}
-(void)test{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:1316767753];
    NSLocale *zhLocale=[[NSLocale alloc]initWithLocaleIdentifier:@"en-us"];
    
    [dateFormatter setLocale:zhLocale];
    
    NSLog(@"Date for locale:%@",[dateFormatter stringFromDate:date]);
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
            loginView = [AccountLoginViewController new];
            [self.tabBarController.view addSubview:loginView.view];
        }else if([response isEqualToString:@""]){
            
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

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    if (loginView) {
        [loginView release];
        loginView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

-(void)setAllTabBarItems{
    NSArray *allViewControllers=self.tabBarController.viewControllers;
    NSLog(@"all controllers is %i",[allViewControllers count]);
    NSArray *names=[NSArray arrayWithObjects:
                    AMLocalizedString(@"tab_home", nil),
                    AMLocalizedString(@"schedule", nil),
                    AMLocalizedString(@"qrcode", nil),
                    AMLocalizedString(@"namecard", nil)
                    , nil];
    NSArray *pics=[NSArray arrayWithObjects:
                   @"tabbar_home.png",
                   @"tabbar_schedule.png",
                   @"tabbar_qrcode.png",
                   @"tabbar_namecard.png"
                   , nil];
    NSArray *pics_i=[NSArray arrayWithObjects:
                   @"tabbar_home_i.png",
                   @"tabbar_schedule_i.png",
                   @"tabbar_qrcode_i.png",
                   @"tabbar_namecard_i.png"
                   , nil];
    
    int count=0;
    for(UIViewController *each in allViewControllers){
        FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:[names objectAtIndex:count] image:[UIImage imageNamed:[pics objectAtIndex:count]] tag:count];
        thisBarItem.customStdImage=[UIImage imageNamed:[pics objectAtIndex:count]];
        thisBarItem.customHighlightedImage=[UIImage imageNamed:[pics_i objectAtIndex:count]];
        each.tabBarItem=thisBarItem;
        [thisBarItem release];
        
        count++;
    }
}
@end
