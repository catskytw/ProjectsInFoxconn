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
#import "QueryPattern.h"
#import "FcConfig.h"
#import "LoginDataObject.h"
#import "Tools.h"

#define kOFFSET_FOR_KEYBOARD 100

@implementation AccountLoginViewController
@synthesize topBar;
@synthesize belowbarImg;
@synthesize seperateLine;
@synthesize navibarTitle;
@synthesize naviBarImg;
@synthesize usernameTFBg;
@synthesize passwordTFBg;
@synthesize barButtonItem;
@synthesize naviItem;
@synthesize navigationBar;
@synthesize backGroundView;
@synthesize MainImage;
@synthesize registerButton;
@synthesize usernameTF, passwordTF, loginButton, loginIndicator,modifyButton, forgetButton, descriptionLabel,mainController;

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
    [registerButton release];
    [MainImage release];
    [backGroundView release];
    [navigationBar release];
    [naviItem release];
    [barButtonItem release];
    if(loginBarButtonItem)
        [loginBarButtonItem release];
    [usernameTFBg release];
    [passwordTFBg release];
    [naviBarImg release];
    [navibarTitle release];
    [seperateLine release];
    [belowbarImg release];
    if (regiesterViewController) {
        [regiesterViewController release];
    }
    if (forgerViewController) {
        [forgerViewController release];
    }
    [topBar release];
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

    
}
-(void) setUIDefault{
    loginIndicator.hidden = YES;
    self.navigationItem.title = AMLocalizedString(@"NaviBar_Member",nil);
    //descriptionLabel.text=AMLocalizedString(@"Login_Description",nil);
    [descriptionLabel setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    usernameTF.placeholder = AMLocalizedString(@"Login_UserName",nil);
    [usernameTF setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    //[usernameTF setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
    [usernameTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [usernameTFBg setImage:[TUNinePatchCache imageOfSize:usernameTFBg.frame.size forNinePatchNamed:@"editbox"]];
    [usernameTFBg setHighlightedImage:[TUNinePatchCache imageOfSize:usernameTFBg.frame.size forNinePatchNamed:@"editbox_i"]];
    [usernameTFBg setHighlighted:NO];
    
    
    
    [passwordTF setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    passwordTF.placeholder = AMLocalizedString(@"Login_Password",nil);
    //[passwordTF setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
    [passwordTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [passwordTFBg setImage:[TUNinePatchCache imageOfSize:passwordTFBg.frame.size forNinePatchNamed:@"editbox"]];
    [passwordTFBg setHighlightedImage:[TUNinePatchCache imageOfSize:passwordTFBg.frame.size forNinePatchNamed:@"editbox_i"]];
    [passwordTFBg setHighlighted:NO];
    

    
    [loginButton setTitle:AMLocalizedString(@"Login_LoginButton",nil) forState:UIControlStateNormal];
    [loginButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:loginButton.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[TUNinePatchCache imageOfSize:loginButton.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];    
    [loginButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    
    [forgetButton setTitle:AMLocalizedString(@"Login_ForgetButton",nil) forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor colorWithRed:45/255.f green:126/255.f blue:142/255.f alpha:1] forState:UIControlStateNormal];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    [registerButton setTitle:AMLocalizedString(@"Login_RegisterButton",nil) forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor colorWithRed:45/255.f green:126/255.f blue:142/255.f alpha:1] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    CGRect Screenframe =  [[UIScreen mainScreen] applicationFrame];
    
    naviBarImg.frame = CGRectMake(naviBarImg.frame.origin.x, Screenframe.origin.y, naviBarImg.frame.size.width, naviBarImg.frame.size.height);
    [naviBarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_actionbar"]];
    //topBar.frame = CGRectMake(topBar.frame.origin.x, Screenframe.origin.y, topBar.frame.size.width, topBar.frame.size.height);
    //[topBar setImage:[TUNinePatchCache imageOfSize:topBar.frame.size forNinePatchNamed:@"img_actionbar"]];
    [seperateLine setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"bg_line"]];
    navibarTitle.frame = CGRectMake(navibarTitle.frame.origin.x, Screenframe.origin.y, navibarTitle.frame.size.width, navibarTitle.frame.size.height);
    [navibarTitle setText:AMLocalizedString(@"Login_LoginButton",nil)];
    
    [belowbarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_belowbar"]];
    UIImageView *imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    imgLogo.frame = CGRectMake(12, 8, imgLogo.frame.size.width, imgLogo.frame.size.height);
    [belowbarImg addSubview:imgLogo];
    
    [imgLogo release];
    
}
- (void)viewDidUnload
{
    [self setRegisterButton:nil];
    [self setMainImage:nil];
    [self setBackGroundView:nil];
    [self setNavigationBar:nil];
    
    [self setNaviItem:nil];
    [self setBarButtonItem:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil]; 

    [self setUsernameTFBg:nil];
    [self setPasswordTFBg:nil];
    [self setNaviBarImg:nil];
    [self setNavibarTitle:nil];
    [self setSeperateLine:nil];
    [self setBelowbarImg:nil];
    [self setTopBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(BOOL) textFieldShouldReturn:(UITextField*)textField{
    NSInteger nextTag = textField.tag +1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self checkLogin];
    }
    return NO;
}
-(void) checkLogin{
    loginButton.enabled = FALSE;
    [LoginDataObject setUserandPwd:usernameTF.text andPwd:passwordTF.text];
    LoginDataObject *loginDO= (LoginDataObject*)[LoginDataObject sharedInstance];
    [loginDO checkLogin];
    
    //[Tools delWaitCursor];
    if (([LoginDataObject isLogin]) && ([loginDO.sessionId length]>0)) {
        [self.view removeFromSuperview];
    } else{
        loginButton.enabled = YES;
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"login_err_alert_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"Login_errormsg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"login_alert_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
    }

}
- (IBAction) login:(id) sender
{
    [self checkLogin];
}

- (IBAction)registerId:(id)sender {
    regiesterViewController = [RegisterViewController new];
    [self.view addSubview:regiesterViewController.view];
}

- (IBAction)forgetPassword:(id)sender {
    
    forgerViewController = [ForgetPasswordViewController new];
    [self.view addSubview:forgerViewController.view];
}


-(void)textFieldDidBeginEditing:(UITextField *)sender
{

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
    
    if ([passwordTF isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (![passwordTF isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if ([passwordTF isFirstResponder] && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


@end
