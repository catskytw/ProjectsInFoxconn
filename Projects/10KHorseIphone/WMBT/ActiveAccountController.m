//
//  ActiveAccountController.m
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ActiveAccountController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "Tools.h"
@implementation ActiveAccountController
@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize idText;
@synthesize phonePasswordText;
@synthesize activeButton;
@synthesize mode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bMoveUp = NO;
    }
    return self;
}

- (void)dealloc
{
    [titleLabel release];
    [descriptionLabel release];
    [idText release];
    [phonePasswordText release];
    [activeButton release];
    [super dealloc];
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
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification object:self.view.window]; 
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setDescriptionLabel:nil];
    [self setIdText:nil];
    [self setPhonePasswordText:nil];
    [self setActiveButton:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil]; 
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([Tools isPopToRoot])
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [Tools setPopToRoot:NO];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)activeAccount:(id)sender {
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    NSString *lowercaseId = [idText.text lowercaseString];
    if (mode == ACTIVATIONFOREGETVIEW_FORGET) {
        [accountQuery prepareDic:forgetPwdQuery(lowercaseId, phonePasswordText.text)];
    }else{
        [accountQuery prepareDic:activeAccountQuery(lowercaseId, phonePasswordText.text)];
    }
    descriptionLabel.hidden = YES;
    @try {
        NSLog(@"response %@",[accountQuery getValue:@"response" withIndex:0]);
        //NSLog(@"session number %d",[accountQuery getNumberUnderNode:@"sessionInfo" withKey:@"id"]);
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            //show add message
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"active_alert_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"active_alert_msg",nil)]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"active_alert_ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
            idText.text = @"";
            phonePasswordText.text=@"";
        }
        else{
            descriptionLabel.text = [NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"active_description",nil),[accountQuery getValue:@"message" withIndex:0]];
            descriptionLabel.hidden =NO;
        }

    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [accountQuery release];
    }
    
}
-(void) setUIDefault{

    self.navigationItem.title = AMLocalizedString(@"NaviBar_Member",nil);
    [self.navigationController setNavigationBarHidden:NO];
    titleLabel.text=AMLocalizedString(@"active_title",nil);
    descriptionLabel.text=AMLocalizedString(@"active_description",nil);
    titleLabel.text =AMLocalizedString(@"active_title",nil);
    idText.placeholder = AMLocalizedString(@"active_id",nil);
    phonePasswordText.placeholder = AMLocalizedString(@"active_pwd",nil);

    [activeButton setTitle:AMLocalizedString(@"active_button",nil) forState:UIControlStateNormal];
    [activeButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(227,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    
}
-(BOOL) textFieldShouldReturn:(UITextField*)textField{
    NSInteger nextTag = textField.tag +1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:idText]||[sender isEqual:phonePasswordText])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
            bMoveUp = YES;
        }
    }
}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp && !bMoveUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else if(!bMoveUp)
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if (!bMoveUp)
    {
        bMoveUp = YES;
        [self setViewMovedUp:YES];
    }

}
- (void)keyboardWillHide:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    if (bMoveUp)
    {
        bMoveUp = NO;
        [self setViewMovedUp:NO];
    }
}

@end
