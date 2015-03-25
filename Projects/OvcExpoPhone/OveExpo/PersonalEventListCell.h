//
//  PersonalEventListCell.h
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSListDataObject.h"
@interface PersonalEventListCell : UITableViewCell {
    UILabel *titleLabel;
    UILabel *dateLabel;
    UIImageView *checkImg;
    UIImageView *selectedImg;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UIImageView *checkImg;
-(void)setUIDefault;
-(void)setDO:(PSListDataObject*) dao;
@end
