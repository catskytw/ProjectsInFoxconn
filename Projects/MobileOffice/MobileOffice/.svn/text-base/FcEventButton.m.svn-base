//
//  FcEventButton.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcEventButton.h"
#import "FcConfig.h"

@implementation FcEventButton
@synthesize fc_position,fc_scale,fc_angle,fc_radian,fc_radius,eventId,eventType,subEventsId;
-(void)dealloc{
    [subEventsId release];
    [super dealloc];
}
-(void)insertSubEventId:(NSString*)i_eventId{
    if (subEventsId==nil) {
        subEventsId=[[NSMutableArray array] retain];
    }
    [subEventsId addObject:i_eventId];
}
-(void)caculateXYFromRadiusAndRadian{
    CGPoint loc=CGPointMake(sin((double)self.fc_radian)*self.fc_radius,cos((double)self.fc_radian)*self.fc_radius);
    CGPoint real_loc=ccp(loc.x, _WIDTH-loc.y);
    self.center=real_loc;
}
@end
