//
//  GameDemoAppDelegate.h
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright foxconn 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface GameDemoAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
