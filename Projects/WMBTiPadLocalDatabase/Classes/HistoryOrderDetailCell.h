//
//  HistoryOrderDetailCell.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HistoryOrderDetailCell : UITableViewCell {
    IBOutlet UILabel *productName,*count,*price,*sum;
}
@property(nonatomic,retain)UILabel *productName,*count,*price,*sum;
@end
