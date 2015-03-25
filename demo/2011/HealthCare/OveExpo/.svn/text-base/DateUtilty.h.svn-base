//
//  DateUtilty.h
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtilty : NSObject{
    
    NSString *startTime;
    NSString *endTime;
    NSString *note;
    NSString *dateId;
}
@property (nonatomic, retain)NSString *startTime;
@property (nonatomic, retain)NSString *endTime;
@property (nonatomic, retain)NSString *note;
@property (nonatomic, retain)NSString *dateId;
//input timestamp
+(NSString*) dateString:(NSString*)sTime;
+(NSString*) dateStringFull:(NSString*)sTime;
+(NSString*) timeString:(NSString*)sTime;
+(NSString*) dateStringFull:(NSString*)sTime withFormat:(NSString*)sFormate;
+(NSString*) timeSectionString:(NSString*)startTime withEndTime:(NSString*)endTime;
+(NSString*) timeSectionStringFull:(NSString*)startTime withEndTime:(NSString*)endTime;
+(NSString*) getDate:(NSString*)sTime;
-(NSString*) timeSectionString;
-(NSString*) dateString;
-(BOOL) isEqualeToDate:(NSString *)Time;
@end
