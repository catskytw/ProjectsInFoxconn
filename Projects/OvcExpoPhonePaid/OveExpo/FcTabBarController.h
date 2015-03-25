//
//  FcTabBarController.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcTabBarItem.h"
@interface FcTabBarController : UITabBarController{
    IBOutlet UITabBar *tabBar1;
}
@property(nonatomic,retain)UITabBar *tabBar1;
@end
