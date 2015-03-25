//
//  DemoJSONTemplateAppDelegate.h
//  DemoJSONTemplate
//
//  Created by 廖 晨志 on 2010/12/2.
//  Copyright 2010 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoJSONTemplateViewController;

@interface DemoJSONTemplateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DemoJSONTemplateViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DemoJSONTemplateViewController *viewController;

@end

