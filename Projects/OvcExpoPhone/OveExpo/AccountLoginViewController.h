//
//  AccountLoginViewController.h
//  WMBT
//
//  Created by link on 2011/6/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"
#import "FcViewController.h"
@interface AccountLoginViewController : FcViewController <UITextFieldDelegate>{
    UIImageView *MainImage;
    UILabel *descriptionLabel;
    UITextField *usernameTF;
    UITextField *passwordTF;
    UIButton *loginButton;
    UIButton *modifyButton;
    UIButton *forgetButton;
    UIActivityIndicatorView *loginIndicator;
    UIButton *registerButton;
    UINavigationController *navi;

    UIView *backGroundView;
    UINavigationBar *navigationBar;
    
    UINavigationItem *naviItem;
    UIBarButtonItem *barButtonItem;
    UIBarButtonItem *loginBarButtonItem;
    UIImageView *usernameTFBg;
    UIImageView *passwordTFBg;
    UIImageView *naviBarImg;
    UILabel *navibarTitle;
    UIImageView *seperateLine;
    
    UIImageView *belowbarImg;
    RegisterViewController *regiesterViewController;
    ForgetPasswordViewController *forgerViewController;
    UIImageView *topBar;
}
@property (nonatomic, retain) IBOutlet UIImageView *topBar;
@property (nonatomic, retain) IBOutlet UIImageView *belowbarImg;
@property (nonatomic, retain) IBOutlet UIImageView *seperateLine;
@property (nonatomic, retain) IBOutlet UILabel *navibarTitle;
@property (nonatomic, retain) IBOutlet UIImageView *naviBarImg;
@property (nonatomic, retain) IBOutlet UIImageView *usernameTFBg;
@property (nonatomic, retain) IBOutlet UIImageView *passwordTFBg;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButtonItem;
@property (nonatomic, retain) IBOutlet UINavigationItem *naviItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIView *backGroundView;
@property (nonatomic, retain) IBOutlet UIImageView *MainImage;
@property(nonatomic,retain) IBOutlet UILabel *descriptionLabel;
@property(nonatomic,retain) IBOutlet UITextField *usernameTF;
@property(nonatomic,retain) IBOutlet UITextField *passwordTF;
@property(nonatomic,retain) IBOutlet UIButton *loginButton;
@property(nonatomic,retain) IBOutlet UIButton *modifyButton;
@property(nonatomic,retain) IBOutlet UIButton *forgetButton;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *loginIndicator;
@property (nonatomic, retain) IBOutlet UIButton *registerButton;
@property(nonatomic,retain)id mainController;
- (IBAction) login:(id) sender;
- (IBAction)registerId:(id)sender;
- (IBAction)forgetPassword:(id)sender;




-(void) setUIDefault;
-(void) checkLogin;
-(void)setViewMovedUp:(BOOL)movedUp;


@end
