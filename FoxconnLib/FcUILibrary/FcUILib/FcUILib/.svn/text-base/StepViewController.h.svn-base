//
//  StepViewController.h
//  logistic
//
//  Created by Chang Link on 11/8/8.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StepViewControllerDelegate ;
@interface StepViewController : UIViewController{
    NSMutableArray* stepViews;
    NSMutableArray* stepNoPic;
    NSArray *stepViewsName;
    NSArray *stepNoPicOn;
    NSArray *stepNoPicOff;
    NSDictionary *passInfoDic;
    int currentStep;
    id<StepViewControllerDelegate> delegate;
    UIScrollView *scrollView;
    UIImageView *bgImg;
}
@property (nonatomic, retain) IBOutlet UIImageView *bgImg;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
-(void)initWithXibNames:(NSArray*) nibName;
-(void)commit:(NSInteger)stepNum withInfo:(NSDictionary*)infoDic;
-(void)moveToStep:(NSInteger)stepNum;
@property (nonatomic, retain) NSMutableArray* stepViews;
@property (nonatomic, assign) id<StepViewControllerDelegate> delegate;
@end
@protocol StepViewControllerDelegate 
//步驟commit成功時,callback method.
-(void)stepCommit:(NSInteger)stepNum withInfo:(NSDictionary*)infoDic;
//步驟commit發生錯誤時,callback method.
-(BOOL)stepCommitError:(NSInteger)stepNum withError:(NSError**)error;
//-(void)setBackGround;
@end
