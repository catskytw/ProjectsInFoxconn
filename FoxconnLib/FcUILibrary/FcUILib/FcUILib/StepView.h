//
//  StepView.h
//  logistic
//
//  Created by Chang Link on 11/8/9.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepViewController.h"
#import "NinePatch.h"
@interface StepView : UIView{
    StepViewController* superController;
    BOOL bProcessing;
    int iNo;
}
@property (nonatomic, retain) StepViewController* superController;
@property (nonatomic, assign) BOOL bProcessing;
@property (nonatomic, assign) int iNo;
-(void) initLayout;
-(void) setLayout;
-(void)setProcessing:(BOOL)bProcess;
@end
