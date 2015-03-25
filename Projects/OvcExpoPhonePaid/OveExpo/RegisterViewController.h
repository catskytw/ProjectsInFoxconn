//
//  RegisterViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterAccountTableViewController.h"
#import "RegisterInfoTableViewController.h"
#import "FcPickerController.h"
#import "FcViewController.h"
typedef enum{
    PICKER_SEX  = 0, // 男 1 女 2
    PICKER_COUNTRY,    //國家  
}PICKER_TYPE;
@interface RegisterViewController : FcViewController <UIPickerViewDataSource,UIPickerViewDelegate,FcPickerDelegate>{
    RegisterAccountTableViewController *accountTable;
    RegisterInfoTableViewController *infoTable;
    UIScrollView *scrollView;
    UIImageView *belowbarImg;
    UILabel *navibarTitle;
    UIButton *submitBtn;
    UIButton *cancelBtn;
    UIImageView *naviBarImg;
    UIPickerView *picker;
    NSMutableArray *countryArray;
    NSMutableDictionary *countryDic;
    int pickerType;
    int sexType;
    FcPickerController *fcPicker;

}
-(void) setUIDefault;
-(void) initCountry;
-(void) showPicker;
-(void) checkNeededTextField;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIImageView *naviBarImg;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *belowbarImg;
@property (nonatomic, retain) IBOutlet UILabel *navibarTitle;
@property (nonatomic, retain) IBOutlet UIButton *submitBtn;
@property (nonatomic, retain) IBOutlet UIButton *cancelBtn;
@property (nonatomic, assign) int pickerType;
@property (nonatomic, assign) int sexType;
- (IBAction)cancel:(id)sender;
- (IBAction)submit:(id)sender;
-(void) setScrollViewPoint:(int) y;
-(NSString*)checkNull:(NSString*)sOrigin;
@property (nonatomic, retain) IBOutlet RegisterAccountTableViewController *accountTable;
@property (nonatomic, retain) IBOutlet RegisterInfoTableViewController *infoTable;

@end
