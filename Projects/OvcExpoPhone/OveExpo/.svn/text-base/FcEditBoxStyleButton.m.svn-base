//
//  FcEditBoxStyleButton.m
//  OveExpo
//
//  Created by Chang Link on 11/9/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcEditBoxStyleButton.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"

@implementation FcEditBoxStyleButton
@synthesize bgImg;
@synthesize titleLabel;
@synthesize contentLabel;
@synthesize arrowBtn;
@synthesize rootViewController;

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
    [titleLabel setTextColor:[UIColor blackColor]];
    [contentLabel setTextColor:[UIColor colorWithRed:57/255.f green:85/255.f blue:135/255.f alpha:1]];
    [arrowBtn setImage:[UIImage imageNamed:@"arrowbutton.png"] forState:UIControlStateNormal];
    [bgImg setImage:[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox"]];
    [bgImg setHighlightedImage:[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox_i"]];
    [bgImg setHighlighted:NO];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBgImg:nil];
    [self setTitleLabel:nil];
    [self setContentLabel:nil];
    [self setArrowBtn:nil];
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
    [bgImg release];
    [titleLabel release];
    [contentLabel release];
    [arrowBtn release];
    [listViewController release];
    [super dealloc];
}
- (IBAction)toNextView:(id)sender {
    listViewController = [ListTableViewController new];
    [listViewController initDataArray];
    [rootViewController.view addSubview:listViewController.view];
}
@end
