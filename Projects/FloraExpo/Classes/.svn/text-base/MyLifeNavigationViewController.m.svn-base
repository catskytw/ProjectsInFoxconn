//
//  MyLifeNavigationViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeNavigationViewController.h"
#import "MyLifeInformationViewController.h"
#import "Vars.h"
#import "MyLifeSearchViewController.h"
@implementation MyLifeNavigationViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UITabBarItem *myBarItem=[[UITabBarItem alloc]initWithTitle: AMLocalizedString(@"LifeInfo",nil) image:[UIImage imageNamed:@"blackbarui_btn_life.png"] tag:2];
		self.tabBarItem=myBarItem;
		[myBarItem release];
		/*
		MyLifeInformationViewController *tsrvc=[[MyLifeInformationViewController alloc]init];
		[self pushViewController:tsrvc animated:NO];
		[tsrvc release];
		*/
		
		MyLifeSearchViewController *mlsvc=[MyLifeSearchViewController new];
		[self pushViewController:mlsvc animated:NO];
		[mlsvc release];
		 
		[self.navigationBar setTintColor:DefaultTintNavigationButtonColor];
    }
    return self;
}
@end
