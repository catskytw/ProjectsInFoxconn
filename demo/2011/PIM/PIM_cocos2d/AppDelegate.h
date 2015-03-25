//
//  AppDelegate.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/27.
//  Copyright foxconn 2011年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
