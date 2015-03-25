//
//  Action.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "EventAction.h"
#import "FcEventButton.h"
#import "FcConfig.h"
#import "DateView.h"
#import "CalendarDAO.h"
#import "DateCaculator.h"
#import "UIView_extend.h"
#import "DateCaculator.h"
#import "FcDrawing.h"
#import "ProjectTool.h"
#import "LocalizationSystem.h"
static EventAction *singletonEventAction=nil;
@implementation EventAction
@synthesize eventsInMonth,radiusOffset;
+(EventAction*)share{
    if(singletonEventAction==nil){
        singletonEventAction=[EventAction new];
    }
    return singletonEventAction;
}
+(void)singletonRelease{
    [singletonEventAction release];
}
-(id)init{
    if((self=[super init])){
        eventsInMonth=[NSMutableArray new];
        radiusOffset=0;
    }
    return self;
}
-(void)dealloc{
    [eventsInMonth release];
    [super dealloc];
}
-(void)drawEvents:(UIView*)eventView{
    [eventView removeAllSubViews];
    for (FcEventButton *event in eventsInMonth) {
        //event.fc_radius=_InnerCircleRadius+_SPACE*event.fc_position; //h
        event.fc_radius=[EventAction share].radiusOffset+_SPACE*event.fc_position;
        [event caculateXYFromRadiusAndRadian];
        [event setBackgroundImage:[self buttonTypeImage:event.eventType] forState:UIControlStateNormal];
        [eventView addSubview:event];
    }
}

-(void)tuneDatesByWheel:(NSMutableArray*)dates withRadian:(double)radian{
    CGFloat lowerBound=M_PI*33.75f/180.0f;
    CGFloat upperBound=M_PI*45.0f/180.0f;

    for (DateView *sprite in dates) {
        sprite.fc_radian+=radian;
        [sprite caculateXYFromRadian];
        [self setDateByWheelFontSize:sprite withVec:CGPointMake(lowerBound, upperBound)];
    }
}
-(void)setDateByWheelFontSize:(DateView*)date withVec:(CGPoint)bound{
    //x位置表示lowerbound, y表示upperbound
    CGFloat lowerBound=bound.x;
    CGFloat upperBound=bound.y;
    CGFloat _tmpRadian=realRadian(date.fc_radian);
    if (_tmpRadian>=lowerBound && _tmpRadian<=upperBound){
        [date.dayLabel setFont:[UIFont fontWithName:DefaultFontName size:28.0f]];
        [date.monthLabel setFont:[UIFont fontWithName:DefaultFontName size:14.0f]];
    }else{
        [date.dayLabel setFont:[UIFont fontWithName:DefaultFontName size:12.0f]];
        [date.monthLabel setFont:[UIFont fontWithName:DefaultFontName size:10.0f]];
    }
}
-(void)tuneEventDistance:(NSInteger)distance{
    for (FcEventButton *sprite in eventsInMonth) {
        sprite.fc_radius=sprite.fc_radius+distance;
        if(sprite.fc_radius<3 || sprite.fc_radius>(_WIDTH+50))
            sprite.hidden=YES;
        else
            sprite.hidden=NO;
        [sprite caculateXYFromRadiusAndRadian];
    }
}
-(void)tuneEventRadian:(double)radian{
    for (FcEventButton *sprite in eventsInMonth) {
        sprite.fc_radian+=radian;
        [sprite caculateXYFromRadiusAndRadian];
    }
}
-(double)caculateRadian:(CGPoint)point1 withPoint2:(CGPoint)point2{
    double radian1=atan((double)point1.y/(double)point1.x);
    double radian2=atan((double)point2.y/(double)point2.x);
    return radian2-radian1;
}
-(void)fetchEventsInWheel:(NSDate*)selectedDate withInitAngle:(CGFloat)angle{
    NSDate *firstDateInMonth=[[DateCaculator share] firstDateInMonth:selectedDate];
    NSDate *lastDateInMonth=[[DateCaculator share]lastDateInMonth:selectedDate];
    
    CalendarDAO *dao=[CalendarDAO share];
    [dao setEventsInMonthView:[dao fetchEventsWithStartDate:firstDateInMonth withEndDate:lastDateInMonth]];
    NSArray *fetch_events=dao.eventsInMainMonthView;
    
    NSDateFormatter *formater=[[NSDateFormatter getFormatterByFormateString:@"HH"] retain];
    NSDateFormatter *formater1=[[NSDateFormatter getFormatterByFormateString:@"mm"]retain];
    //清空events
    [eventsInMonth removeAllObjects];
    EKEvent *_preEvent=nil;
    FcEventButton *_preButton=nil;
    for(EKEvent *_event in fetch_events){
        //若同日同時,就加入該button,並將該button改為multiEvent
        if([[DateCaculator share]isSameDateHour:_preEvent.startDate withCompareDate:_event.startDate]){
            [_preButton insertSubEventId:_event.eventIdentifier];
            _preButton.eventType=FcEventTypeMulti;
            continue;
        }
        FcEventButton *item=[FcEventButton buttonWithType:UIButtonTypeCustom];
        [item insertSubEventId:_event.eventIdentifier];
        item.titleLabel.frame=CGRectMake(item.titleLabel.frame.origin.x+60, item.titleLabel.frame.origin.y, item.titleLabel.frame.size.width, item.titleLabel.frame.size.height);
        [item.titleLabel setText:_event.title];
        
        [item setFrame:CGRectMake(0, 0, 32, 32)];
        [item setBackgroundColor:[UIColor clearColor]];
        item.eventType=[[ProjectTool getEventTypeFromEvent:_event] intValue];
        UILabel *typeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 32, 32, 18)];
        typeLabel.textAlignment=UITextAlignmentCenter;
        [typeLabel setText:[self typeNameString:item.eventType]];
        [typeLabel setFont:[UIFont fontWithName:DefaultFontName size:12.0f]];
        [typeLabel setBackgroundColor:[UIColor clearColor]];
        [item addSubview:[typeLabel autorelease]];
        
        //算出該物件應該在哪個位置
        float pointValue=[[formater1 stringFromDate:_event.startDate] floatValue]/60.0f;
        float position=[[formater stringFromDate:_event.startDate]floatValue]+pointValue;
        item.fc_position=position; // 代表是幾點的事件
        int dayDiff=[[DateCaculator share] daysBetweenFirstDate:firstDateInMonth withSecondDate:_event.startDate];
        item.fc_angle=angle+(dayDiff*AngleSpace);
        item.fc_radian=M_PI*item.fc_angle/180.0;
        item.eventId=_event.eventIdentifier;
        [eventsInMonth addObject:item];
        
        _preEvent=_event;
        _preButton=item;
    }
    [formater release];
    [formater1 release];
}

