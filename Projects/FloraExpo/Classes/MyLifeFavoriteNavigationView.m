//
//  MyLifeFavoriteNavigationView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeFavoriteNavigationView.h"
#import "MyFavoriteLiftView.h"
#import "Vars.h"

@implementation MyLifeFavoriteNavigationView
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization	
		UITabBarItem *myItem=[[UITabBarItem alloc]initWithTitle:AMLocalizedString(@"MyFavorite",nil) image:[UIImage imageNamed:@"blackbarui_btn_favorite.png"] tag:1];
		self.tabBarItem=myItem;
		[myItem release];
		
		MyFavoriteLiftView *mrvc=[[MyFavoriteLiftView alloc]initWithCategory:govermentQuery];
		[self pushViewController:mrvc animated:NO];
		[mrvc.navigationItem setTitle:AMLocalizedString(@"MyFavorite",nil)];
		[mrvc release];
    }
    return self;
}
@end
