//
//  ForgetPasswordViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/16.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "FcConfig.h"

@implementation ForgetPasswordViewController
@synthesize emailTF;
@synthesize belowbarImg;
@synthesize seperateLine;
@synthesize navibarTitle;
@synthesize naviBarImg;
@synthesize usernameTFBg;
@synthesize emailTFBg;
@synthesize barButtonItem;
@synthesize usernameTF;

@synthesize submitButton;
@synthesize backBtn;
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
    // Do any additional setup after loading the view from its nib.
}
-(void) setUIDefault{
   
    usernameTF.placeholder = AMLocalizedString(@"Login_UserName",nil);
    [usernameTF setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    //[usernameTF setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
    [usernameTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [usernameTFBg setImage:[TUNinePatchCache imageOfSize:usernameTFBg.frame.size forNinePatchNamed:@"editbox"]];
    [usernameTFBg setHighlightedImage:[TUNinePatchCache imageOfSize:usernameTFBg.frame.size forNinePatchNamed:@"editbox_i"]];
    [usernameTFBg setHighlighted:NO];
    
    
    
    [emailTF setFont:[UIFont fontWithName:DefaultFontName size:16.0f]];
    emailTF.placeholder = AMLocalizedString(@"Email",nil);
    //[emailTF setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
    [emailTF setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    [emailTFBg setImage:[TUNinePatchCache imageOfSize:emailTFBg.frame.size forNinePatchNamed:@"editbox"]];
    [emailTFBg setHighlightedImage:[TUNinePatchCache imageOfSize:emailTFBg.frame.size forNinePatchNamed:@"editbox_i"]];
    [emailTFBg setHighlighted:NO];
    
    
    
    [submitButton setTitle:AMLocalizedString(@"submit",nil) forState:UIControlStateNormal];
    [submitButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:submitButton.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [submitButton setBackgroundImage:[TUNinePatchCache imageOfSize:submitButton.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];    
    [submitButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [backBtn setTitle:AMLocalizedString(@"back",nil) forState:UIControlStateNormal];
    [backBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:backBtn.frame.size forNinePatchNamed:@"btn_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[TUNinePatchCache imageOfSize:backBtn.frame.size forNinePatchNamed:@"btn_back_i"] forState:UIControlStateHighlighted];    
    [backBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];    
    [backBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    
    CGRect Screenframe =  [[UIScreen mainScreen] applicationFrame];
    //導覽列
    naviBarImg.frame = CGRectMake(naviBarImg.frame.origin.x, Screenframe.origin.y, naviBarImg.frame.size.width, naviBarImg.frame.size.height);
    [naviBarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_actionbar"]];
    [seperateLine setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"bg_line"]];
    navibarTitle.frame = CGRectMake(navibarTitle.frame.origin.x, Screenframe.origin.y, navibarTitle.frame.size.width, navibarTitle.frame.size.height);
    [navibarTitle setText:AMLocalizedString(@"Login_ForgetButton",nil)];
    backBtn.frame = CGRectMake(backBtn.frame.origin.x, backBtn.frame.origin.y+ Screenframe.origin.y, backBtn.frame.size.width, backBtn.frame.size.height);
    //下方ICON
    [belowbarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_belowbar"]];
    UIImageView *imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    imgLogo.frame = CGRectMake(12, 8, imgLogo.frame.size.width, imgLogo.frame.size.height);    
    [belowbarImg addSubview:imgLogo];
    [imgLogo release];
    
}

- (void)viewDidUnload
{
    [self setBackBtn:nil];
    [self setUsernameTF:nil];
    //[self setEmailTF:nil];
    [self setSubmitButton:nil];
    [self setUsernameTFBg:nil];
    [self setNavibarTitle:nil];
    [self setNaviBarImg:nil];
    [self setEmailTFBg:nil];
    [self setBelowbarImg:nil];
    [self setEmailTF:nil];
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
    [backBtn release];
    [usernameTFBg release];
    [usernameTF release];
    [emailTFBg release];
    [submitButton release];
    //[passwordTFBg release];
    [naviBarImg release];
    [navibarTitle release];
    [seperateLine release];
    [belowbarImg release];
    [emailTF release];
    [super dealloc];
}
- (IBAction)backToLogin:(id)sender {
    [self.view removeFromSuperview];
}
-(BOOL) checkEmailFormat{
    if(![self validateEmail:emailTF.text]){
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"emailformat_alert_msg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
        return NO;
    }
    return YES;
}
-(BOOL) textFieldShouldReturn:(UITextField*)textField{
    NSInteger nextTag = textField.tag +1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        if ([textField isEqual:emailTF]) {
            if(![self checkEmailFormat])
                return NO;
        }
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self getPassword];
    }
    return NO;
}
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}
-(void) getPassword{
    
    if(![self checkEmailFormat])
            return ;
    
    if ([usernameTF.text length]==0 || [emailTF.text length]==0) {
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_msg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
        
        return;
    }
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    
    NSString *lowercaseId = [usernameTF.text lowercaseString];
	[accountQuery prepareDic:forgetPassword(lowercaseId, emailTF.text)];
    
    @try {
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"getpwd_alert_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"getpwd_alert_msg",nil)]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"getpwd_alert_ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
            
        }else{
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", [accountQuery getValue:@"message" withIndex:0]]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"getpwd_alert_ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];

        }
        
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [accountQuery release];
        
    }

}
- (IBAction)submit:(id)sender {
    [self getPassword];
}


@end
