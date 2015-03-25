//
//  DateCaculator.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "DateCaculator.h"
#import "FcConfig.h"
#import "CalendarDAO.h"
static DateCaculator *singletonDateCaculator=nil;
@implementation DateCaculator
@synthesize _day,_month,_year,attendanceDay;
+(DateCaculator*)share{
    if (singletonDateCaculator==nil) {
        singletonDateCaculator=[DateCaculator new];
    }
    return singletonDateCaculator;
}
+(void)releaseSingleton{
    [singletonDateCaculator release];
}
-(id)init{
    if((self=[super init])){
        attendanceDay = nil;
        selectedDay=nil;
        _day=nil;
        _month=nil;
        _year=nil;
    }
    return self;
}
-(NSDate*)addOneDateFromDate:(NSDate*)_anyDate{
    return [NSDate dateWithTimeIntervalSince1970:[_anyDate timeIntervalSince1970]+86400];
}
-(NSDate*)lastDateInMonth:(NSDate*)_anyDate{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:_anyDate]; // Get necessary date components
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    return [calendar dateFromComponents:comps];
}
-(NSArray*)getAllDaysMainCalendar:(NSDate*)anyDateInMonth{
    NSDate *firstDate=[self firstDateInMonth:anyDateInMonth];
    NSDateFormatter *dayFormatter=[NSDateFormatter getFormatterByFormateString:@"c"];
    
    NSInteger day=[[dayFormatter stringFromDate:firstDate] intValue];
    NSInteger index=day-1;
    
    NSMutableArray *datesInMonth=[NSMutableArray arrayWithCapacity:42];
    for (int i=0; i<42; i++) {
        [datesInMonth addObject:[NSNull null]];
    }

    [datesInMonth replaceObjectAtIndex:index withObject:firstDate];
    //補足之前的日期
    NSDate *preDate=firstDate;
    for (int i=index-1; i>=0; i--) {
        preDate=[NSDate dateWithTimeInterval:0-86400 sinceDate:preDate];
        [datesInMonth replaceObjectAtIndex:i withObject:preDate];
    }

    //補足之後的日期
    preDate=firstDate;
    NSDateFormatter *lastDayInWeekFormat=[NSDateFormatter getFormatterByFormateString:@"c"];
    for (int i=index+1; i< 42 ; i++) {
        preDate=[NSDate dateWithTimeInterval:86400 sinceDate:preDate];
        
        if (![[DateCaculator share] inSameMonth:firstDate withDate2:preDate] && ([[lastDayInWeekFormat stringFromDate:preDate] intValue]== 1 || [[lastDayInWeekFormat stringFromDate:preDate] intValue]==2) ) {
            break;
        }
        [datesInMonth replaceObjectAtIndex:i withObject:preDate];
    }
    return [NSArray arrayWithArray:datesInMonth];
}

-(NSDate*)getOnlyDate:(NSDate*)_date{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"yyyy/MM/dd"];
    return [formatter dateFromString:[formatter stringFromDate:_date]];
}
-(BOOL)isSameDate:(NSDate*)baseDate withCompareDate:(NSDate*)compareDate{
    return ([self daysBetweenFirstDate:baseDate withSecondDate:compareDate]==0)?YES:NO;
}
-(BOOL)inSameMonth:(NSDate*)date1 withDate2:(NSDate*)date2{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"MM"];
    BOOL r=([[formatter stringFromDate:date1] isEqualToString:[formatter stringFromDate:date2]])?YES:NO;
    return r;
}
-(NSInteger)numberDayInMonth:(NSDate*)_anyDate{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"d"];
    NSString *orderDay=[formatter stringFromDate:_anyDate];
    return [orderDay intValue];
}
-(BOOL)isSameDateHour:(NSDate*)baseDate withCompareDate:(NSDate*)compareDate{
    NSTimeInterval base=[baseDate timeIntervalSince1970];
    NSTimeInterval compare=[compareDate timeIntervalSince1970];
    return ((compare-base)<3600)?YES:NO;
}
//NSDate *selectedDay;
-(NSDate *) selectedDay
{
    return selectedDay;
}

- (void) setSelectedDay: (NSDate *) newSelectedDay
{
    if(selectedDay!=nil){
        [selectedDay release];
        selectedDay=nil;
    }
    selectedDay = [newSelectedDay retain];
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"yyyy"];
    if (_year!=nil){
        [_year release];
        _year=nil;
    }
    _year=[[formatter stringFromDate:selectedDay] retain];
    
    formatter=[NSDateFormatter getFormatterByFormateString:@"LLL"];
    if (_month!=nil){
        [_month release];
        _month=nil;
    }
    _month=[[formatter stringFromDate:selectedDay] retain];
    
    formatter=[NSDateFormatter getFormatterByFormateString:@"d"];
    if (_day!=nil){
        [_day release];
        _day=nil;
    }
    _day=[[formatter stringFromDate:selectedDay] retain];
}
-(void)resetSelectedDay{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"yyyyLLLd"];
    if(selectedDay!=nil){
        [selectedDay release];
        selectedDay=nil;
    }
    selectedDay=[[formatter dateFromString:[NSString stringWithFormat:@"%@%@%@",_year,_month,_day]]retain];
}
-(int)daysBetweenFirstDate:(NSDate*)firstDate withSecondDate:(NSDate*)secondDate{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"yyyyMMdd"];
    NSDate *_first=[formatter dateFromString:[formatter stringFromDate:firstDate]];
    NSDate *_second=[formatter dateFromString:[formatter stringFromDate:secondDate]];
    double time=[_second timeIntervalSinceDate:_first];
    return ceil(time/86400);
}
-(NSDate*)dateBeforeSecs:(NSDate*)baseDate withSecs:(NSInteger)secs{
    NSTimeInterval interval=[baseDate timeIntervalSince1970]-secs;
    return [NSDate dateWithTimeIntervalSince1970:interval];
}
-(NSDate*)firstDateInMonth:(NSDate*)_anyDate{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSLog(@"fistDate for anydate:%@",_anyDate);
    NSDateComponents *comps=[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:_anyDate];
    [comps setDay:1];
    return [calendar dateFromComponents:comps];
}

-(NSInteger)daysInMonth:(NSDate*)_anyDate{
    NSDate *_firstDate=[self firstDateInMonth:_anyDate];
    NSDate *_lastDate=[self lastDateInMonth:_anyDate];
    return [self daysBetweenFirstDate:_firstDate withSecondDate:_lastDate];
}
-(NSInteger)monthInYear:(NSDate*)_anyDate{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"M"];
    return [[formatter stringFromDate:_anyDate] intValue];
}

@end
