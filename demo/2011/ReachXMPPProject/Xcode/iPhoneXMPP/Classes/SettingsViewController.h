//
//  SettingsViewController.h
//  iPhoneXMPP
//
//  Created by Eric Chamberlain on 3/18/11.
//  Copyright 2011 RF.com. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const kXMPPmyJID;
extern NSString *const kXMPPmyPassword;
extern NSString *const kXMPPmyServerHost;


@interface SettingsViewController : UIViewController 
{
    UITextField *jidField;
    UITextField *passwordField;
    UITextField *serverHostField;
    IBOutlet UIButton *_rBtn;
    BOOL isRegister;
}
@property(nonatomic) BOOL isRegister;
@property(nonatomic,retain)IBOutlet UIButton *_rBtn;
@property (nonatomic,retain) IBOutlet UITextField *jidField;
@property (nonatomic,retain) IBOutlet UITextField *passwordField;
@property (nonatomic,retain) IBOutlet UITextField *serverHostField;

- (IBAction)done:(id)sender;
- (IBAction)ui_register:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
