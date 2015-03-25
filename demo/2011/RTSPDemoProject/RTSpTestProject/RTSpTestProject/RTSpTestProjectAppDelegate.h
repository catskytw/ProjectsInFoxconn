//
//  RTSpTestProjectAppDelegate.h
//  RTSpTestProject
//
//  Created by Liao Chen-chih on 2011/9/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTSpTestProjectViewController;

@interface RTSpTestProjectAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RTSpTestProjectViewController *viewController;

@end
