//
//  BusinessCard_list.h
//  OveExpo
//
//  Created by  on 11/9/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcTextField.h"
#import "FcSearchField.h"
#import "FcViewController.h"
@interface BusinessCard_list : FcViewController
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    //*** 名片盒列表
    IBOutlet UITableView *cardListTable;
    //IBOutlet FcTextField *searchTF2;
    //IBOutlet UITextField *searchTF;
    UIButton *backButton; 
    FcSearchField *searchField;
    UIImageView *searchBgImg;
    
    //*** Others
    NSMutableDictionary  *card_company_map;
    NSMutableArray *filterArray;

}
@end
