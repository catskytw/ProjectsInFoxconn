//
//  RTSpTestProjectViewController.m
//  RTSpTestProject
//
//  Created by Liao Chen-chih on 2011/9/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RTSpTestProjectViewController.h"
@implementation RTSpTestProjectViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    RTSPClientSession *session=[[RTSPClientSession alloc] initWithURL:[NSURL URLWithString:@"rtsp://10.62.13.31/test.3gp"]];
    [session setup];
    [session play];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
