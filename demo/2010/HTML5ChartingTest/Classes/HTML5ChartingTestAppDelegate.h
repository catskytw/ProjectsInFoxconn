//
//  HTML5ChartingTestAppDelegate.h
//  HTML5ChartingTest
//
//  Created by 廖 晨志 on 2011/1/3.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTML5ChartingTestViewController;

@interface HTML5ChartingTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HTML5ChartingTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HTML5ChartingTestViewController *viewController;

@end

