//
//  FcViewController.m
//  FcQueryTestProject
//
//  Created by Liao Chen-chih on 2011/12/14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcViewController.h"
#import "QueryPattern.h"
@implementation FcViewController
@synthesize testUIImageView;
@synthesize testBtn;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    QueryPattern *qp=[QueryPattern new];
    [qp prepareDic:@"http://58.246.162.126:8080/service/productService.getAllProductTypeList?rnd=1804289383"];
    [qp getImageData:@"http://58.246.162.126:8080/A1CCD5B18FE5239CE040760A28FD6FED_small.jpg" withUIComponent:testUIImageView withNotificationName:nil];
    [qp valueBinding:testBtn withKey:@"id" withIndexArray:0];
    [qp release];
}

- (void)viewDidUnload
{
    [self setTestUIImageView:nil];
    [self setTestBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [testUIImageView release];
    [testBtn release];
    [super dealloc];
}
@end
