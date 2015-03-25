//
//  DateCaculator.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateCaculator : NSObject {
    NSDate *selectedDay;
    NSDate *attendanceDay;
    NSString *_day;//for selectedDay
    NSString *_month;//for selectedDay
    NSString *_year;//for selectedDay
}
//@property(nonatomic,retain)NSDate *selectedDay;
@property(nonatomic,retain)NSString *_day,*_month,*_year;
@property(nonatomic,retain)NSDate *attendanceDay;
+(DateCaculator*)share;
+(void)releaseSingleton;
/*
 給予包含該日應顯示於畫面上之日期陣列
 @param:任一日(通常給今天)
 @return:all days which should appear in this CalendarView
 */
-(NSArray*)getAllDaysMainCalendar:(NSDate*)anyDateInMonth;
/*
 僅取得日期,該日之零點零分零秒
 */
-(NSDate*)getOnlyDate:(NSDate*)_date;
//兩個nsdate是否在同一個月 
-(BOOL)inSameMonth:(NSDate*)date1 withDate2:(NSDate*)date2;
//取得該月之第一日
-(NSDate*)firstDateInMonth:(NSDate*)_anyDate;
//取得該月之最後一日
-(NSDate*)lastDateInMonth:(NSDate*)_anyDate;
//對任意一天增加一日
-(NSDate*)addOneDateFromDate:(NSDate*)_anyDate;
//重新製作selected day
-(void)resetSelectedDay;
//兩日相差之天數
-(int)daysBetweenFirstDate:(NSDate*)firstDate withSecondDate:(NSDate*)secondDate;
//是否在同一天
-(BOOL)isSameDate:(NSDate*)baseDate withCompareDate:(NSDate*)compareDate;
//是否在同天同時
-(BOOL)isSameDateHour:(NSDate*)baseDate withCompareDate:(NSDate*)compareDate;
//baseDate的前幾秒之日期
-(NSDate*)dateBeforeSecs:(NSDate*)baseDate withSecs:(NSInteger)secs;
//任何日期所屬之月份天數
-(NSInteger)daysInMonth:(NSDate*)_anyDate;
//該日為當月的第幾日
-(NSInteger)numberDayInMonth:(NSDate*)_anyDate;
-(NSInteger)monthInYear:(NSDate*)_anyDate;
//getter setter
-(NSDate *) selectedDay;
- (void) setSelectedDay: (NSDate *) newSelectedDay;
@end