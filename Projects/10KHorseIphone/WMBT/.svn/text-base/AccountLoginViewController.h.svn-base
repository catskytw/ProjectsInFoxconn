//
//  AccountLoginViewController.h
//  WMBT
//
//  Created by link on 2011/6/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveAccountController.h"

@interface AccountLoginViewController : UIViewController <UITextFieldDelegate>{
    UIImageView *MainImage;
    UILabel *descriptionLabel;
    UITextField *usernameField;
    UITextField *passwordField;
    UIButton *loginButton;
    UIButton *modifyButton;
    UIButton *forgetButton;
    UIActivityIndicatorView *loginIndicator;
    UIButton *activeAccountButton;
    UINavigationController *navi;

    UIView *backGroundView;
    UINavigationBar *navigationBar;
    
    ActiveAccountController *activeController;
    UINavigationItem *naviItem;
    UIBarButtonItem *barButtonItem;
    UIBarButtonItem *loginBarButtonItem;
}
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButtonItem;
@property (nonatomic, retain) IBOutlet UINavigationItem *naviItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIView *backGroundView;
@property (nonatomic, retain) IBOutlet UIImageView *MainImage;
@property(nonatomic,retain) IBOutlet UILabel *descriptionLabel;
@property(nonatomic,retain) IBOutlet UITextField *usernameField;
@property(nonatomic,retain) IBOutlet UITextField *passwordField;
@property(nonatomic,retain) IBOutlet UIButton *loginButton;
@property(nonatomic,retain) IBOutlet UIButton *modifyButton;
@property(nonatomic,retain) IBOutlet UIButton *forgetButton;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *loginIndicator;
@property (nonatomic, retain) IBOutlet UIButton *activeAccountButton;
@property(nonatomic,retain)id mainController;
- (IBAction) login:(id) sender;
- (IBAction)acctiveAccount:(id)sender;
- (IBAction)forgetPassword:(id)sender;
- (IBAction)backToLogin:(id)sender;
-(void) forgetPasswordandActiveAccount:(int)mode;
-(void) setUIDefault;
-(void) setNaviTitle:(NSString*)title;
-(void)setViewMovedUp:(BOOL)movedUp;


@end
