//
//  FcEventButton.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FcEventButton : UIButton {
    NSMutableArray *subEventsId;
    float fc_position; //用來紀錄各種不同情況下sprite的位置
    float fc_scale;
    float fc_angle;
    float fc_radius;
    double fc_radian;
    
    NSString *eventId;
    NSInteger eventType;
}
@property(nonatomic)float fc_position;
@property(nonatomic)float fc_scale,fc_angle,fc_radius;
@property(nonatomic)double fc_radian;
@property(nonatomic)NSInteger eventType;
@property(nonatomic,retain)NSString *eventId;
@property(nonatomic,retain)NSMutableArray *subEventsId;
-(void)insertSubEventId:(NSString*)i_eventId;
-(void)caculateXYFromRadiusAndRadian;
@end
