//
//  ServiceInfoViewController.m
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "ServiceInfoViewController.h"
#import "QueryPattern.h"
#import "DummyData.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
@implementation ServiceInfoViewController
@synthesize contentTextView;
@synthesize serviceId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    [self setUIDefault];
    [self initData];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setContentTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [contentTextView release];
    [super dealloc];
}

#pragma -
#pragma mark -  PrivateMethod

-(void)initData{
    contentTextView.text = [DummyData addServiceInfoData:serviceId];
}
-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    //self.title = title;
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    
    
}

@end
