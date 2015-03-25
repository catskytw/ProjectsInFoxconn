//
//  FcPickerController.m
//  OveExpo
//
//  Created by Chang Link on 11/10/7.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcPickerController.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
@implementation FcPickerController
@synthesize datePicker;
@synthesize submitBtn;
@synthesize titleImg;
@synthesize picker;
@synthesize cancelBtn;
@synthesize bShow;
@synthesize delegate;
@synthesize pickerdelegate;
@synthesize dataSource;

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
    [self.cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    [self.submitBtn setBackgroundImage:[TUNinePatchCache imageOfSize:submitBtn.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundImage:[TUNinePatchCache imageOfSize:submitBtn.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateHighlighted];
    [submitBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [submitBtn setTitle:AMLocalizedString(@"submit",nil) forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal]; 
    [cancelBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [titleImg setImage:[TUNinePatchCache imageOfSize:titleImg.frame.size forNinePatchNamed:@"img_actionbar"]];
    [cancelBtn setTitle:AMLocalizedString(@"back",nil) forState:UIControlStateNormal];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin ;
    datePicker.hidden = !isDate;
    picker.delegate =pickerdelegate;
    picker.dataSource = dataSource;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPicker:nil];
    [self setTitleImg:nil];
    [self setSubmitBtn:nil];
    [self setCancelBtn:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)isDatePicker{
    isDate = YES;
}
- (void)dealloc {
    [picker release];
    [titleImg release];
    [submitBtn release];
    [cancelBtn release];
    [datePicker release];
    [super dealloc];
}
-(void)slideUp:(BOOL)bUp{
    if (bShow == bUp) {
        return;
    }
    bShow = bUp;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.view.frame.size.height*(bUp?-1:1), self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    
    
}
- (IBAction)cancel:(id)sender {
    [self slideUp:NO];
    if ([delegate respondsToSelector: @selector(pickerCancel)]==YES) {
        [delegate pickerCancel];
    }
    
}

- (IBAction)submit:(id)sender {
    [self slideUp:NO];
    [delegate pickerSubmit];
}

@end
