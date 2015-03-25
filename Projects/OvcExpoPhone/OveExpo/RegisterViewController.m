//
//  RegisterViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "RegisterViewController.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "SBJsonWriter.h"
#import "UITuneLayout.h"

@implementation RegisterViewController
@synthesize picker;
@synthesize naviBarImg;
@synthesize scrollView;
@synthesize belowbarImg;
@synthesize navibarTitle;
@synthesize submitBtn;
@synthesize cancelBtn;
@synthesize accountTable;
@synthesize infoTable;
@synthesize pickerType,sexType;
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
    [self initCountry];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear accountTable height %f", accountTable.view.frame.size.height);
    NSLog(@"viewDidAppear infoTable height %f", infoTable.view.frame.size.height);
}
-(void) initCountry{
    countryArray = [NSMutableArray new];
    countryDic = [NSMutableDictionary new];
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    
	[accountQuery prepareDic:getCountryList];
    
    @try {
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            int number = [accountQuery getNumberForKey:@"id"];
            for (int i=0; i< number  ; i++) {
                [countryDic setObject:[accountQuery getValue:@"id" withIndex:i] forKey:[accountQuery getValue:@"name" withIndex:i]];
            }
        }else{
            
            
        }
        
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [accountQuery release];
    }

}
-(void) checkNeededTextField{
    if([accountTable.accountTextField.text length]>0 &&
       [accountTable.passwordTextField.text length]>0 &&
       //[infoTable.firstNameTextField.text length]>0&&
       //[infoTable.lastNameTextField.text length]>0&&
       [infoTable.nickNameTextField.text length]>0&&
       //[infoTable.emailTextField.text length]>0&&
       [infoTable.mobileTextField.text length]>0){
        submitBtn.enabled = YES;
    }
}
-(void) setUIDefault{
    
    
    [submitBtn setTitle:AMLocalizedString(@"submit",nil) forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:submitBtn.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[TUNinePatchCache imageOfSize:submitBtn.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];    
    [submitBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    submitBtn.enabled = NO;
    
    [cancelBtn setTitle:AMLocalizedString(@"back",nil) forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_back"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_back_i"] forState:UIControlStateHighlighted];    
    [cancelBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal]; 
    [cancelBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    
    CGRect Screenframe =  [[UIScreen mainScreen] applicationFrame];
    CGSize tableSize = accountTable.view.frame.size;
    accountTable.view.frame = CGRectMake(23, 20, tableSize.width, tableSize.height);
    NSLog(@"accountTable height %f", tableSize.height);
    accountTable.rootController =self;
    tableSize = infoTable.view.frame.size;
    CGRect seperateRect = CGRectMake(0, accountTable.view.frame.origin.y+42*2+17, 320, 2);
    infoTable.view.frame = CGRectMake(23, seperateRect.origin.y+17, tableSize.width, tableSize.height);
    infoTable.rootController = self;
    [scrollView addSubview:accountTable.view];
    [scrollView addSubview:infoTable.view];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, infoTable.view.frame.origin.y+infoTable.view.frame.size.height);
    
    //分隔線
    UIImageView *seperateLine = [UIImageView new];
    [seperateLine setImage:[TUNinePatchCache imageOfSize:seperateRect.size forNinePatchNamed:@"bg_line"]];
    seperateLine.frame = seperateRect;
    [scrollView addSubview:seperateLine];

    //導覽列
    naviBarImg.frame = CGRectMake(naviBarImg.frame.origin.x, Screenframe.origin.y, naviBarImg.frame.size.width, naviBarImg.frame.size.height);
    [naviBarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_actionbar"]];
        navibarTitle.frame = CGRectMake(navibarTitle.frame.origin.x, Screenframe.origin.y, navibarTitle.frame.size.width, navibarTitle.frame.size.height);
    [navibarTitle setText:AMLocalizedString(@"Login_RegisterButton",nil)];
    cancelBtn.frame = CGRectMake(cancelBtn.frame.origin.x, cancelBtn.frame.origin.y+ Screenframe.origin.y, cancelBtn.frame.size.width, cancelBtn.frame.size.height);
    submitBtn.frame = CGRectMake(submitBtn.frame.origin.x, submitBtn.frame.origin.y+ Screenframe.origin.y, submitBtn.frame.size.width, submitBtn.frame.size.height);
    scrollView.frame= CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y+ Screenframe.origin.y, scrollView.frame.size.width, scrollView.frame.size.height- Screenframe.origin.y);
    
    [self setBackItem:AMLocalizedString(@"back",nil)];
    [self setRightItem2:AMLocalizedString(@"submit",nil)];

    //下方ICON
    [belowbarImg setImage:[TUNinePatchCache imageOfSize:naviBarImg.frame.size forNinePatchNamed:@"img_belowbar"]];
    UIImageView *imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo.png"]];
    imgLogo.frame = CGRectMake(12, 8, imgLogo.frame.size.width, imgLogo.frame.size.height);    
    [belowbarImg addSubview:imgLogo];
    [imgLogo release];
    
    //set picker
    fcPicker  = [FcPickerController new];
    fcPicker.delegate = self;
    fcPicker.pickerdelegate = self;
    [self.view addSubview:fcPicker.view];
    fcPicker.view.frame = CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height- pickerHeightDif+belowbarImg.frame.size.height*2, fcPicker.view.frame.size.width, fcPicker.view.frame.size.height);

    //[self.view bringSubviewToFront:belowbarImg];
}
-(void)pickerSubmit{
    int row = [fcPicker.picker selectedRowInComponent:0];
    if (pickerType) {
        infoTable.countryContentLabel.text = [[countryDic allKeys] objectAtIndex:row];//[countryArray objectAtIndex:row];
    }else{
        if (row==0) {
            infoTable.sexContentLabel.text =  AMLocalizedString(@"male",nil); 
            sexType =1;
        }else{
            infoTable.sexContentLabel.text =  AMLocalizedString(@"female",nil); 
            sexType = 2;
        }
    }
}
-(void)pickerCancel{}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerType) {
        return [[countryDic allKeys] count];
    }else{
        return 2;
    }
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerType) {
        if ([[countryDic allKeys]count]>0) {
            return  [[countryDic allKeys] objectAtIndex:row];
        }
        return @"";
    }else{
        if (row==0) {
           return AMLocalizedString(@"male",nil); 
        }else{
           return AMLocalizedString(@"female",nil); 
        }
    }
    
    
}
-(void) showPicker{
    [fcPicker.picker reloadAllComponents];
    [fcPicker slideUp:YES];
}
- (void)viewDidUnload
{
    [self setAccountTable:nil];
    [self setInfoTable:nil];
    [self setScrollView:nil];
    [self setNaviBarImg:nil];
    [self setBelowbarImg:nil];
    [self setNavibarTitle:nil];
    [self setSubmitBtn:nil];
    [self setCancelBtn:nil];
    [self setPicker:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) setScrollViewPoint:(int) y{
    //NSLog(@"text position %d",y);
    //NSLog(@"scrollView.contentOffset.y %f",scrollView.contentOffset.y);
    if (y- scrollView.contentOffset.y>0 ) {
        [scrollView setContentOffset:CGPointMake(0, y)];
    }
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [accountTable release];
    [infoTable release];
    [scrollView release];
    [naviBarImg release];
    [belowbarImg release];
    [navibarTitle release];
    [submitBtn release];
    [cancelBtn release];
    [picker release];
    if (countryArray) {
        [countryArray release];
    }
    if (countryDic) {
        [countryDic release];
    }
    if (fcPicker) {
        [fcPicker release];
    }
    [super dealloc];
}
- (IBAction)cancel:(id)sender {
    [self.view removeFromSuperview];
}
-(NSString*)checkNull:(NSString*)sOrigin{
    return sOrigin?[sOrigin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:@"";
}
- (IBAction)submit:(id)sender {
    NSLog(@"id %@ password %@ firstname %@",accountTable.accountTextField.text, accountTable.passwordTextField.text, infoTable.firstNameTextField.text);
    //user: 
    //{"mail":"Zack@foxconn.com","lastName":"Chiang","sex":"1","nickname":"Zack","department":"PCEBG","firstName":"Zack","mobile":"0935000000","jobTitle":"IT"}
//company: 
   // {"zip":"807","phone":null,"fax":null,"website":null,"address":null,"name":"FOXCONN","province":"Taiwan","type":"V","city":"Kaoshiung","country":{"id":"22E6FC57-F3D4-464D-B61F-231E86DCAE3E"}}
    NSMutableDictionary *jsonAccount = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *jsonUser = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *jsonCompany = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *jsonCountry = [[NSMutableDictionary alloc] init];
        SBJsonWriter *parser = [[SBJsonWriter alloc] init];
    if ([accountTable.accountTextField.text length]>0) {
         [jsonAccount setObject:[self checkNull:accountTable.accountTextField.text] forKey:@"loginId"];
    }
    if ([accountTable.passwordTextField.text length]>0)
    [jsonAccount setObject:[self checkNull:accountTable.passwordTextField.text] forKey:@"password"];
    if ([infoTable.firstNameTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.firstNameTextField.text] forKey:@"firstName"];
    if ([infoTable.lastNameTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.lastNameTextField.text] forKey:@"lastName"];
    if ([infoTable.nickNameTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.nickNameTextField.text] forKey:@"nickName"];
    if ([infoTable.departTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.departTextField.text] forKey:@"department"];
    if ([infoTable.emailTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.emailTextField.text] forKey:@"mail"];
    if ([infoTable.mobileTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.mobileTextField.text] forKey:@"mobile"];
    if ([infoTable.departTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.departTextField.text] forKey:@"department"];
    if ([infoTable.sexContentLabel.text length]) {
        [jsonUser setObject:[NSString stringWithFormat:@"%d", sexType ] forKey:@"sex"];
    }
    if ([infoTable.jobTitleTextField.text length]>0)
    [jsonUser setObject:[self checkNull:infoTable.jobTitleTextField.text] forKey:@"jobTitle"];
    if ([infoTable.zipTextField.text length]>0)
    [jsonCompany setObject:[self checkNull:infoTable.zipTextField.text] forKey:@"zip"];
    if ([infoTable.telTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.telTextField.text] forKey:@"phone"];
    if ([infoTable.faxTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.faxTextField.text] forKey:@"fax"];
    if ([infoTable.websiteTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.websiteTextField.text] forKey:@"website"];
    if ([infoTable.addressTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.addressTextField.text] forKey:@"address"];
    if ([infoTable.companyTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.companyTextField.text] forKey:@"name"];
    if ([infoTable.provinceTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.provinceTextField.text] forKey:@"province"];
    if ([infoTable.cityTextField.text length]>0)
        [jsonCompany setObject:[self checkNull:infoTable.cityTextField.text] forKey:@"city"];
        [jsonCompany setObject:@"V" forKey:@"type"];
    
    //jsonCountry setObject:countryDic objectForkey:
    if ([infoTable.countryContentLabel.text length]) {
        [jsonCountry setObject:[countryDic objectForKey:infoTable.countryContentLabel.text] forKey:@"id"];
        [jsonCompany setObject:jsonCountry forKey:@"country"];
    }
    NSString * json_Str = registerAccount([parser stringWithObject:jsonAccount],[parser stringWithObject:jsonUser],[parser stringWithObject:jsonCompany]);
    //NSLog(json_Str);
    [jsonAccount release];
    [jsonUser release];
    [jsonCompany release];
    [jsonCountry release];
    [parser release];
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    
	[accountQuery prepareDic:[json_Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    @try {
        if (([[accountQuery getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"register_success",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"register_success_msg",nil)]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"login_alert_ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
        }else{
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"register_fail",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@%@", AMLocalizedString(@"Login_errormsg",nil),[accountQuery getValue:@"message" withIndex:0]]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"login_alert_ok", nil)]; 
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
@end
