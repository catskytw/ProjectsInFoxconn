//
//  MobileOfficeAppDelegate.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOLoginViewController.h"

@class MobileOfficeViewController;

@interface MobileOfficeAppDelegate : NSObject <UIApplicationDelegate, MOLoginDelegate> {
    IBOutlet UINavigationController *_navigationController;
}
@property(nonatomic,retain)IBOutlet UINavigationController *_navigationController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MobileOfficeViewController *viewController;

@end
