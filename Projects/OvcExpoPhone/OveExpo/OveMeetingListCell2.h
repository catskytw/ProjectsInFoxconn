//
//  OveMeetingListCell2.h
//  OveExpo
//
//  Created by  on 11/9/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSListDataObject1.h"
@interface OveMeetingListCell2 : UITableViewCell{
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
@property BOOL bookingStatus;
-(void)setUIDefault;
-(void)setDO:(PSListDataObject1*) dao;

@end
