//
//  TrafficSearch.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrafficSearch.h"
#import "UINavigationBar.h"
#import "TrafficTabViewController.h"
#import "BusSearchCategoryTable.h"
#import "TrafficSearchRootViewController.h"
#import "LocalizationSystem.h"
static TrafficSearch *oneTrafficSearchNavigationController;
@implementation TrafficSearch

+(TrafficSearch*)currentTrafficSearchNavigationController{
	if(oneTrafficSearchNavigationController==nil)
		oneTrafficSearchNavigationController=[[TrafficSearch alloc]init];
	return oneTrafficSearchNavigationController;
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UITabBarItem *myBarItem=[[UITabBarItem alloc]initWithTitle:AMLocalizedString(@"TrafficSearch",nil) image:[UIImage imageNamed:@"blackbarui_btn_traffic.png"] tag:2];
		self.tabBarItem=myBarItem;
		[myBarItem release];
		
		TrafficSearchRootViewController *tsrvc=[[TrafficSearchRootViewController alloc]init];
		[self pushViewController:tsrvc animated:NO];
		[tsrvc release];
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



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
}
@end
