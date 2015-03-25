//
//  ModifyPasswordController.m
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "LoginDataObject.h"
#import "Tools.h"
@implementation ModifyPasswordController
@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize idLabel;
@synthesize originalPasswordText;
@synthesize newPasswordText;
@synthesize reiputPasswordText;
@synthesize modifyButton;

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
    [titleLabel release];
    [descriptionLabel release];
    [idLabel release];
    [originalPasswordText release];
    [newPasswordText release];
    [reiputPasswordText release];
    [modifyButton release];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setDescriptionLabel:nil];
    [self setIdLabel:nil];
    [self setOriginalPasswordText:nil];
    [self setNewPasswordText:nil];
    [self setReiputPasswordText:nil];
    [self setModifyButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(BOOL)checkReInputPwd{
    if ([newPasswordText.text isEqualToString:reiputPasswordText.text]) {
        return  YES;
    }else{
        NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"modifypwd_reinputerr_title",nil)]; 
        NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"modifypwd_reinputerr_msg",nil)]; 
        NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"modifypwd_reinputerr_ok", nil)]; 
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
        [alert show];
        return NO;
    }
}
- (IBAction)modifyPassword:(id)sender {
    QueryPattern *accountQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    [accountQuery prepareDic:changePwdQuery(((LoginDataObject*)[LoginDataObject sharedInstance]).sessionId, originalPasswordText.text,newPasswordText.text)];
   // NSLog(@"response %@",[accountQuery getValue:@"response" withIndex:0]);
    @try {
        if([Tools checkQureyResponse:[accountQuery getValue:@"response" withIndex:0]])
        {
            NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"modifypwd_changePwd_title",nil)]; 
            NSString *alertMessage =[NSString stringWithFormat:@"%@", AMLocalizedString(@"modifypwd_changePwd_msg",nil)]; 
            NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"modifypwd_changePwd_ok", nil)]; 
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
            [alert show];
            
        }else{
            descriptionLabel.text = AMLocalizedString(@"modifypwd_changePwd_err",nil);
            if([Tools isPopToRoot])
            {
                [self.navigationController popToRootViewControllerAnimated:NO];
                [Tools setPopToRoot:NO];
            }
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
    titleLabel.text=AMLocalizedString(@"modifypwd_title",nil);
    descriptionLabel.text=AMLocalizedString(@"modifypwd_description",nil);
    idLabel.text =AMLocalizedString(@"modifypwd_id",nil);
    
    originalPasswordText.placeholder = AMLocalizedString(@"modifypwd_originalpwd",nil);
    newPasswordText.placeholder = AMLocalizedString(@"modifypwd_newpwd",nil);
    reiputPasswordText.placeholder = AMLocalizedString(@"modifypwd_recheck",nil);
    [modifyButton setTitle:AMLocalizedString(@"modifypwd_modifybutton",nil) forState:UIControlStateNormal];
    [modifyButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(227,45) forNinePatchNamed:@"contentui_btn_commons_push"] forState:UIControlStateNormal];

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
    if ([sender isEqual:reiputPasswordText])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)sender
{
    if ([sender isEqual:reiputPasswordText])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y <= 0)
        {
            [self setViewMovedUp:NO];
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


@end
