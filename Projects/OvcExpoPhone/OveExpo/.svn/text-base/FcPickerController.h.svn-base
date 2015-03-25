//
//  FcPickerController.h
//  OveExpo
//
//  Created by Chang Link on 11/10/7.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define pickerHeightDif 93
@protocol FcPickerDelegate <NSObject>
@required
- (void) pickerSubmit;
@optional
- (void) pickerCancel;
@end
@interface FcPickerController : UIViewController {
    UIPickerView *picker;
    UIButton *cancelBtn;
    UIImageView *titleImg;
    UIButton *submitBtn;
    BOOL bShow;
    BOOL isDate;
    UIDatePicker *datePicker;
    id <FcPickerDelegate> delegate;
    id <UIPickerViewDelegate> pickerdelegate;
    id <UIPickerViewDataSource> dataSource;
}

- (IBAction)cancel:(id)sender;
- (IBAction)submit:(id)sender;

-(void)isDatePicker;
@property (nonatomic, assign) id <FcPickerDelegate> delegate;
@property (nonatomic, assign) id <UIPickerViewDelegate> pickerdelegate;
@property (nonatomic, assign) id <UIPickerViewDataSource> dataSource;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIButton *submitBtn;
@property (nonatomic, retain) IBOutlet UIImageView *titleImg;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIButton *cancelBtn;
@property (assign) BOOL bShow;
-(void)slideUp:(BOOL)bUp;
@end

