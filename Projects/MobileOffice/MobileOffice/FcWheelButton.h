//
//  FcWheelButton.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/12/5.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcEventButton.h"
@interface FcWheelButton : FcEventButton{
    IBOutlet UIImageView *eventImage;
    IBOutlet UILabel *eventClassName;
}
@property(nonatomic,retain)UIImageView *eventImage;
@property(nonatomic,retain)UILabel *eventClassName;
@end
