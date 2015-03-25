//
//  ProjectTool.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/8/17.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "FcConfig.h"
@interface ProjectTool : NSObject {
    
}
+(CGContextRef)createBitmapContext:(NSInteger)pixelsWide withHeight:(NSInteger)pixelsHigh;
+(NSTimeInterval)parseTimeIntervalFromJSONFormat:(NSString*)fcJsonFormat;
+(EKRecurrenceRule*)recurrenceRuleForType:(NSInteger)type;
+(NSInteger)parseRepeatIndex:(EKRecurrenceRule*)recurrenceRule;
+(NSString*)getLocationFromEvent:(EKEvent*)event;
+(NSString*)getEventTypeFromEvent:(EKEvent*)event;
+(FcEventType)transEventTypeIndexToEventType:(NSInteger)i_typeIndex;
+(NSInteger)parseEventTypeIndex:(FcEventType)i_eventType;
+(NSString*)getEventTypeFromEventForJson:(EKEvent*)event;
+(NSString*) getTimestamp:(NSString*)timestampString withKey:(NSString*) skey;
@end
