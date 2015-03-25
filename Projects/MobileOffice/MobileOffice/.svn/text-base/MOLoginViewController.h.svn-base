//
//  MOLoginView.h
//  MobileOffice
//
//  Created by  on 11/9/6.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOLoginDelegate;
@class MOLoginInfo;

@interface MOLoginViewController : UIViewController<
UITextFieldDelegate>
{
    //For background view
    IBOutlet UIView *backgroundView;
    
    
    //For login view
    IBOutlet UIImageView *logo;
    IBOutlet UIImageView *accountTF_bk;
    IBOutlet UITextField *accountTF;
    IBOutlet UIImageView *passwordTF_bk;
    IBOutlet UITextField *passwordTF;
    IBOutlet UIView *loginView;
    IBOutlet UIButton *queryBt;
    
    //For password query view
    IBOutlet UIImageView *queryView_bk;
    IBOutlet UIImageView *queryView_bk_line;
    IBOutlet UIImageView *queryTF_bk;
    IBOutlet UITextField *queryTF;
    IBOutlet UIView *queryView;
    IBOutlet UIButton *okBt;
    IBOutlet UIButton *cancelBt;
    
    //For password query response view
    IBOutlet UIImageView *queryResponseView_bk;
    IBOutlet UIImageView *queryResponseView_bk_line;
    IBOutlet UIView *queryResponseView;
    IBOutlet UILabel *passwordToLabel;
    IBOutlet UILabel *pleaseCheckLabel;
    IBOutlet UIButton *closeBt;
    
    UIView *currentView;
    UITextField *currentTF;
    BOOL isLoginOK;
}
@property (nonatomic, readonly) BOOL isLoginOK;
@property(nonatomic,retain) id<MOLoginDelegate> delegate; // default is nil. weak reference
+ (MOLoginInfo *)loginInfo;
//@property (nonatomic, retain) UITextField *passwordTF;

-(IBAction) processOK;
-(IBAction) processCancel;
-(IBAction) processQuery;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - MOLoginDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol MOLoginDelegate <NSObject>
/**
 * Sent when a login request is finish.
 * 
 **/
- (void)didReceiveLoginResult:(BOOL)isOK;

@end

