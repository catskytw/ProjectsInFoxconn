//
//  FcSearchField.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcSearchField.h"
#import "NinePatch.h"
@implementation FcSearchField
@synthesize bgImg;
@synthesize textfild;
@synthesize iconImg;

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
    [bgImg setImage:[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox_search"]];
    [bgImg setHighlightedImage:[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox_search_i"]];
    [bgImg setHighlighted:NO];
    [iconImg setImage:[UIImage imageNamed:@"editbox_search_ico.png"]];
    [iconImg setHighlightedImage:[UIImage imageNamed:@"editbox_search_ico_i.png"]];
    [iconImg setHighlighted:NO];
    // Do any additional setup after loading the view from its nib.
}
-(void)setHighlight:(BOOL)focus{
    [bgImg setHighlighted:focus];
    [iconImg setHighlighted:focus];
    bHighlighted = focus;
}
-(void)settextfildDelegate:(id)delegate{
    textfild.delegate = delegate;
}
- (void)viewDidUnload
{
    [self setTextfild:nil];
    [self setIconImg:nil];
    [self setBgImg:nil];
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
    [textfild release];
    [iconImg release];
    [bgImg release];
    [super dealloc];
}
@end
