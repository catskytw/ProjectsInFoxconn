//
//  PersonalEventListViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalEventInfoViewController.h"
#import "PSListDataObject.h"
#import "FcViewController.h"
@interface PersonalEventListViewController : FcViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    NSMutableArray *sectionArray;
    UITableView *tableview;
    //UIButton *editButton;
    //UIButton *backButton;
    PersonalEventInfoViewController *infoView;
    BOOL isEdit;
}
@property (nonatomic, retain) IBOutlet UITableView *tableview;
-(void)initDataArray;
-(void)setUIDefault;
//-(void)addEditButton;
//-(void)addBackButton;
-(void) deleteEvent:(PSListDataObject *)dao;
@end
