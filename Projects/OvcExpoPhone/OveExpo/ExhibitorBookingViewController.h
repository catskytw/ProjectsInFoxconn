//
//  ExhibitorBookingViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateUtilty.h"
#import "FcPickerController.h"
#import "FcViewController.h"
@interface ExhibitorBookingViewController : FcViewController <UIPickerViewDelegate,UIPickerViewDataSource,FcPickerDelegate>{
    UIImageView *seperateImg;
    UIImageView *btnBgImg;
    //UIButton *backButton;
    int mode; //0, 日期 1,時段
    NSMutableArray *sectionArray; //記錄日期
    NSMutableArray *dataArray;//單位為array 依日期放在不同array
    UIPickerView *picker;
    UIImageView *iconImg;
    UILabel *exhibitorLabel;
    UILabel *selectIntervalLabel;
    UIButton *reverseBtn;
    UIButton *intervalPicker;
    IBOutlet UILabel *remarkLabel;
    UIButton *dateBtn;
    UIButton *intervalBtn;
    UILabel *dateLabel;
    UILabel *intervalLabel;
    UILabel *dateDataLabel;
    UILabel *intervalDataLabel;
    NSString *exhibitorName;
    NSString *iconUrl;
    NSString *exhibitorId;
    UIImageView *inputBgImg;
    int currentDateIdx;
    NSString *currentDateId;
    DateUtilty *currentDate;
    FcPickerController *fcPicker;
}
- (IBAction)dateBtnTouchDown:(id)sender;
- (IBAction)dateBtnDragOutside:(id)sender;
- (IBAction)dateBtnDragEnter:(id)sender;
- (IBAction)intervalBtnDragOutside:(id)sender;
- (IBAction)intervalBtnTouchDown:(id)sender;
- (IBAction)intervalBtnDragEnter:(id)sender;

@property (nonatomic, retain) IBOutlet UIImageView *inputBgImg;
@property (nonatomic, retain)NSString *exhibitorName;
@property (nonatomic, retain)NSString *iconUrl;
@property (nonatomic, retain)NSString *exhibitorId;
@property (nonatomic, retain) IBOutlet UILabel *intervalDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateDataLabel;
@property (nonatomic, retain) IBOutlet UILabel *intervalLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UIButton *intervalBtn;
@property (nonatomic, retain) IBOutlet UIButton *dateBtn;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIImageView *iconImg;
@property (nonatomic, retain) IBOutlet UILabel *exhibitorLabel;
@property (nonatomic, retain) IBOutlet UILabel *selectIntervalLabel;
@property (nonatomic, retain) IBOutlet UIButton *reverseBtn;

@property (nonatomic, retain) IBOutlet UIImageView *seperateImg;
@property (nonatomic, retain) IBOutlet UIImageView *btnBgImg;
-(void) setUIDefault;
-(void) initData;
-(void) clearInputData;
//-(void)addBackButton;
-(void) setGroupStyleButton;
- (IBAction)datePicker:(id)sender;
- (IBAction)intervalPicker:(id)sender;
- (IBAction)reverse:(id)sender;

@end
