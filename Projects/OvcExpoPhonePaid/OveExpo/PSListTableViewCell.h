//
//  PSListTableViewCell.h
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSListDataObject.h"
@interface PSListTableViewCell : UITableViewCell{
    UIImageView *bgView;
    UILabel *nameLabel;
    UILabel *startTimeLabel;
    UILabel *endTimeLabel;
    UILabel *bookingStatusLabel;
    UIImageView *typeImg;
    UILabel *locationlabel;
    UIImageView *selectedImg;
}
@property (nonatomic, retain) IBOutlet UILabel *locationlabel;
@property (nonatomic, retain) IBOutlet UIImageView *typeImg;
@property (nonatomic, retain) IBOutlet UILabel *bookingStatusLabel;
@property (nonatomic, retain) IBOutlet UILabel *endTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *startTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *bgView;
-(void)setUIDefault;
-(void)setDO:(PSListDataObject*) dao;

@end
