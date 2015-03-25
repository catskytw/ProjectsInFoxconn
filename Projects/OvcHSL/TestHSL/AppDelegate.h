//
//  AppDelegate.h
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/10/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *_tmpNavigationController;
}
@property (strong, nonatomic) UIWindow *window;
@end
