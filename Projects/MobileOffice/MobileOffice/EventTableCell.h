//
//  EventTableCell.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/8/13.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventTableCell : UITableViewCell {
    IBOutlet UIImageView *eventTypeImage;
    IBOutlet UILabel *time;
    IBOutlet UILabel *eventName;
}
@property(nonatomic,retain)UIImageView *eventTypeImage;
@property(nonatomic,retain)UILabel *time,*eventName;
@end
