//
//  BusinessCard_MyInfoEditor.h
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCard.h"
#import "BusinessCard_Cell2.h"
#import "FcViewController.h"
@interface BusinessCard_box : FcViewController
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIImagePickerControllerDelegate
>
{
    //*** 個人名片資料
    IBOutlet UIScrollView *baseScroll;
    IBOutlet UIImageView *photo_img;//大頭照
    IBOutlet UIButton *photo_but;//大頭照,button
    IBOutlet UIImageView *separate1_img;//分隔線
    IBOutlet UITableView *detailTable;
    UIButton *backButton;
    
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
}

-(id) initWithCardId:(NSString *)_cardId;
-(IBAction)_editPhoto:(id)sender;
@end
