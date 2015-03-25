//
//  FloraExpoRootViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloraExpoRootViewController.h"
#import "FloraExpoTableViewController.h"
#import "Vars.h"
static FloraExpoRootViewController *singletonFloraExpoRootViewcontroller;
@implementation FloraExpoRootViewController
+(FloraExpoRootViewController*)currentForaExpoRootView{
	if(singletonFloraExpoRootViewcontroller==nil){
		singletonFloraExpoRootViewcontroller=[[FloraExpoRootViewController alloc]init];
	}
	return singletonFloraExpoRootViewcontroller;
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.delegate=self;
		UINavigationController *mainNavigationUnderFloraExpo=[[UINavigationController alloc]init];
		[mainNavigationUnderFloraExpo.navigationBar setTintColor:DefaultTintNavigationButtonColor];
		UITabBarItem *tmpTabBarItem=[[UITabBarItem alloc]initWithTitle:AMLocalizedString(@"FirstPage",nil) image:[UIImage imageNamed:@"blackbarui_btn_home.png"] tag:0];
        mainNavigationUnderFloraExpo.tabBarItem=tmpTabBarItem;
		
		FloraExpoTableViewController *floraExpoInit=[[FloraExpoTableViewController alloc]initwithTableType:FloraExpoContent];
		[mainNavigationUnderFloraExpo pushViewController:floraExpoInit animated:NO];		
		NSMutableArray *controllers=[NSMutableArray arrayWithObjects:mainNavigationUnderFloraExpo,nil];
		
		for(int i=0;i<4;i++){
			UIViewController *tmpController=[[UIViewController alloc]init];
			[tmpController.tabBarItem setEnabled:NO];
			[controllers insertObject:tmpController atIndex:i+1];
			[tmpController release];
		}
		
		self.viewControllers=controllers;
		[tmpTabBarItem release];
		[floraExpoInit release];
		[mainNavigationUnderFloraExpo release];
		
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
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
	int tmp=self.selectedIndex;
	if(tmp==0){
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}

@end
