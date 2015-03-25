//
//  ModifyPasswordController.h
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ModifyPasswordController : UIViewController {
    
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    UILabel *idLabel;
    UITextField *originalPasswordText;
    UITextField *newPasswordText;
    UITextField *reiputPasswordText;
    UIButton *modifyButton;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *idLabel;
@property (nonatomic, retain) IBOutlet UITextField *originalPasswordText;
@property (nonatomic, retain) IBOutlet UITextField *newPasswordText;
@property (nonatomic, retain) IBOutlet UITextField *reiputPasswordText;
@property (nonatomic, retain) IBOutlet UIButton *modifyButton;
- (IBAction)modifyPassword:(id)sender;
-(void) setUIDefault;
-(void)setViewMovedUp:(BOOL)movedUp;
-(BOOL)checkReInputPwd;
@end
