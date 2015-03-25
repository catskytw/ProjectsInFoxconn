//
//  FcViewController.m
//  XMPPWorkingProject
//
//  Created by Liao Chen-chih on 2011/12/12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcViewController.h"
#import "FcXMPPStream.h"
@implementation FcViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SHARE_STREAM setupStream:@"10.62.13.31" withPort:5222 withDomainName:@"zack"];
    [SHARE_STREAM login:@"qoo" withPassword:@"0000" withNotAuthenticateNotificationName:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
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

-(IBAction)sendMessage:(id)sender{
    [SHARE_STREAM sendMessage:@"test message" withTarget:@"test"];
}
@end
