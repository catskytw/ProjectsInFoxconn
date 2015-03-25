//
//  OveExpoAppDelegate.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HealthCareAppDelegate.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "FcTabBarItem.h"
#import "LocalizationSystem.h"
#import "FcLocation.h"
#import "Tool.h"
#import "TestStaticLib.h"
@interface HealthCareAppDelegate(PrivateMethod)
-(void)setAllTabBarItems;
-(void)usingLocation;
@end
@implementation HealthCareAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    LocalizationSetLanguage(@"zh-Hans");
    TestStaticLib *testObj=[TestStaticLib new];
    NSLog(@"[%i]", [testObj plus:5 withB:10]);
    self.window.rootViewController = self.tabBarController;
    [self setAllTabBarItems];
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowActivityIndicatorNotification:) name:SHOW_ACTIVITY_INDICATOR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(usingLocation:) name:USING_LOCATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCloseActivityIndicatorNotification:) name:CLOSE_ACTIVITY_INDICATOR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCloseActivityIndicatorGoogleMapNotification:) name:CLOSE_ACTIVITY_INDICATOR_GOOGLEMAP object:nil];
    
#ifdef USE_iOS5_FIX_PROBLEM
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        [[UINavigationBar appearance] setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 44) forNinePatchNamed:@"img_actionbar"] forBarMetrics:UIBarMetricsDefault]; 
        //或 [navigationController.navigationBar setBackgroundImage:myImage forBarMetrics:UIBarMetricsDefault]
        [[UITabBar appearance] setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 48) forNinePatchNamed:@"img_belowbar"]];
    }
#endif
    tabIndex = 0;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    showSOS = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:USING_LOCATION object:nil];
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

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
#pragma -
#pragma mark -  DelegateMethod

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    [FcLocation setNowLocation:newLocation];
    NSLog(@"getLocation");
    if (showSOS) {
        showSOS = NO;
        NSString *m_address = [Tool getReGeoCode:newLocation];
        NSString *m_alertMessage =[NSString stringWithFormat:@"%@ %@ %@", AMLocalizedString(@"SOS_Msg1",nil),m_address,AMLocalizedString(@"SOS_Msg2",nil)]; 
        NSString *m_alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"cancel", nil)];
        NSString *m_alertCallingbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"Confirm", nil)];
        UIAlertView *m_alert = [[[UIAlertView alloc] initWithTitle:nil message:m_alertMessage delegate:self cancelButtonTitle:m_alertCallingbutton otherButtonTitles:m_alertOtherbutton,nil]autorelease];
        
        UILabel *m_Body = [m_alert valueForKey:@"_bodyTextLabel"];
        [m_Body setTextAlignment:UITextAlignmentLeft];
        [m_alert show];
    }
    [locationManager stopUpdatingLocation];
}
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedIndex ==3) {
        showSOS = YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:RESET_REGISTERREC_INFO object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:USING_LOCATION object:nil];
        [tabBarController setSelectedIndex:tabIndex];
    }else{
        tabIndex =tabBarController.selectedIndex;
    }
}
//UIAlert delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    /* buttonIndex為,doSomething
    if (buttonIndex==0)
        [Tool makePhoneCall:@"073223288"];
     */
    
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/
#pragma -
#pragma mark -  PrivateMethod

-(void)setAllTabBarItems{
    NSArray *allViewControllers=self.tabBarController.viewControllers;
    NSArray *names=[NSArray arrayWithObjects:
                    AMLocalizedString(@"tab_home", nil),
                    AMLocalizedString(@"accountInfo", nil),
                    AMLocalizedString(@"registryHistory", nil),
                    AMLocalizedString(@"sos", nil)
                    , nil];
    NSArray *pics=[NSArray arrayWithObjects:
                   @"tabbar_home.png",
                   @"tabbar_user.png",
                   @"tabbar_logs.png",
                   @"tabbar_sos.png"
                   , nil];
    NSArray *pics_i=[NSArray arrayWithObjects:
                     @"tabbar_home_i.png",
                     @"tabbar_user_i.png",
                     @"tabbar_logs_i.png",
                     @"tabbar_sos_i.png"
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
-(void)usingLocation:(NSNotification*)notification{
    [locationManager startUpdatingLocation];
}
-(void)receiveShowActivityIndicatorNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:SHOW_ACTIVITY_INDICATOR]) {
        [UITuneLayout addWaitCursor];
    }
}
-(void)receiveCloseActivityIndicatorNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:CLOSE_ACTIVITY_INDICATOR]) {
        NSDictionary *dic=notification.userInfo;
        QueryPattern *query=[(QueryPattern*)[dic valueForKey:@"QueryPatternSelf"]retain];
        NSString *response = [query getValue:@"response" withIndex:0];
        NSString *status = [query getValue:@"status" withIndex:0]; //for google/maps/api
        if(![response isEqualToString:@"0"] && ![status isEqualToString:@"OK"] ){
            NSString *_message = [query getValue:@"message" withIndex:0];
            UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"失敗", nil) message:_message delegate:self cancelButtonTitle:AMLocalizedString(@"確定", nil) otherButtonTitles:nil];
            [_alert show];
            [_alert release];
        }
        [UITuneLayout delWaitCursor];
        [query release];
    }
}
-(void)receiveCloseActivityIndicatorGoogleMapNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:CLOSE_ACTIVITY_INDICATOR_GOOGLEMAP]) {
        [UITuneLayout delWaitCursor];
    }
}

@end