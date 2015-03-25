//
//  LoginView.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/23.
//  Copyright 2011年 foxconn. All rights reserved.
//
//#define TESTDATA YES

#import "LoginView.h"
#import "LocalizationSystem.h"
#import "SignInObject.h"
#import "QueryPattern.h"
#import "Configure.h"

#define LoginAction 1
#define ActiveAction 2
#define ForgetPwd 3

@interface LoginView(PrivateMethod)
-(BOOL)verifyLogin;
-(void)activeAction:(UITextField *)textField;
-(void)forgetPassword:(UITextField *)textField;
-(void)loginAction:(UITextField *)textField;
@end

@implementation LoginView
@synthesize accountLabel,passwordLabel,responseLabel,showingVew,actionSegment;

#pragma mark 執行method
-(BOOL)verifyLogin{
    NSString *accountString=accountTextField.text;
    NSString *passwordString=passwordTextField.text;
    
    //登入地方為空白
    if([accountString isEqualToString:@""] || [passwordString isEqualToString:@""]){
        [responseLabel setText:AMLocalizedString(@"AccountPwdSpace", nil)];
        return NO;
    }
    
    BOOL r=NO;

    [loginQuery prepareDic:loginAPI(accountString,passwordString)];
    NSString *response=[loginQuery getValue:@"response" withIndex:0];

    r=([response isEqualToString:@"0"])?YES:NO;
    if(r==NO){//登入失敗
        [responseLabel setText:[loginQuery getValue:@"message" withIndex:0]];
        return r;
    }
    
    NSString *sessionId=[loginQuery getValueUnderNode:@"sessionInfo" withKey:@"id" withIndex:0];
    NSString *_type=[loginQuery getValueUnderNode:@"sessionInfo" withKey:@"type" withIndex:0];
    isMember=([_type isEqualToString:@"M"])?YES:NO;
    if(isMember==YES){//會員資料
        [SignInObject share].isLogin=YES;
        [SignInObject share].isMember=YES;
        [SignInObject share].sessionId=sessionId;
        [loginQuery prepareDic:userInfo(sessionId)];
        [SignInObject share].account=accountString;
        [SignInObject share].password=passwordString;
        [SignInObject share].name=[loginQuery getValue:@"name" withIndex:0];
        [SignInObject share].address=[loginQuery getValue:@"address" withIndex:0];
        [SignInObject share].cityName=[loginQuery getValue:@"cityName" withIndex:0];
        [SignInObject share].birthday=[loginQuery getValue:@"birthday" withIndex:0];
        [SignInObject share].code=[loginQuery getValue:@"code" withIndex:0];
        [SignInObject share].email=[loginQuery getValue:@"email" withIndex:0];
        [SignInObject share].habit=[loginQuery getValue:@"habit" withIndex:0];
        [SignInObject share].marryStatus=[loginQuery getValue:@"marryStatus" withIndex:0];
        [SignInObject share].mobile=[loginQuery getValue:@"mobile" withIndex:0];
        [SignInObject share].postCode=[loginQuery getValue:@"postCode" withIndex:0];
        [SignInObject share].provinceName=[loginQuery getValue:@"provinceName" withIndex:0];
        [SignInObject share].sex=[loginQuery getValue:@"sex" withIndex:0];
        [SignInObject share].storeId=[loginQuery getValue:@"storeId" withIndex:0];
        [SignInObject share].storeName=[loginQuery getValue:@"storeName" withIndex:0];
        [SignInObject share].sectionName=[loginQuery getValue:@"sectionName" withIndex:0];
        [SignInObject share].workIncome=[loginQuery getValue:@"workIncome" withIndex:0];
        [SignInObject share].workJob=[loginQuery getValue:@"workJob" withIndex:0];
        [SignInObject share].phone=[loginQuery getValue:@"phone" withIndex:0];
        [SignInObject share].memberId=[loginQuery getValue:@"id" withIndex:0];
    }else{//TODO 員工資料
        [SignInObject share].isLogin=YES;
        [SignInObject share].isMember=NO;
        [SignInObject share].sessionId=sessionId;
        
        [loginQuery prepareDic:employeeInfo(sessionId)];
        [SignInObject share].account=accountString;
        [SignInObject share].password=passwordString;
        [SignInObject share].memberId=[loginQuery getValue:@"id" withIndex:0];
        [SignInObject share].birthday=[loginQuery getValue:@"birthday" withIndex:0];
        [SignInObject share].storeName=[loginQuery getValue:@"storeName" withIndex:0];
        [SignInObject share].phone=[loginQuery getValue:@"phone" withIndex:0];
        [SignInObject share].sex=[loginQuery getValue:@"sex" withIndex:0];
        [SignInObject share].email=[loginQuery getValue:@"email" withIndex:0];
        [SignInObject share].name=[loginQuery getValue:@"name" withIndex:0];
        [SignInObject share].storeId=[loginQuery getValue:@"storeId" withIndex:0];
        [SignInObject share].code=[loginQuery getValue:@"code" withIndex:0];
        [SignInObject share].mobile=[loginQuery getValue:@"mobile" withIndex:0];
    }
    return r;
}
#pragma -
#pragma mark UIAction
-(void)loginAction:(UITextField *)textField{
    if([self verifyLogin]){
        [textField resignFirstResponder];
        //若有notification,則送出
        if (successString!=nil) {
            [[NSNotificationCenter defaultCenter]postNotificationName:successString object:_target];
        }
    }else{
        if(failedString!=nil)
            [[NSNotificationCenter defaultCenter]postNotificationName:failedString object:_target];
        accountTextField.text=@"";
        passwordTextField.text=@"";
        
        [accountTextField becomeFirstResponder];
    }
}
-(void)activeAction:(UITextField *)textField{
    //[textField resignFirstResponder];
    QueryPattern *_query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [_query prepareDic:activation(accountTextField.text, passwordTextField.text)];
    if(![[_query getValue:@"response" withIndex:0] isEqualToString:@"0"]){
        [responseLabel setText:[_query getValue:@"message" withIndex:0]];
    }else
        [responseLabel setText:AMLocalizedString(@"sendActivation", nil)];
    [_query release];
}
-(void)forgetPassword:(UITextField *)textField{
    QueryPattern *_query=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    [_query prepareDic:forgetPwd(accountTextField.text, passwordTextField.text)];
    if(![[_query getValue:@"response" withIndex:0] isEqualToString:@"0"]){
        [responseLabel setText:[_query getValue:@"message" withIndex:0]];
    }else
        [responseLabel setText:AMLocalizedString(@"sendForgetPwd", nil)];
    [_query release];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (actionType) {
        case LoginAction:
            [self loginAction:textField];
            break;
        case ActiveAction:
            [self activeAction:textField];
            break;
        case ForgetPwd:
            [self forgetPassword:textField];
            break;
    }
    return YES;
}

