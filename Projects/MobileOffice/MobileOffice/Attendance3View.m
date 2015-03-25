//
//  Attendance3View.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "Attendance3View.h"
#import "DateCaculator.h"
#import "NSFormatterExtend.h"
#import "FcConfig.h"
#import "TravelDataObject.h"
#import "AttendanceModel.h"
#import "TravelTimeObject.h"
#import "NinePatch.h"
#import "UIView_extend.h"
#import "Tools.h"
#import "OverDataObject.h"
#import "OverTimeDataObject.h"
#import "OffDataObject.h"
#import "OffTimeDataObject.h"
@interface Attendance3View(PrivateMethod)
-(void)tuneBackgroundLayout;
-(void)tuneScrollXOffSet:(NSNotification*)noti;
-(void)tuneScrollYOffSet:(NSNotification*)noti;
-(NSString*)overTimeTypeString:(NSString*)typeMarkString;
@end
@implementation Attendance3View
@synthesize contentScrollView;
#pragma mark - TuneLayout
-(void)setInfo{
    [super setInfo];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tuneScrollXOffSet:) name:Attendance3ViewXOffSet object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tuneScrollYOffSet:) name:Attendance3ViewYOffSet object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(drawAttendanceSchedule:) name:DrawAttendanceSchedule object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(drawOffSchedule:) name:DrawOffSchedule object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(drawOverTimeShcedule:) name:DrawOverTimeShcedule object:nil];
}
-(void)setLayout{
    [super setLayout];
    [self tuneBackgroundLayout];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Attendance3ViewXOffSet object:nil];
    [super dealloc];
}
-(void)tuneScrollYOffSet:(NSNotification*)noti{
    NSDictionary *dic=noti.userInfo;
    CGPoint offset=[((NSValue*)[dic valueForKey:@"offset"]) CGPointValue];
    
    [contentScrollView setContentOffset:ccp(0, offset.y)];
}
-(void)tuneScrollXOffSet:(NSNotification*)noti{
    NSDictionary *dic=noti.userInfo;
    CGPoint offset=[((NSValue*)[dic valueForKey:@"offset"]) CGPointValue];
                
    [contentScrollView setContentOffset:ccp(offset.x, 0)];
}
-(void)tuneBackgroundLayout{
    CGFloat _cellWidth=attendanceCellWidth;
    CGFloat _cellHeight=attendanceCellHeight;
    NSInteger row=11;
    [[DateCaculator share] resetSelectedDay];
    NSInteger column=[[DateCaculator share]daysInMonth:[DateCaculator share].selectedDay]+1;
    NSInteger m_height=([AttendanceModel share].tableHeight<_cellHeight*row)?_cellHeight*row:[AttendanceModel share].tableHeight;
    UIImageView *backgrounView=[[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _cellWidth*column, m_height)] autorelease];
    [backgrounView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_step3_cell.png"]]];
    //[contentScrollView setContentSize:CGSizeMake(_cellWidth*column, cellHeight*row)];
    [contentScrollView setContentSize:CGSizeMake(_cellWidth*column, m_height)];
    [contentScrollView addSubview:backgrounView];
    
    NSArray *allDays=[[DateCaculator share] getAllDaysMainCalendar:[DateCaculator share].selectedDay];
    NSInteger count=0;
    NSDateFormatter *formatter=[[NSDateFormatter getFormatterByFormateString:@"c"]retain];
    for(NSDate *m_date in allDays){
        if (![[DateCaculator share]inSameMonth:m_date withDate2:[DateCaculator share].selectedDay]) 
            continue;
        NSInteger order=[[formatter stringFromDate:m_date] intValue];
        if(order==7){ //星期六
            UIImageView *hightlightView=[[UIImageView alloc] initWithFrame:CGRectMake(_cellWidth*count, 0, _cellWidth*2, _cellHeight*row)];
            [hightlightView setBackgroundColor:[UIColor colorWithRed:(CGFloat)175.0f/255.0f green:(CGFloat)183.0f/255.0f blue:(CGFloat)187.0f/255.0f alpha:(CGFloat)25.0f/255.0f]];
            [contentScrollView addSubview:[hightlightView autorelease]];
        }
        count++;
    }
    [formatter release];
}
-(void)drawOverTimeShcedule:(NSNotification*)noti{
    [contentScrollView removeAllSubViews];
    [self tuneBackgroundLayout];
    
    int m_count=0;
    for (OverDataObject *m_obj in [AttendanceModel share].overTimeArray) {
        NSArray *m_timeArray=m_obj.otList;
        for (OverTimeDataObject *m_subObj in m_timeArray) {
            UIImageView *overTimeImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_step3_marked_workout.png"]];
            NSInteger m_order=[[DateCaculator share] numberDayInMonth:m_subObj.overTime]-1; //第幾天
            NSLog(@"第%d天",m_order);
            overTimeImage.frame=fixBlurryRect(CGRectMake((m_order-1)*attendanceCellWidth+1, m_count*attendanceCellHeight, 50, 45));
            
            NSString *hourString=[NSString stringWithFormat:@"%dh",m_subObj.overHours];
            UILabel *hourLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
            [hourLabel setFont:[UIFont fontWithName:DefaultFontName size:17]];
            [hourLabel setBackgroundColor:[UIColor clearColor]];
            [hourLabel setText:hourString];
            hourLabel.textAlignment=UITextAlignmentCenter;
            
            UILabel *m_typeLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 36, 10, 10)];
            [m_typeLabel setFont:[UIFont fontWithName:DefaultFontName size:10]];
            [m_typeLabel setText:[self overTimeTypeString:m_subObj.overType]];
            [m_typeLabel setTextColor:[UIColor whiteColor]];
            [m_typeLabel setBackgroundColor:[UIColor clearColor]];
            
            [overTimeImage addSubview:hourLabel];
            [overTimeImage addSubview:m_typeLabel];
            [contentScrollView addSubview:overTimeImage];
        }
        m_count++;
    }
}
-(void)drawOffSchedule:(NSNotification*)noti{
    [contentScrollView removeAllSubViews];
    [self tuneBackgroundLayout];
    NSInteger ySpace=attendanceCellHeight;
    NSInteger xSpace=attendanceCellWidth;
    NSInteger m_totalCount=0;
    for (OffDataObject *m_Obj in [AttendanceModel share].offArray) {
        for (OffTimeDataObject *m_subObj in m_Obj.offArray) {
                NSInteger x= ([[DateCaculator share] numberDayInMonth:   m_subObj.startDate]-1) * xSpace;
                NSInteger y= m_totalCount*ySpace;
                NSInteger width=([[DateCaculator share] daysBetweenFirstDate:m_subObj.startDate withSecondDate:m_subObj.endDate]+1)*xSpace;
                UIImageView *m_attendanceImage=[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:ccs(width, attendanceCellHeight) forNinePatchNamed:@"bg_step3_marked"]];
                m_attendanceImage.frame=CGRectMake(x, y, width, attendanceCellHeight-3);
                    
                UILabel *m_label=[[UILabel alloc] init];
                [m_label setText:m_subObj.typeString];
                [m_label setTextColor:[UIColor blackColor]];
                [m_label setFont:[UIFont fontWithName:DefaultFontName size:17]];
                [m_label setBackgroundColor:[UIColor clearColor]];
                CGSize fontSize=[Tools estimateStringSize:m_subObj.typeString withFontSize:17.0f withMaxSize:ccs(20000, 17)];
                m_label.frame=fixBlurryRect(CGRectMake(10, 14, fontSize.width, 17));
                [m_attendanceImage addSubview:[m_label autorelease]];
                    
                [contentScrollView addSubview:m_attendanceImage];
        }
        m_totalCount++;
    }
}
-(void)drawAttendanceSchedule:(NSNotification*)noti{
    [contentScrollView removeAllSubViews];
    [self tuneBackgroundLayout];
    NSInteger ySpace=attendanceCellHeight;
    NSInteger xSpace=attendanceCellWidth;
    NSInteger m_totalCount=0;
    for (TravelDataObject *m_Obj in [AttendanceModel share].attendanceArray) {
        if([m_Obj.evtAddrList count]<=0){
            m_totalCount++;
            continue;
        }else{
            for (NSString *key in m_Obj.evtAddrList) {
                for(TravelTimeObject *m_drawObj in m_Obj.travelList){
                    if([m_drawObj.evtAddress isEqualToString:key]){
                        NSInteger x= ([[DateCaculator share] numberDayInMonth:   m_drawObj.startDate]-1) * xSpace;
                        NSInteger y= m_totalCount*ySpace;
                        NSInteger width=([[DateCaculator share] daysBetweenFirstDate:m_drawObj.startDate withSecondDate:m_drawObj.endDate]+1)*xSpace;
                        UIImageView *m_attendanceImage=[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:ccs(width, attendanceCellHeight) forNinePatchNamed:@"bg_step3_marked"]];
                        m_attendanceImage.frame=CGRectMake(x, y, width, attendanceCellHeight-3);
                        
                        UILabel *m_label=[[UILabel alloc] init];
                        m_drawObj.timeStyle=@"出差";
                        [m_label setText:m_drawObj.timeStyle];
                        [m_label setTextColor:[UIColor blackColor]];
                        [m_label setFont:[UIFont fontWithName:DefaultFontName size:17]];
                        [m_label setBackgroundColor:[UIColor clearColor]];
                        CGSize fontSize=[Tools estimateStringSize:m_drawObj.timeStyle withFontSize:17.0f withMaxSize:ccs(20000, 17)];
                        m_label.frame=fixBlurryRect(CGRectMake(10, 14, fontSize.width, 17));
                        [m_attendanceImage addSubview:[m_label autorelease]];
                        
                        [contentScrollView addSubview:m_attendanceImage];
                    }
                }
                m_totalCount++;
            }
        }
    }
}

-(NSString*)overTimeTypeString:(NSString*)typeMarkString{
    NSMutableString *r_String=[NSMutableString stringWithString:typeMarkString];
    [r_String replaceOccurrencesOfString:@"G" withString:@"" options:NSBackwardsSearch range:NSMakeRange(0, [r_String length])];
    return r_String;
}
@end
