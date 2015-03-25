//
//  RegisterInfoVeiwController.h
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface RegisterRecInfoVeiwController : FcViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    NSString *recordId;
    UILabel *hospitalContentLabel;
    UILabel *timeContentLabel;
    UILabel *AMPMContentLabel;
    UILabel *departContentLabel;
    UILabel *roomContentLabel;
    UILabel *doctorContentLabel;
    UILabel *numberContentLabel;
    UILabel *progressContentLabel;
    NSArray *labelArray;
    NSArray *contentArray;
}

@property (retain, nonatomic) IBOutlet UITableView *dataTable;
@property (nonatomic, retain) NSString* recordId;
@property (nonatomic, retain) UILabel *hospitalContentLabel;
@property (nonatomic, retain) UILabel *timeContentLabel;
@property (nonatomic, retain) UILabel *AMPMContentLabel;
@property (nonatomic, retain) UILabel *departContentLabel;
@property (nonatomic, retain) UILabel *roomContentLabel;
@property (nonatomic, retain) UILabel *doctorContentLabel;
@property (nonatomic, retain) UILabel *numberContentLabel;
@property (nonatomic, retain) UILabel *progressContentLabel;
-(void) initContentField;
-(void)initData;
-(void)setUIDefault;
-(void)setSelectedRowColor:(int)row;
@end
