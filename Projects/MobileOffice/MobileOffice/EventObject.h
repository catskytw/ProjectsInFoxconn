//
//  EventObject.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/8/13.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventObject : NSObject {
    NSString *identifier;
    NSDate *startDate;
    NSDate *endDate;
    NSString *eventName;
    NSString *eventDesc;
    NSString *eventLocation;
    NSInteger eventType;
    NSInteger repeatType;
}
@property(nonatomic,retain)NSString *identifier;
@property(nonatomic,retain)NSDate *startDate,*endDate;
@property(nonatomic,retain)NSString *eventName,*eventDesc,*eventLocation;
@property(nonatomic)NSInteger eventType,repeatType;
@end
