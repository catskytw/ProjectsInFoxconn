//
//  CompanyListViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcSearchField.h"
#import "FcViewController.h"
@interface CooperatorCategoryList : FcViewController<UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>{
    IBOutlet UITableView *dataTable;
    IBOutlet UIImageView *searchBgImg;
    
    NSMutableArray *dataArray;
    NSMutableArray *filteredArray;
    FcSearchField *searchField;
    BOOL isShowSearchBar;
}
@property (nonatomic, retain) IBOutlet UIImageView *searchBgImg;
@property (nonatomic, retain) IBOutlet UITableView *dataTable;
-(void)filter;
-(void)initDataArray;
-(void)setUIDefault;
@end
