//
//  DrawEventObject.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/8/15.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventObject.h"

@interface DrawEventObject : NSObject {
    EventObject *eventLeader;
    NSMutableArray *sameTimeEvents;
    NSMutableArray *durationTimeEvents;
}
@property(nonatomic,retain)NSMutableArray *sameTimeEvents,*durationTimeEvents;
@property(nonatomic,retain)EventObject *eventLeader;
@end
