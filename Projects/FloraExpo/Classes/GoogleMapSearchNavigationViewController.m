//
//  GoogleMapSearchNavigationViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoogleMapSearchNavigationViewController.h"
#import "GoogleMapSearchViewController.h"
#import "Vars.h"
@implementation GoogleMapSearchNavigationViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UITabBarItem *myBarItem=[[UITabBarItem alloc]initWithTitle:AMLocalizedString(@"MapSearch",nil) image:[UIImage imageNamed:@"blackbarui_btn_search.png"] tag:3];
		self.tabBarItem=myBarItem;
		[myBarItem release];
		[self.navigationBar setTintColor:DefaultTintNavigationButtonColor];
		GoogleMapSearchViewController *myGoogleMapSearch=[[GoogleMapSearchViewController alloc]initWithAnnotationClickFlag:YES withStartLocation:NullPOIPosition withType:busQuery];
		[self pushViewController:myGoogleMapSearch animated:YES];
		[myGoogleMapSearch release];
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

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