-(NSString*)eventColorByStyle:(NSInteger)type{
    NSString *r;
    switch (type) {
        case FcEventTypeDefault:
            r=@"event_default";
            break;
        case FcEventTypeBusiness:
            r=@"event_trip";
            break;
        case FcEventTypeLunch:
            r=@"event_lunch";
            break;
        case FcEventTypeMeeting:
            r=@"event_meeting";
            break;
        case FcEventTypePersonal:
            r=@"event_personal";
            break;
        default:
            r=@"event_default";
            break;
    }
    return r;
}
-(NSString*)eventIconNameByStyle:(NSInteger)type{
    NSString *r;
    switch (type) {
        case 1:
            r=@"img_dine_l";
            break;
        case 2:
            r=@"img_meeting_l";
            break;
        case 3:
            r=@"img_personal_l";
            break;
        case 4:
            r=@"img_business_l";
            break;
        default:
            r=@"img_default_l";
            break;
    }
    return r;
}

-(NSArray*)fetchEventsOnDate:(NSDate*)selecteDate{
    NSDate *predate=[[DateCaculator share] getOnlyDate:selecteDate];
    NSDate *nextDate=[NSDate dateWithTimeInterval:86400 sinceDate:predate];
    
    NSMutableArray *_r=[NSMutableArray array];
    for(EKEvent *_thisEvent in [CalendarDAO share].eventsInMainMonthView){
        NSTimeInterval _thisEventIntervale=[_thisEvent.startDate timeIntervalSince1970];
        if(_thisEventIntervale>[nextDate timeIntervalSince1970])
            break;
        else if(_thisEventIntervale<[nextDate timeIntervalSince1970] && _thisEventIntervale>[predate timeIntervalSince1970])
            [_r addObject:_thisEvent];
    }
    return _r;
}

-(BOOL)hasEventsOnDate:(NSDate*)_date{
    if(_date==nil || (NSNull*)_date==[NSNull null]) 
        return NO;
    NSDate *oneDayDate=[[DateCaculator share] getOnlyDate:_date];
    NSTimeInterval firstTime=[oneDayDate timeIntervalSince1970];
    NSTimeInterval secondTime=firstTime+86400;
    for(EKEvent *_thisEvent in [CalendarDAO share].eventsInMainMonthView){
        NSTimeInterval eventStartInterval=[_thisEvent.startDate timeIntervalSince1970];
        if(eventStartInterval<secondTime && eventStartInterval>firstTime)
            return YES;
    }
    return NO;
}
-(NSString*)typeNameString:(NSInteger)eventType{
    NSString *rString=nil;
    switch (eventType) {
        case FcEventTypePersonal:
            rString=AMLocalizedString(@"personal", nil);
            break;
        case FcEventTypeBusiness:
            rString=AMLocalizedString(@"Busniess", nil);
            break;
        case FcEventTypeMeeting:
            rString=AMLocalizedString(@"meeting", nil);
            break;
        case FcEventTypeLunch:
            rString=AMLocalizedString(@"lunch", nil);
            break;
        case FcEventTypeMulti:
            rString=AMLocalizedString(@"multievent", nil);
            break;
        default:
            rString=AMLocalizedString(@"personal", nil);
            break;
    }
    return rString;
}
-(UIImage*)buttonTypeImage:(NSInteger)i_eventType{
    UIImage *myImage;
    switch (i_eventType) {
        case FcEventTypePersonal:
            myImage=[FcDrawing loadUIImage:@"img_personal_s" withType:@"png"];
            break;
        case FcEventTypeBusiness:
            myImage=[FcDrawing loadUIImage:@"img_business_s" withType:@"png"];
            break;
        case FcEventTypeMeeting:
            myImage=[FcDrawing loadUIImage:@"img_meeting_s" withType:@"png"];
            break;
        case FcEventTypeLunch:
            myImage=[FcDrawing loadUIImage:@"img_dine_s" withType:@"png"];
            break;
        case FcEventTypeMulti:
            myImage=[FcDrawing loadUIImage:@"img_multi_s" withType:@"png"];
            break;
        default:
            myImage=[FcDrawing loadUIImage:@"img_default_s" withType:@"png"];
            break;
    }
    return myImage;
}
@end
