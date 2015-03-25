//
//  RegisterInfoTableViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterViewController;
@interface RegisterInfoTableViewController : UITableViewController<UITextFieldDelegate>{
    UITextField *firstNameTextField;
    UITextField *lastNameTextField;
    UITextField *nickNameTextField;
    UILabel *sexContentLabel;
    UITextField *jobTitleTextField;
    UITextField *departTextField;
    UITextField *companyTextField;
    UILabel *countryContentLabel;
    UITextField *provinceTextField;
    UITextField *cityTextField;
    UITextField *addressTextField;
    UITextField *zipTextField;
    UITextField *telTextField;
    UITextField *faxTextField;
    UITextField *mobileTextField;
    UITextField *emailTextField;
    UITextField *websiteTextField;
    NSArray *labelArray;
    NSArray *contentArray;
    RegisterViewController *rootController;
    UITextField *currentTextField;
    
}
@property (nonatomic, retain) RegisterViewController *rootController;
@property (nonatomic, retain) UITextField *firstNameTextField;
@property (nonatomic, retain) UITextField *lastNameTextField;
@property (nonatomic, retain) UITextField *nickNameTextField;
@property (nonatomic, retain) UILabel *sexContentLabel;
@property (nonatomic, retain) UITextField *jobTitleTextField;
@property (nonatomic, retain) UITextField *departTextField;
@property (nonatomic, retain) UITextField *companyTextField;
@property (nonatomic, retain) UILabel *countryContentLabel;
@property (nonatomic, retain) UITextField *provinceTextField;
@property (nonatomic, retain) UITextField *cityTextField;
@property (nonatomic, retain) UITextField *addressTextField;
@property (nonatomic, retain) UITextField *zipTextField;
@property (nonatomic, retain) UITextField *telTextField;
@property (nonatomic, retain) UITextField *faxTextField;
@property (nonatomic, retain) UITextField *mobileTextField;
@property (nonatomic, retain) UITextField *emailTextField;
@property (nonatomic, retain) UITextField *websiteTextField;
-(void) initContentField;//初始化 內容區域 輸入框或跳出picker的Label
-(void)setSelectedRowColor:(int)row;
@end
