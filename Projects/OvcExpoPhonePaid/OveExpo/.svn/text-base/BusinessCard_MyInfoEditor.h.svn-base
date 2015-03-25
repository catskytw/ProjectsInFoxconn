//
//  BusinessCard_MyInfoEditor.h
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BusinessCard.h"
#import "BusinessCard_Cell2.h"
#import "FcViewController.h"
//#import "NSURLConnection.h"

@interface BusinessCard_MyInfoEditor : FcViewController
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIImagePickerControllerDelegate,
UIPickerViewDataSource,
UIPickerViewDelegate
>
{
    //*** 個人名片資料
    IBOutlet UIScrollView *baseScroll;
    IBOutlet UIImageView *photo_img;//大頭照
    IBOutlet UIButton *photo_but;//大頭照,button
    IBOutlet UIImageView *separate1_img;//分隔線
    IBOutlet UITableView *detailTable;
    UIButton *backButton;
    UIButton *okBut;
    
    //FcPickerController *picker;
    
    //FC Picker View
    IBOutlet UIView *pickerBaseView;
    IBOutlet UIButton *cancelBtn;
    IBOutlet UIImageView *titleImg;
    IBOutlet UIButton *submitBtn;
    IBOutlet UIPickerView *picker;
    
    //*** Next view
    UIImagePickerController *imagePicker;    
    
    //*** Others
    BusinessCard *card;
    NSMutableDictionary *card_table_map;
    NSMutableDictionary *field_row_map;
    NSMutableArray *card_fields_value;
    NSMutableArray *card_fields_name;
    NSInteger currentSelRow;
    NSString *currentSelTitle;
    BusinessCard_Cell2 *currentSelCell;
    CGSize titleMaxSize;
    NSString *cardId;
    NSMutableDictionary *countryDic;
    NSInteger currentPickerRow;
    NSData *upload_photo;
    NSURLConnection *connect;//上傳大頭貼的connection
}
-(IBAction)_editPhoto:(id)sender;
-(IBAction)pickerSubmit:(id)sender;
-(IBAction)pickerCancel:(id)sender;
-(void)keyboardWasShown:(NSNotification*)aNotification;
@end
