//
//  WMBTViewController.m
//  WMBT
//
//  Created by link on 2011/5/31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WMBTViewController.h"
#import "MainMenuViewController.h"

#import "LoginDataObject.h"
#import "AccountLoginViewController.h"
#import "ShoppingListController.h"
#import "Configure.h"
#import "Tools.h"
@implementation WMBTViewController
@synthesize WMBTNavigation;
//static WMBTViewController* singletonWMBTViewController;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {	
        self.delegate=self;
        WMBTNavigation=[[UINavigationController alloc]init];
        shopcartNavigation=[[UINavigationController alloc]init];
        //LocalizationSetLanguage(@"zh-Hant-TW");
        LocalizationSetLanguage(@"zh-Hans-CN");
        tabBarItemHome=[[FcTabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"contentui_btn_underbar_home.png"] tag:0];
        tabBarItemShopcart=[[FcTabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:@"contentui_btn_underbar_shopping_cart.png"] tag:1];
        
        tabBarItemHome.customHighlightedImage = [UIImage imageNamed:@"contentui_btn_underbar_home_i.png"];
        tabBarItemHome.customStdImage = [UIImage imageNamed:@"contentui_btn_underbar_home.png"];
        
        tabBarItemShopcart.customHighlightedImage = [UIImage imageNamed:@"contentui_btn_underbar_shopping_cart_i.png"];
        tabBarItemShopcart.customStdImage = [UIImage imageNamed:@"contentui_btn_underbar_shopping_cart.png"];
        tabBarItemHome.imageInsets = UIEdgeInsetsMake(7.0,0,-7,0);
        tabBarItemShopcart.imageInsets = UIEdgeInsetsMake(7.0,0,-7,0);
        WMBTNavigation.tabBarItem=tabBarItemHome;
        MainMenuViewController *mainMenu=[[MainMenuViewController alloc] init] ;
        mainMenu.mainController = self;
        [WMBTNavigation pushViewController:mainMenu animated:NO];
	
        shopcartNavigation.tabBarItem=tabBarItemShopcart;

        ShoppingListController *shoppingListController = [[ShoppingListController alloc] initWithNibName:@"ShoppingListController" bundle:nil];
        shoppingListController.currentNavigationController = self.navigationController;
                
        [shopcartNavigation pushViewController:shoppingListController animated:NO];
        [shoppingListController release];
        
        NSMutableArray *controllers=[NSMutableArray arrayWithObjects:WMBTNavigation,shopcartNavigation,nil];
        
        self.viewControllers=controllers;
        [self showLogin];
                // customize the tab bar background
        [self setTabBarBg];
        // end custom tab bar
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCloseLoginNotification:) name:@"closeLogin" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowLoginNotification:) name:@"showLogin" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowBadgeValuNotification:) name:@"changeBadgeValue" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveShowActivityIndicatorNotification:) name:SHOW_ACTIVITY_INDICATOR object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCloseActivityIndicatorNotification:) name:CLOSE_ACTIVITY_INDICATOR object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSessionErrorNotification:) name:SESSION_ERROR object:nil];
        
        [mainMenu release];
        [WMBTNavigation release];
        [shopcartNavigation release];
        

    }
    return self;
}
-(void)receiveSessionErrorNotification:(NSNotification*)notification{
    NSLog(@"received SessionErrorNotification");
    LoginDataObject *loginDao=[LoginDataObject sharedInstance];
    [loginDao cleanLogData];
    [self showLogin];
}
-(void)receiveShowActivityIndicatorNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:SHOW_ACTIVITY_INDICATOR]) {
        NSLog(@"received ShowActivityIndicator");
        [Tools addWaitCursor];
    }
}
-(void)receiveCloseActivityIndicatorNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:CLOSE_ACTIVITY_INDICATOR]) {
        NSLog(@"received CloseActivityIndicator");
        [Tools delWaitCursor];
    }
}
-(void) showLogin{
    accountLoginView= [[AccountLoginViewController alloc]init];
    accountLoginView.mainController = self;
    [self.view addSubview: accountLoginView.view];
}
-(void)receiveShowLoginNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:@"showLogin"]) {
        NSLog(@"received show login");
        [self showLogin];
    }
}

-(void)receiveCloseLoginNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:@"closeLogin"]) {
        NSLog(@"received close login");
        [accountLoginView.view removeFromSuperview];
        [accountLoginView release];
    }
}

-(void)receiveShowBadgeValuNotification:(NSNotification*)notification{
    if ([[notification name] isEqualToString:@"changeBadgeValue"]) {
        NSLog(@"received changeBadgeValue");
        if ([[[notification userInfo] allKeys]count]>0) {
            tabBarItemShopcart.badgeValue=[NSString stringWithFormat:@"%d",[[[notification userInfo] allKeys]count]];
        }else{
            tabBarItemShopcart.badgeValue=nil;
        }
    }
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [viewController.navigationController popToRootViewControllerAnimated:NO];
}
// customize the tab bar background
-(void) setTabBarBg
{
    CGRect frame = CGRectMake(0, 0, 480, 49);
    UIView *viewBackround = [[UIView alloc] initWithFrame:frame];
    UIImage *imgBackground = [UIImage imageNamed:@"contentui_bg_underbar.png"];
    UIColor *colorPattern = [[UIColor alloc] initWithPatternImage:imgBackground];
    viewBackround.backgroundColor = colorPattern;
    [colorPattern release];
    [[self tabBar] insertSubview:viewBackround atIndex:0];
    [viewBackround release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [accountLoginView release];
    [tabBarItemHome release];
    [tabBarItemShopcart release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
