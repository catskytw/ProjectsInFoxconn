//
//  NewsDetailInfoViewController.m
//  FloraExpo2010
//
//  Created by Liao Change on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailInfoViewController.h"
#import "FloraExpoModel.h"
#import "DescriptionObject.h"
@implementation NewsDetailInfoViewController
@synthesize mainWebView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
-(id)initWithDataObject:(DescriptionPageDataObject*)inputData{
	if((self=[super init])){
		thisViewData=[inputData retain];
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	DescriptionObject *subjectObject=(DescriptionObject*)[thisViewData.contentArray objectAtIndex:0];
	DescriptionObject *contentObject=(DescriptionObject*)[thisViewData.contentArray objectAtIndex:1];
	[mainWebView loadHTMLString:contentObject.textString baseURL:nil];
	mainWebView.backgroundColor=[UIColor clearColor];
	[self.navigationItem setTitle:subjectObject.textString];
}


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
	[thisViewData release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}
@end
