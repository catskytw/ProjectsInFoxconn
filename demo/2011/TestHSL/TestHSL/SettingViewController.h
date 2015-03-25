//
//  SettingViewController.h
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/11/1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
{
    IBOutlet UITextField *textField1;
    IBOutlet UITextField *textField2;
}
@property(nonatomic,retain)UITextField *textField1,*textField2;
-(IBAction)settingAction:(id)sender;
@end
