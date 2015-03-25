//
//  ExhibitorAddBookingViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateUtilty.h"
#import "FcPickerController.h"
#import "FcViewController.h"
@interface ExhibitorAddBookingViewController : FcViewController <UIPickerViewDelegate,UITextFieldDelegate,FcPickerDelegate>
{
    UILabel *selectedIntervalLabel;
    int mode; //0,日期 1 開始 2,結束
    UIImageView *inputBgImg;
    UIButton *endBtn;
    UIButton *dateBtn;
    UIButton *startBtn;
    UILabel *dateLabel;
    UILabel *startLabel;
    UILabel *endLabel;
    UILabel *endDataLabel;
    UILabel *startDataLabel;
    UILabel *dateDataLabel;
    //UIDatePicker *picker;
    UIButton *backButton;
    UIButton *editButton;
    
    UILabel *remarkLabel;
    UIImageView *remarkImg;
    UITextField *remarkTextField;
    DateUtilty *selectTime;
    FcPickerController *fcPicker;
    BOOL isEdit ;
}
@property (nonatomic, retain) IBOutlet UITextField *remarkTextField;
@property (nonatomic, retain) IBOutlet UIImageView *remarkImg;
@property (nonatomic, retain) IBOutlet UILabel *remarkLabel;
@property (nonatomic, retain) IBOutlet UIImageView *inputBgImg;
@property (nonatomic, retain) IBOutlet UIButton *endBtn;
@property (nonatomic, retain) IBOutlet UIButton *dateBtn;
@property (nonatomic, retain) IBOutlet UIButton *startBtn;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *startLabel;
@property (nonatomic, retain) IBOutlet UILabel *endLabel;
@property (nonatomic, retain) IBOutlet UILabel *endDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *startDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateDataLabel;
@property (nonatomic, retain) IBOutlet UIDatePicker *picker;

@property (nonatomic, retain) IBOutlet UILabel *selectedIntervalLabel;
- (IBAction)remarkEditingDidBegin:(id)sender;
- (IBAction)remarkEditingDidEnd:(id)sender;
- (IBAction)remarkDidEndOnExit:(id)sender;
- (IBAction)selectEndTime:(id)sender;
- (IBAction)selectDate:(id)sender;
- (IBAction)selectStartTime:(id)sender;
- (IBAction)pickerValueChanged:(id)sender;
- (IBAction)touchCancel:(id)sender;
- (IBAction)touchDown:(id)sender;
- (IBAction)dragEnter:(id)sender;
- (IBAction)dragOut:(id)sender;
-(void) setUIDefault;
//-(void)addEditButton;
-(void) initData;
//-(void)addBackButton;
-(void) setGroupStyleButton;
-(void)setDefaultLableColor:(UILabel*)lbl;
-(void) clearInputData; 
@end
