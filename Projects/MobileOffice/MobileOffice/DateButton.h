//
//  DateButton.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DateButton : UIButton {
    NSDate *thisDate;
}
@property(nonatomic,retain)NSDate *thisDate;
@end