//
//  WMBTViewController.h
//  WMBT
//
//  Created by link on 2011/5/31.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountLoginViewController.h"
#import "FcTabBarItem.h"
@interface WMBTViewController : UITabBarController<UITabBarControllerDelegate> {
	id mainController;
	UINavigationController *WMBTNavigation;
    UINavigationController *shopcartNavigation;
    AccountLoginViewController *accountLoginView;
    FcTabBarItem *tabBarItemHome;
    FcTabBarItem *tabBarItemShopcart;
}
@property(nonatomic,retain)id WMBTNavigation;

-(void)setTabBarBg;
-(void)showLogin;
-(void)receiveShowLoginNotification:(NSNotification*)notification;
-(void)receiveCloseLoginNotification:(NSNotification*)notification;
@end
