//
//  ListTableViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//
//deprecated
#import <UIKit/UIKit.h>

@interface ListTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    UIImageView *naviBarImg;
    UILabel *navibarTitle;
    UIButton *cancelBtn;
    UIImageView *belowbarImg;
    NSMutableArray *dataArray;
   
    UITableView *table;
    UIImageView *tableBackgroundImg;
    UIScrollView *scrollView;
    UIImageView *tableCheckImg;
}
- (IBAction)cancel:(id)sender;
-(void) setUIDefault;
-(void)initDataArray;
@property (nonatomic, retain) IBOutlet UIImageView *tableCheckImg;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *tableBackgroundImg;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UIImageView *naviBarImg;
@property (nonatomic, retain) IBOutlet UILabel *navibarTitle;
@property (nonatomic, retain) IBOutlet UIImageView *belowbarImg;
@property (nonatomic, retain) IBOutlet UIButton *cancelBtn;
@end
