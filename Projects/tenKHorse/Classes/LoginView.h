//
//  LoginView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryPattern.h"

@interface LoginView : UIViewController <UITextFieldDelegate> {
    IBOutlet UILabel *accountLabel;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UITextField *accountTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIView *showingView;
    IBOutlet UILabel *responseLabel;
    IBOutlet UISegmentedControl *actionSegment;
    
    NSString *successString;
    NSString *failedString;
    NSInteger actionType;
    BOOL isMember;
    id _target;
    QueryPattern *loginQuery;
}
@property(nonatomic,retain)UILabel *accountLabel,*passwordLabel,*responseLabel;
@property(nonatomic,retain)UIView *showingVew;
@property(nonatomic,retain)UISegmentedControl *actionSegment;
-(id)initWithSuccessNotificationKey:(NSString*)successKey withFailedNotificationKey:(NSString*)failedKey withObserver:(id)target;
-(IBAction)valueChanged:(id)sender;
@end
