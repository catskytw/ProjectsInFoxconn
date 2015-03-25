//
//  OrderDetailViewController.h
//  WMBT
//
//  Created by link on 2011/6/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrderDetailViewController: UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    UILabel *storeLabel;
    UILabel *totalNameLabel;
    UILabel *discountNameLabel;
    UILabel *accountableNameLabel;
    UILabel *totalLabel;
    UILabel *discountLabel;
    UILabel *accountableLabel;
    UITableView *orderDetailTable;
    NSMutableArray *orderArray;
    CGFloat cellHeight;
    NSString *orderId;
    NSString *orderNumber;
}
@property (nonatomic, retain) IBOutlet UILabel *storeLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *discountNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *accountableNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalLabel;
@property (nonatomic, retain) IBOutlet UILabel *discountLabel;
@property (nonatomic, retain) IBOutlet UILabel *accountableLabel;
@property (nonatomic, retain) IBOutlet UITableView *orderDetailTable;
@property (nonatomic, retain) NSString *orderId;
@property (nonatomic, retain) NSString *orderNumber;
-(void)setDefaultUI;
-(void)loadData;
-(UITableViewCell *)getOrderDetailCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;
@end
