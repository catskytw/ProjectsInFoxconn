//
//  ForgetPasswordViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/16.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface ForgetPasswordViewController: FcViewController <UITextFieldDelegate>{

    UITextField *usernameTF;
    UIButton *submitButton;
    UIButton *backBtn;
    UIView *backGroundView;
    UIImageView *usernameTFBg;
    UIImageView *emailTFBg;
    UIImageView *naviBarImg;
    UILabel *navibarTitle;
    UIImageView *seperateLine;
    UIImageView *belowbarImg;
    UITextField *emailTF;
}
@property (nonatomic, retain) IBOutlet UITextField *emailTF;
@property (nonatomic, retain) IBOutlet UIImageView *belowbarImg;
@property (nonatomic, retain) IBOutlet UIImageView *seperateLine;
@property (nonatomic, retain) IBOutlet UILabel *navibarTitle;
@property (nonatomic, retain) IBOutlet UIImageView *naviBarImg;
@property (nonatomic, retain) IBOutlet UIImageView *usernameTFBg;
@property (nonatomic, retain) IBOutlet UIImageView *emailTFBg;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButtonItem;
@property(nonatomic,retain) IBOutlet UITextField *usernameTF;
@property(nonatomic,retain) IBOutlet UIButton *submitButton;
@property (nonatomic, retain) IBOutlet UIButton *backBtn;
- (IBAction)backToLogin:(id)sender;
- (IBAction)submit:(id)sender;
-(void) setUIDefault;
-(void) getPassword;
- (BOOL) validateEmail: (NSString *) candidate;
-(BOOL) checkEmailFormat;
@end
