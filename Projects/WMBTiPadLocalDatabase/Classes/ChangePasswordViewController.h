//
//  ChangePasswordViewController.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChangePasswordViewController : UIViewController {
    IBOutlet UIButton *logoutBtn;
    IBOutlet UIButton *prePage;
    IBOutlet UIButton *changePwdBtn;
    
    IBOutlet UITextField *originPwd;
    IBOutlet UITextField *newPwd;
    IBOutlet UITextField *confirmPwd;
    
    IBOutlet UILabel *responseLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *navibarLable;
    IBOutlet UILabel *newPwdLabel;
    IBOutlet UILabel *confirmPwdLabel;
    IBOutlet UILabel *originPwdLabel;
}
@property (nonatomic, retain) UILabel *originPwdLabel;
@property (nonatomic, retain) UILabel *navibarLable;
@property (nonatomic, retain) UILabel *newPwdLabel;
@property (nonatomic, retain) UILabel *confirmPwdLabel;
@property(nonatomic,retain)UIButton *logoutBtn,*prePage,*changePwdBtn;
@property(nonatomic,retain)UITextField *originPwd,*newPwd,*confirmPwd;
@property(nonatomic,retain)UILabel *responseLabel,*titleLabel;
-(IBAction)ChangePwdAction:(id)sender;
-(IBAction)prepage:(id)sender;
-(void)evenlopSuit;
@end
