//
//  CustomerInfo_Editor.h
//  HealthCare
//
//  Created by Jeff foxconn on 11/11/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerInfo.h"

#import "FcViewController.h"

@interface CustomerInfo_Editor : FcViewController
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource
>
{
    IBOutlet UITableView *detailTable;
    IBOutlet UIScrollView *baseScroll;
    
    //*** Others
    CustomerInfo *user;
    NSMutableDictionary *fieldName_value_map;
    NSMutableArray *fields_value;
    NSMutableArray *fields_name;
    NSInteger currentSelRow;
    
    BOOL isEditing;
}
@property (nonatomic, retain) IBOutlet UITableView *detailTable;
-(void)keyboardWasShown:(NSNotification*)aNotification;
@end
