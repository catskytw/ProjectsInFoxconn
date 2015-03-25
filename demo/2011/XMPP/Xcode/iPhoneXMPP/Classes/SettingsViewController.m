//
//  SettingsViewController.m
//  iPhoneXMPP
//
//  Created by Eric Chamberlain on 3/18/11.
//  Copyright 2011 RF.com. All rights reserved.
//

#import "SettingsViewController.h"
#import "iPhoneXMPPAppDelegate.h"

NSString *const kXMPPmyJID = @"kXMPPmyJID";
NSString *const kXMPPmyPassword = @"kXMPPmyPassword";


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
}

- (void)dealloc
{
  [jidField release];
  [passwordField release];
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  jidField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyJID];
  passwordField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kXMPPmyPassword];
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

  [self dismissModalViewControllerAnimated:YES];
    //[[self appDelegate] disconnect];
    [[self appDelegate] setupStream];
  [[self appDelegate] connect];
}

- (IBAction)ui_register:(id)sender
{
    isRegister = YES;
    [self setField:jidField forKey:kXMPPmyJID];
    [self setField:passwordField forKey:kXMPPmyPassword];
    
    [self dismissModalViewControllerAnimated:YES];
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

@end
