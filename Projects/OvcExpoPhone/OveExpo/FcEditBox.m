//
//  FcEditBox.m
//  OveExpo
//
//  Created by Chang Link on 11/9/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcEditBox.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "FcConfig.h"
@implementation FcEditBox
@synthesize bgImg;
@synthesize textField;

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
    //textField.placeholder = AMLocalizedString(nameTag,nil);
    [textField setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    [textField setTextColor:[UIColor blackColor]];
    [textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [bgImg setImage:[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox"]];
    [bgImg setHighlightedImage:[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox_i"]];
    [bgImg setHighlighted:NO];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBgImg:nil];
    [self setTextField:nil];
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
    [textField release];
    [super dealloc];
}
@end
