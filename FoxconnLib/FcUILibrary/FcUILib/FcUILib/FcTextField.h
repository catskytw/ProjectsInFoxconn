//
//  FcTextField.h
//  Logistics
//
//  Created by Chang Link on 11/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FcTextField : UIView{
    UITextField *textField;
    UIImageView *iconImg;
    UIImageView *bgImg;
    BOOL bFocus;
}
@property (nonatomic, retain) IBOutlet UIImageView *bgImg;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UIImageView *iconImg;
@property (nonatomic, assign) BOOL bFocus;
-(void) setLayout;
-(void) setFocus:(BOOL)focus;
-(void) setDelegate:(id)delegate;
@end
