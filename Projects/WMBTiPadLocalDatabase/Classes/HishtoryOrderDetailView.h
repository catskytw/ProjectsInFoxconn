//
//  HishtoryOrderDetailView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryPattern.h"

@interface HishtoryOrderDetailView : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *orderDetail;
    IBOutlet UILabel *totalPrice;
    IBOutlet UILabel *discount;
    IBOutlet UILabel *payment;
    IBOutlet UILabel *orderNum;
    @private
    NSString *_orderId;
    QueryPattern *_query;
}
@property(nonatomic,retain)UILabel *totalPrice,*disctoun,*payment,*orderNum;
@property(nonatomic,retain)UITableView *orderDetail;
-(id)initWithOrderId:(NSString*)orderId;
@end
