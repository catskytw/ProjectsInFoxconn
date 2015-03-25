//
//  ExhibitorAddToPSViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateUtilty.h"
#import "FcPickerController.h"
#import "FcViewController.h"
@interface ExhibitorAddToPSViewController : FcViewController<FcPickerDelegate>
{
    //UIButton *backButton;
    int mode; //0, 開始 1,結束
    NSString *exhibitorName;
    NSString *iconUrl;
    NSString *exhibitorId;
    NSString *area;
    UIDatePicker *datePicker;

    
    UIImageView *iconImg;
    UILabel *titleLabel;
    UILabel *startLabel;
    UILabel *endLabel;
    UILabel *startDataLabel;
    UILabel *selectIntervalLabel;
    UILabel *endDataLabel;
    UIButton *startBtn;
    UIButton *endBtn;
    //UIButton *editButton;
    UIImageView *inputBgImg;
    NSDate *startDate;
    NSDate *endDate;
    DateUtilty *currentDate;
    FcPickerController *picker;
}

@property (nonatomic, retain) IBOutlet UIImageView *inputBgImg;
@property (nonatomic, retain) IBOutlet UIButton *endBtn;
@property (nonatomic, retain) IBOutlet UIButton *startBtn;
@property (nonatomic, retain) IBOutlet UILabel *endDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *selectIntervalLabel;
@property (nonatomic, retain) IBOutlet UILabel *startDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *endLabel;
@property (nonatomic, retain) IBOutlet UILabel *startLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *iconImg;
@property (nonatomic, retain) NSString *exhibitorName;
@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSString *exhibitorId;
@property (nonatomic, retain) NSString *area;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
- (IBAction)endTouchDown:(id)sender;
- (IBAction)endDragEnter:(id)sender;
- (IBAction)endDragout:(id)sender;
- (IBAction)startTouchDown:(id)sender;
- (IBAction)startDragEnter:(id)sender;
- (IBAction)startDragOut:(id)sender;

- (IBAction)selectStartDate:(id)sender;
- (IBAction)selectEndDate:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
-(void) setUIDefault;
//-(void)addEditButton;
-(void) initData;
//-(void)addBackButton;
-(void) setGroupStyleButton;
-(void) clearInputData; 
@end
