//
//  TrafficViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrafficTabViewController.h"
#import "MyFavorite.h"
#import "ReturnHomeViewController.h"
#import "GoogleMapSearchNavigationViewController.h"
#import "TrafficSearch.h"
#import "Vars.h"
static TrafficTabViewController *singtonTrafficTabViewController;
@implementation TrafficTabViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.selectedIndex=2;
}
+(TrafficTabViewController*)currentTrafficTabViewcontroller{
	if(singtonTrafficTabViewController==nil){
		singtonTrafficTabViewController=[[TrafficTabViewController alloc]initWithNibName:nil bundle:nil];
	}
	return singtonTrafficTabViewController;
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
        // Custom initialization
		self.delegate=self;
		MyFavorite *myFavorite=[[MyFavorite alloc]init];
		ReturnHomeViewController *myReturnHome=[[ReturnHomeViewController alloc]initWithNibName:nil bundle:nil];
		ts=[TrafficSearch currentTrafficSearchNavigationController];
		GoogleMapSearchNavigationViewController *ms=[[GoogleMapSearchNavigationViewController alloc]init];
		NSArray *controllers=[NSArray arrayWithObjects:myReturnHome,myFavorite,ts,ms,nil];
		self.viewControllers=controllers;
		[myFavorite release];
		[myReturnHome release];
		[ts release];
		[ms release];
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
