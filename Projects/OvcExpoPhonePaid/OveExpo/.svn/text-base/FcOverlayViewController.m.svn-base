//
//  FcOverlayViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcOverlayViewController.h"
#import "LocalizationSystem.h"
@implementation FcOverlayViewController
@synthesize qrcodeLabel;
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [qrcodeLabel setText:AMLocalizedString(@"qrcodeString", nil)];
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
