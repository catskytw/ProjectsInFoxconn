//
//  MyLifeTabViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeTabViewController.h"
#import "MyLifeFavoriteNavigationView.h"
#import "ReturnHomeViewController.h"
#import "MyLifeMapNavigationView.h"
#import "MyLifeNavigationViewController.h"
static MyLifeTabViewController *singtonMyLifeTabViewController;
@implementation MyLifeTabViewController
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.selectedIndex=2;
}
+(MyLifeTabViewController*)currentMyLifeTabViewcontroller{
	if(singtonMyLifeTabViewController==nil){
		singtonMyLifeTabViewController=[[MyLifeTabViewController alloc]initWithNibName:nil bundle:nil];
	}
	return singtonMyLifeTabViewController;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
	int tmp=self.selectedIndex;
	if(tmp==0){
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.delegate=self;
		MyLifeFavoriteNavigationView *myFavorite=[[MyLifeFavoriteNavigationView alloc]init];
		ReturnHomeViewController *myReturnHome=[[ReturnHomeViewController alloc]initWithNibName:nil bundle:nil];
		//ts=[TrafficSearch currentTrafficSearchNavigationController];
		MyLifeMapNavigationView *ms=[[MyLifeMapNavigationView alloc]init];
		MyLifeNavigationViewController *mlivc=[MyLifeNavigationViewController new];
		NSArray *controllers=[NSArray arrayWithObjects:myReturnHome,myFavorite,mlivc,ms,nil];
		self.viewControllers=controllers;
		[myFavorite release];
		[myReturnHome release];
		[mlivc release];
		[ms release];
    }
    return self;
}
@end
