//
//  ScheduleObject.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleObject : NSObject{
    NSString *startTime,*endtime,*title,*locationPoint,*mapId;
}
@property(nonatomic,retain)NSString *startTime,*endTime,*title,*locationPoint,*mapId;
@end
