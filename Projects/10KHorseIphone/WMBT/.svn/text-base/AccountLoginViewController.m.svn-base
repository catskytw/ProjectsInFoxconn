//
//  AccountLoginViewController.m
//  WMBT
//
//  Created by link on 2011/6/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AccountLoginViewController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "ModifyPasswordController.h"
#import "ActiveAccountController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "AccountController.h"
#import "ShoppingListController.h"
#import "LoginDataObject.h"
#import "Tools.h"
#import "WMBTAppDelegate.h"
#import "WMBTViewController.h"

@implementation AccountLoginViewController
@synthesize barButtonItem;
@synthesize naviItem;
@synthesize navigationBar;
@synthesize backGroundView;
@synthesize MainImage;
@synthesize activeAccountButton;
@synthesize usernameField, passwordField, loginButton, loginIndicator,modifyButton, forgetButton, descriptionLabel,mainController;

static NSString* sessionId;
+(NSString*)currentSessionId{
	return sessionId;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
    }
    return self;
}

- (void)dealloc
{
    [activeAccountButton release];
    [MainImage release];
    [backGroundView release];
    [navigationBar release];
    [naviItem release];
    [barButtonItem release];
    if(loginBarButtonItem)
        [loginBarButtonItem release];
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
    
    activeController = [[ActiveAccountController alloc] init] ;
    
    [self setUIDefault];
    [self setNaviTitle: AMLocalizedString(@"Login_LoginButton",nil)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification object:self.view.window]; 
    
    naviItem.rightBarButtonItem =nil;
    
    [UITuneLayout setBackground:backGroundView];
}
-(void) setUIDefault{
    loginIndicator.hidden = YES;
    self.navigationItem.title = AMLocalizedString(@"NaviBar_Member",nil);
    [self.navigationController setNavigationBarHidden:NO];
    descriptionLabel.text=AMLocalizedString(@"Login_Description",nil);
    usernameField.placeholder = AMLocalizedString(@"Login_UserName",nil);
    passwordField.placeholder = AMLocalizedString(@"Login_Password",nil);
    [loginButton setTitle:AMLocalizedString(@"Login_LoginButton",nil) forState:UIControlStateNormal];
    //NSLog(@"font name:%@",self.descriptionLabel.font.fontName);
    [forgetButton setTitle:AMLocalizedString(@"Login_ForgetButton",nil) forState:UIControlStateNormal];
    [activeAccountButton setTitle:AMLocalizedString(@"Login_ActiveButton",nil) forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(226,42) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [forgetButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(113,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    [activeAccountButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(113,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];
    
    CGRect Screenframe =  [[UIScreen mainScreen] applicationFrame];
    CGRect naviframe = [navigationBar frame];
    navigationBar.frame = CGRectMake(naviframe.origin.x, Screenframe.origin.y, naviframe.size.width, naviframe.size.height);

}
- (void)viewDidUnload
{
    [self setActiveAccountButton:nil];
    [self setMainImage:nil];
    [self setBackGroundView:nil];
    [self setNavigationBar:nil];
    [activeController release];
    [self setNaviItem:nil];
    [self setBarButtonItem:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil]; 

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backToLogin:(id)sender {
    [activeController.view removeFromSuperview];
    naviItem.rightBarButtonItem = nil;
    activeController.idText.text =@"";
    activeController.phonePasswordText.text =@"";
    [self setNaviTitle: AMLocalizedString(@"Login_LoginButton",nil)];
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
-(void) setNaviTitle:(NSString*)title{
    CGRect frame = CGRectMake(0,0, 150, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor= [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:1];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:21.0]];
    naviItem.titleView = label;
    label.text= title;
    [navigationBar setTintColor:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:0]]; 
}
- (IBAction) login:(id) sender
{
    loginButton.enabled = FALSE;
    [LoginDataObject setUserandPwd:usernameField.text andPwd:passwordField.text];
    LoginDataObject *loginDO= (LoginDataObject*)[LoginDataObject sharedInstance];
    [loginDO checkLogin];
    
    [Tools delWaitCursor];
    if (([LoginDataObject isLogin]) && ([loginDO.sessionId length]>0)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeLogin" object:nil];
    } else{
        loginButton.enabled = YES;
        descriptionLabel.hidden = NO;
        descriptionLabel.text = AMLocalizedString(@"Login_errormsg",nil);
    }

}

- (IBAction)acctiveAccount:(id)sender {
    [self forgetPasswordandActiveAccount:ACTIVATIONFOREGETVIEW_ACTIVE];
}


- (IBAction)forgetPassword:(id)sender {
    [self forgetPasswordandActiveAccount:ACTIVATIONFOREGETVIEW_FORGET];
}

-(void) forgetPasswordandActiveAccount:(int)mode{
   CGRect naviframe = [navigationBar frame];
    CGRect newFrame = CGRectMake(0,naviframe.origin.y+naviframe.size.height,320,416);
    activeController.view.frame = newFrame;
    [self.view addSubview:activeController.view];
    loginBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:AMLocalizedString(@"Login_LoginButton",nil) style:UIBarButtonSystemItemFastForward target:self action:@selector(backToLogin:)];
    naviItem.rightBarButtonItem = loginBarButtonItem;
    activeController.mode = mode;
    if(mode ==ACTIVATIONFOREGETVIEW_FORGET)
    {
        [self setNaviTitle: AMLocalizedString(@"Login_ForgetButton",nil)];
    }else{
        [self setNaviTitle: AMLocalizedString(@"Login_ActiveButton",nil)];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:passwordField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
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
    
    if ([passwordField isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (![passwordField isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if ([passwordField isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


@end
