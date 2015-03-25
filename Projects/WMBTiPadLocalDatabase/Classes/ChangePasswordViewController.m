//
//  ChangePasswordViewController.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
@implementation ChangePasswordViewController
@synthesize originPwdLabel;
@synthesize navibarLable;
@synthesize newPwdLabel;
@synthesize confirmPwdLabel;
@synthesize originPwd,changePwdBtn,logoutBtn,prePage,newPwd,confirmPwd,responseLabel,titleLabel;
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

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)evenlopSuit{
    [logoutBtn setBackgroundImage:[TUNinePatchCache imageOfSize:logoutBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [logoutBtn setBackgroundImage:[TUNinePatchCache imageOfSize:logoutBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    
    [changePwdBtn setBackgroundImage:[TUNinePatchCache imageOfSize:changePwdBtn.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [changePwdBtn setBackgroundImage:[TUNinePatchCache imageOfSize:changePwdBtn.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    
    [prePage setBackgroundImage:[TUNinePatchCache imageOfSize:prePage.frame.size forNinePatchNamed:@"button_normal"] forState:UIControlStateNormal];
    [prePage setBackgroundImage:[TUNinePatchCache imageOfSize:prePage.frame.size forNinePatchNamed:@"button_active"] forState:UIControlStateHighlighted];
    
    originPwdLabel.text = AMLocalizedString(@"ChangePwd_OriginPwd", nil);
    navibarLable.text = AMLocalizedString(@"ChangePwd_NaviBar", nil);
    newPwdLabel.text = AMLocalizedString(@"ChangePwd_NewPwd", nil);
    confirmPwdLabel.text = AMLocalizedString(@"ChangePwd_ConfirmPwd", nil);
    [titleLabel setTextColor:DefaultOrangeColor];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [responseLabel setText:@""];
    [self evenlopSuit];
    // Do any additional setup after loading the view from its nib.
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
	return YES;
}

-(IBAction)ChangePwdAction:(id)sender{
    [responseLabel setText:@""];
    if(![newPwd.text isEqualToString:confirmPwd.text]){
        [responseLabel setText:AMLocalizedString(@"ConfirmFailure", nil)];
        [newPwd setText:@""];
        [confirmPwd setText:@""];
        return;
    }
    
    QueryPattern *_q=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [_q prepareDic:changePwd(newPwd.text, originPwd.text)];
    if(![[_q getValue:@"response" withIndex:0] isEqualToString:@"0"]){
        [responseLabel setText:[_q getValue:@"message" withIndex:0]];
    }else{
        [newPwd resignFirstResponder];
        [confirmPwd resignFirstResponder];
        [originPwd resignFirstResponder];
        [Tools FcMessageWindows:AMLocalizedString(@"ChangePwdSuccess", nil) withParentView:self.view];
    }
    [_q release];
    
}

-(IBAction)prepage:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
