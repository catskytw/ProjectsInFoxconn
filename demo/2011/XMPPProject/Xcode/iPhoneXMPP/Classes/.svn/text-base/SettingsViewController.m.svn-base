//
//  SettingsViewController.m
//  iPhoneXMPP
//
//  Created by Eric Chamberlain on 3/18/11.
//  Copyright 2011 RF.com. All rights reserved.
//

#import "SettingsViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "Tools.h"
NSString *const kXMPPmyJID = @"kXMPPmyJID";
NSString *const kXMPPmyPassword = @"kXMPPmyPassword";
NSString *const kXMPPmyServerHost = @"kXMPPmyServerHost";


@implementation SettingsViewController
@synthesize _rBtn;
@synthesize isRegister;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Init/dealloc methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (iPhoneXMPPAppDelegate *)appDelegate
{
	return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)awakeFromNib {
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissNotification:) name:@"dismissSettingNotification" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"dismissSettingNotification" object:nil];
    [jidField release];
    [passwordField release];
    [serverHostField release];
    [super dealloc];
}
-(void)dismissNotification:(NSNotification*)notification{
    [Tools delWaitCursor];
     [self dismissModalViewControllerAnimated:YES];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  jidField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
  passwordField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword];
  serverHostField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyServerHost];  
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Private
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setField:(UITextField *)field forKey:(NSString *)key
{
  if (field.text != nil) 
  {
    [[NSUserDefaults standardUserDefaults] setObject:field.text forKey:key];
  } else {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Actions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)done:(id)sender
{
    isRegister = NO;
    [self setField:jidField forKey:kXMPPmyJID];
    [self setField:passwordField forKey:kXMPPmyPassword];
    [self setField:serverHostField forKey:kXMPPmyServerHost];
    //[self dismissModalViewControllerAnimated:YES];
    //[[self appDelegate] disconnect];
    [[self appDelegate] setupStream];
    [[self appDelegate] connect];
    [Tools addWaitCursor];
}

- (IBAction)ui_register:(id)sender
{
    isRegister = YES;
    [self setField:jidField forKey:kXMPPmyJID];
    [self setField:passwordField forKey:kXMPPmyPassword];
    [self setField:serverHostField forKey:kXMPPmyServerHost];
    
    [self dismissModalViewControllerAnimated:YES];
    [[self appDelegate] setupStream];
    [[self appDelegate] connect];
}


- (IBAction)hideKeyboard:(id)sender {
  [sender resignFirstResponder];
  [self done:sender];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Getter/setter methods
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@synthesize jidField;
@synthesize passwordField;
@synthesize serverHostField;

@end
