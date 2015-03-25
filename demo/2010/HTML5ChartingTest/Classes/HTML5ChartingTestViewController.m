//
//  HTML5ChartingTestViewController.m
//  HTML5ChartingTest
//
//  Created by 廖 晨志 on 2011/1/3.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "HTML5ChartingTestViewController.h"

@implementation HTML5ChartingTestViewController
@synthesize testChart1;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
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
	NSString *filePathString = [[NSBundle mainBundle] pathForResource:@"line-ajax" ofType:@"htm"];
	NSURL *aURL = [NSURL fileURLWithPath:filePathString];
	NSURLRequest *aRequest = [NSURLRequest requestWithURL:aURL];
	[testChart1 loadRequest:aRequest];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


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
