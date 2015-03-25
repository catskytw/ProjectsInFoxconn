//
//  OverTimeCell.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/11/25.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcAttendanceCell.h"
@interface OverTimeCell : FcAttendanceCell{
    IBOutlet UIButton *cancelBtn;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *separator;
}
@property(nonatomic,retain)IBOutlet UIButton *cancelBtn;
@property(nonatomic,retain)IBOutlet UILabel *nameLabel;
@property(nonatomic,retain)IBOutlet UIImageView *separator;
@end
