//
//  PersonalScheduleListViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface PersonalScheduleListViewController : FcViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    UITableView *tableview;
    UIButton *editButton;
    UIButton *backButton;
    NSString *timestamp;
}
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain)NSString* timestamp;
-(void)initDataArray;
-(void) setUIDefault;
-(void)addEditButton;
-(void)addBackButton;
@end
