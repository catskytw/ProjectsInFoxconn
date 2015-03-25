//
//  ExhibitorAddBookingListViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitorAddBookingViewController.h"
#import "FcViewController.h"
@interface ExhibitorAddBookingListViewController : FcViewController <UITableViewDataSource,UITableViewDelegate>{
    UITableView *dataTable;
    NSMutableArray *sectionArray;
    NSMutableArray *dataArray;
    ExhibitorAddBookingViewController *bookingViewController;
    BOOL isEdit;
    //UIButton *editButton;
    //UIButton *addButton;
    UITableViewCellEditingStyle currentEditingStyle;
    
    UIButton *editButton;
}

@property (nonatomic, retain) IBOutlet UITableView *dataTable;
-(void)initData;
-(void)setUIDefault;
//-(void)addAddButton;
//-(void)addEditButton;
//-(void)removeNaviBtn;
@end
