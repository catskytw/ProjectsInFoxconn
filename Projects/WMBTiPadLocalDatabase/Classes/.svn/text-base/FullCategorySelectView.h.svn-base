//
//  FullCategorySelectView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcPopWindows.h"

@interface FullCategorySelectView : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *subTable;
    IBOutlet UILabel *cName;
    
    NSMutableArray *mainCategoryPics;
    NSString *selectedMainCategoryKey;
    NSInteger subCategoryNum;
    FcPopWindows *popWin;
    NSInteger downloadCompletedNum;
    NSInteger selectedIndex;
    IBOutlet UILabel *navibarTitleLabel;
    IBOutlet UILabel *mainCategoryLabel;
    IBOutlet UILabel *subCategoryLabel;
}
@property (nonatomic, retain) UILabel *navibarTitleLabel;
@property (nonatomic, retain) UILabel *mainCategoryLabel;
@property (nonatomic, retain) UILabel *subCategoryLabel;

@property(nonatomic,retain)UITableView *subTable;
@property(nonatomic,retain)UILabel *cName;
@end
