//
//  MOLoginView.m
//  MobileOffice
//
//  Created by  on 11/9/6.
//  Copyright 2011年 foxconn. All rights reserved.
//
#import "WheelDisk.h"
#import "EventAction.h"
#import "FcConfig.h"
#import "EventTableCell.h"
#import "DrawEventObject.h"
#import "UIView_extend.h"
#import "EventObject.h"
#import "DateButton.h"
#import "DateCaculator.h"
#import "LocalizationSystem.h"
#import "FcDrawing.h"
#import "FcEventButton.h"
#import "DateView.h"
#import "WEPopoverController.h"
#import "EventEditViewController.h"
#import "EventContent.h"
#import "CalendarDAO.h"
#import "Tools.h"

#import "MOLoginViewController.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "NinePatch.h"
#import "MOLoginInfo.h"

//reach debug
#define MY_DEBUG NO

@interface MOLoginViewController(PrivateMethod)
-(BOOL) login:(NSString *)workNo withPassword:(NSString *)password;
-(void) queryPassword:(NSString *)address;//email or phone number.
-(int) checkInputFormat:(NSString *)inputStr; //1:email, 2:phone.
@end

@implementation MOLoginViewController
@synthesize isLoginOK;
@synthesize delegate;

static MOLoginInfo *loginInfo;

+ (MOLoginInfo *)loginInfo
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		loginInfo = [[MOLoginInfo alloc] init];
	});
	
	return loginInfo;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isLoginOK = NO;
    }
    return self;
}