#pragma -
#pragma mark LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithSuccessNotificationKey:(NSString*)successKey withFailedNotificationKey:(NSString*)failedKey withObserver:(id)target{
    if((self=[super init])){
        successString=nil;
        failedString=nil;
        if (successKey!=nil) {
            successString=[[NSString stringWithFormat:@"%@",successKey]retain];
        }
        if(failedKey!=nil){
            failedString=[[NSString stringWithFormat:@"%@",failedKey]retain];
        }
        _target=target;
    }
    return  self;
}
- (void)dealloc
{
    if(successString!=nil) [successString release];
    if(failedString!=nil) [failedString release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    actionType=LoginAction;
    loginQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    accountTextField.delegate=self;
    passwordTextField.delegate=self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [loginQuery release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)valueChanged:(id)sender{
    [responseLabel setText:@""];
    UISegmentedControl *thisSeg=(UISegmentedControl*)sender;
    accountTextField.text=@"";
    passwordTextField.text=@"";
    switch (thisSeg.selectedSegmentIndex) {
        case 0:
            actionType=LoginAction;
            [accountLabel setText:AMLocalizedString(@"account", nil)];
            [passwordLabel setText:AMLocalizedString(@"password", nil)];
            break;
        case 1:
            actionType=ActiveAction;
            [accountLabel setText:AMLocalizedString(@"cardNumber", nil)];
            [passwordLabel setText:AMLocalizedString(@"phoneNumber", nil)];
            break;
        case 2:
            actionType=ForgetPwd;
            [accountLabel setText:AMLocalizedString(@"cardNumber", nil)];
            [passwordLabel setText:AMLocalizedString(@"phoneNumber", nil)];
            break;
    }
}
#pragma -
@end
