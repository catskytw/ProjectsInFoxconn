    //
//  FourViewController.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/2/15.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FourViewController.h"
#import "FcTabBarItem.h"

@implementation FourViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:@"購物車" image:nil tag:2];
	thisBarItem.customStdImage=[UIImage imageNamed:@"content_ui_underbar_cart.png"];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:@"content_ui_underbar_cart_i.png"];
	self.tabBarItem=thisBarItem;
	[thisBarItem release];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