#pragma mark - View lifecycle
-(void)backView{
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //
    //0. Set backgroup view
    //UIImageView *_backgroudColor = [[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:queryBut.frame.size forNinePatchNamed:@"bkg"] highlightedImage:<#(UIImage *)#>];
    //backgroundView 
    //1. Init login view
    currentView = loginView;
    //[loginView setCenter:CGPointMake(500, 300)];
    //[logo setImage:[TUNinePatchCache imageOfSize:CGSizeMake(150, 38) forNinePatchNamed:@"img_foxconn_logo"]];
    
    [accountTF setTextColor:[UIColor colorWithRed:153 green:153 blue:153 alpha:1]];
    [accountTF setPlaceholder:@"帳號"];
    [accountTF setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    //[accountTF setBounds:CGRectMake(0, 130, 322, 49)];
    [accountTF_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake(322, 49) forNinePatchNamed:@"editbox"]];
    [accountTF_bk setHighlightedImage:[TUNinePatchCache imageOfSize:CGSizeMake(322, 49) forNinePatchNamed:@"editbox_i"]];
    [accountTF_bk setHighlighted:NO];
    
    [passwordTF setTextColor:[UIColor colorWithRed:153 green:153 blue:153 alpha:1]];
    [passwordTF setPlaceholder:@"密碼"];
    [passwordTF setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    //[passwordTF setBounds:CGRectMake(0, 130, 322, 49)];
    [passwordTF_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake(322, 49) forNinePatchNamed:@"editbox"]];
    [passwordTF_bk setHighlightedImage:[TUNinePatchCache imageOfSize:CGSizeMake(322, 49) forNinePatchNamed:@"editbox_i"]];
    [passwordTF_bk setHighlighted:NO];
    
    //queryBt.frame=CGRectMake((333-84), 245, 84, 32);
    [queryBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [queryBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    
    //2. Init query view
    [queryView_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake(591, 305) forNinePatchNamed:@"popup_bg"]];
    [queryView_bk_line setImage:[TUNinePatchCache imageOfSize:CGSizeMake(591, 305) forNinePatchNamed:@"popup_line"]];
    [queryTF_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake(591, 305) forNinePatchNamed:@"editbox"]];
    [queryTF_bk setHighlightedImage:[TUNinePatchCache imageOfSize:CGSizeMake(591, 305) forNinePatchNamed:@"editbox_i"]];
    [okBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [okBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [cancelBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [cancelBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    
    //3. Init query response view
    [queryResponseView_bk setImage:[TUNinePatchCache imageOfSize:CGSizeMake(591, 305) forNinePatchNamed:@"popup_bg"]];
    [queryResponseView_bk_line setImage:[TUNinePatchCache imageOfSize:CGSizeMake(591, 305) forNinePatchNamed:@"popup_line"]];
    [closeBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [closeBt setBackgroundImage:
     [TUNinePatchCache imageOfSize:queryBt.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    
    //accountTF se
    //[[self view] addSubview:loginView];
    currentView = loginView;
    [loginView setHidden:NO];
    [queryView setHidden:YES];
    [queryResponseView setHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.view removeFromSuperview];
    [self release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)?YES:NO;
}

- (void)dealloc
{
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TextField
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    currentTF = textField;
    NSLog(@"textFieldShouldReturn");
    if (currentView == loginView) {
        if (([[accountTF text]length] > 0) && ([[passwordTF text]length] > 0)) {
            BOOL _result = [self login:accountTF.text withPassword:passwordTF.text];
            if (_result == NO) {
                UIAlertView *_alertView = [[[UIAlertView alloc]initWithTitle:@"Error" message:@"Login Fail" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil]autorelease];
                [_alertView show];
            }
            else
            {
                [self viewDidUnload];
            }
        }
    }
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTF = textField; 
    if (textField == accountTF) {
        [accountTF_bk setHighlighted:YES];
    }
    
    if (textField == passwordTF) {
        [passwordTF_bk setHighlighted:YES];
    }
    
    if (textField == queryTF) {
        [queryTF_bk setHighlighted:YES];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == accountTF) {
        [accountTF_bk setHighlighted:NO];
    }
    
    if (textField == passwordTF) {
        [passwordTF_bk setHighlighted:NO];
    }
    
    if (textField == queryTF) {
        [queryTF_bk setHighlighted:NO];
    }
    return YES;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//1:email, 2:phone
-(int) checkFormat:(NSString *)inputStr
{
    int type = 0;
    if ([inputStr length] > 0) {
        NSRange range = [inputStr rangeOfString:@"@"];
        NSLog(@"range loc= %d, len = %d", range.location, range.length);
        if (range.length > 0) {
            NSLog(@"input format is \"email\".");
            type = 1;
        }
        else
        {
            type = 2;
        }
    }
    
    return type;
}

-(BOOL) login:(NSString *)_workNo withPassword:(NSString *)_password
{
    NSLog(@"Reach : Start to login...");
    //XXXX : handle login
    isLoginOK = NO;//default should be NO, but current is YES because server is not ready.
    NSString *workNo = _workNo;
    NSString *password = _password;
    
    QueryPattern *query=[QueryPattern new];
    if (MY_DEBUG == YES) {
        isLoginOK = YES;
        [MOLoginViewController loginInfo].sessionId=@"1234567890";
        [MOLoginViewController loginInfo].loginId=@"workid";
        NSLog(@"Reach : [MOLoginViewController loginInfo].sessionId=%@", [MOLoginViewController loginInfo].sessionId); 
    }
    else
    {
        NSString *_queryStr = loginURL(workNo, password);
        _queryStr = [_queryStr stringByAppendingFormat:@"&rnd=%i",arc4random()];
        [query prepareDic:_queryStr];
        NSString *m_response=[query getValue:@"response" withIndex:0];
        isLoginOK=([m_response isEqualToString:@"0"])?YES:NO;
        if (isLoginOK == YES) {
            [MOLoginViewController loginInfo].sessionId=[NSString stringWithString: [query getValueUnderNode:@"sessionInfo" withKey:@"id" withIndex:0]];
            [MOLoginViewController loginInfo].loginId=[NSString stringWithString:[query getValueUnderNode:@"sessionInfo" withKey:@"loginId" withIndex:0]];
        }
    }

    [query release];
    
    //XXXX : set sessio id
    [[self delegate] didReceiveLoginResult:isLoginOK];
    return isLoginOK;
}

-(void) queryPassword:(NSString *)address
{
    NSLog(@"Reach : Start to query password...");
    //XXXX : handle login
    QueryPattern *query=[QueryPattern new];
    [query prepareDic:queryPasswordURL(address)];
    [query release];    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IBActions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(IBAction) processOK
{
    //XXXX : query password by email or phone number.
    //1. check input format.
    NSString *inputStr = queryTF.text;
    NSLog(@"query password string is %@...",inputStr);
    int type = [self checkFormat:inputStr];
    if (type == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"輸入格式可能有誤" delegate:nil cancelButtonTitle:@"關閉" otherButtonTitles:nil];
        [alert show];
        //[alert release];
    }
    else
    {
        passwordToLabel.text = [NSString stringWithFormat:@"『%@』",queryTF.text];
        NSString *_format = nil;
        if (type == 1) {
            _format = @"Email";
        }
        else
        {
            _format = @"手機";
        }
        [self queryPassword:inputStr];
        pleaseCheckLabel.text = [NSString stringWithFormat:@"請檢查%@", _format];
        currentView = queryResponseView;
        [queryResponseView setHidden:NO];
        [loginView setHidden:YES];
        [queryView setHidden:YES];
        //[queryResponseView setFrame:CGRectMake(250, 150, 570, 230)];
        //CGSize size = self.view.frame.size;
        //queryResponseView.center = CGPointMake(size.width/2.0f, size.height/2.0f);
        //[[self view] addSubview:queryResponseView];
    }
    
    [currentTF resignFirstResponder];
}

-(IBAction) processCancel
{
    currentView = loginView;
    [loginView setHidden:NO];
    [queryView setHidden:YES];
    [queryResponseView setHidden:YES];
    
    [currentTF resignFirstResponder];
}

-(IBAction) processQuery
{
    //User forget password and want to get password by using email or password.
    currentView = queryView;
    [queryView setHidden:NO];
    [loginView setHidden:YES];
    [queryResponseView setHidden:YES];
    //[queryView setCenter:CGPointMake([self view].frame.size.width/2, [self view].frame.size.height/2)];
    //[[self view] addSubview:queryView];
    
    [currentTF resignFirstResponder];
}

@end
