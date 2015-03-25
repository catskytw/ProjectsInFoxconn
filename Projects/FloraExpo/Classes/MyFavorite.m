//
//  MyFavorite.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavorite.h"
#import "TrafficTabViewController.h"
#import "MyfavoriteRootViewController.h"
#import "Vars.h"
@implementation MyFavorite


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization	
		UITabBarItem *myItem=[[UITabBarItem alloc]initWithTitle:AMLocalizedString(@"MyFavorite",nil) image:[UIImage imageNamed:@"blackbarui_btn_favorite.png"] tag:1];
		self.tabBarItem=myItem;
		[myItem release];
		
		MyfavoriteRootViewController *mrvc=[[MyfavoriteRootViewController alloc]initWithCategory:busQuery];
		[self pushViewController:mrvc animated:NO];
		[mrvc.navigationItem setTitle:AMLocalizedString(@"MyFavorite",nil)];
		[mrvc release];
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
