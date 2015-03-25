//
//  FlowerListBaseViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerListBaseViewController.h"


@implementation FlowerListBaseViewController

-(id)initWithAreaId:(NSString*)areaId{
	if((self=[super init])){
		contentViewController=[[FlowerListViewController alloc]initWithAreaId:areaId];
	}
	return self;
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[viewPortView addSubview:contentViewController.view];
	[rightBtn setHidden:NO];
	contentViewController.parentNavigationController=self.navigationController;
	[titleLabel setText:contentViewController.dataObject.title];
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
	[contentViewController release];
    [super dealloc];
}


@end
