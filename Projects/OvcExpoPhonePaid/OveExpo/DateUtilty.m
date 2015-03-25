//
//  DateUtilty.m
//  OveExpo
//
//  Created by Chang Link on 11/9/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "DateUtilty.h"

@implementation DateUtilty
@synthesize startTime,endTime,note,dateId;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+(NSString*) dateString:(NSString*)sTime{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSTimeInterval _date_double = [sTime doubleValue]/1000;
    NSDate *_date=[NSDate dateWithTimeIntervalSince1970:_date_double];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    return [dateFormatter stringFromDate:_date];
}
+(NSString*) timeString:(NSString*)sTime{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSTimeInterval _date_double = [sTime doubleValue]/1000;
    NSDate *_date=[NSDate dateWithTimeIntervalSince1970:_date_double];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:_date];
}
+(NSString*) dateStringFull:(NSString*)sTime{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSTimeInterval _date_double = [sTime doubleValue]/1000;
    NSDate *_date=[NSDate dateWithTimeIntervalSince1970:_date_double];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    return [dateFormatter stringFromDate:_date];
}
+(NSString*) dateStringFull:(NSString*)sTime withFormat:(NSString*)sFormate{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSTimeInterval _date_double = [sTime doubleValue]/1000;
    NSDate *_date=[NSDate dateWithTimeIntervalSince1970:_date_double];
    
    [dateFormatter setDateFormat:sFormate];
    
    return [dateFormatter stringFromDate:_date];
}

+(NSString*) timeSectionString:(NSString*)startTime withEndTime:(NSString*)endTime{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateStyle:kCFDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setLocale:[NSLocale systemLocale]];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/1000];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]/1000];
    //[dateFormatter setDateFormat:@"HH:mm"];
    
    return [NSString stringWithFormat:@"%@ - %@",[dateFormatter stringFromDate:startDate], [dateFormatter stringFromDate:endDate]];
    
}
+(NSString*) timeSectionStringFull:(NSString*)startTime withEndTime:(NSString*)endTime{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/1000];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]/1000];
    //[dateFormatter setDateFormat:@"yyyy/MM/dd h:mm"];
    
    return [NSString stringWithFormat:@"%@ - %@",[dateFormatter stringFromDate:startDate], [dateFormatter stringFromDate:endDate]];
}
+(NSString*) getDate:(NSString*)sTime{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[sTime doubleValue]/1000];
    //[dateFormatter setDateFormat:@"yyyyMMdd"];
    
    return [dateFormatter stringFromDate:date];
}
-(NSString*) timeSectionString{
    return [DateUtilty timeSectionString:startTime withEndTime:endTime];
}
-(NSString*) dateString{
    return [DateUtilty dateString:startTime];
}
-(BOOL) isEqualeToDate:(NSString *)Time{
    return [[DateUtilty getDate:startTime] isEqualToString:[DateUtilty getDate:Time]];
}
@end
