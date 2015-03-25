//
//  MobileOfficeViewController.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MobileOfficeViewController.h"
#import "WheelDisk.h"
#import "EventAction.h"
#import "FcConfig.h"
#import "EventTableCell.h"
#import "DrawEventObject.h"
#import "NinePatch.h"
#import "UIView_extend.h"
#import "EventObject.h"
#import "DateButton.h"
#import "DateCaculator.h"
#import "LocalizationSystem.h"
#import "FcDrawing.h"
#import "FcEventButton.h"
#import "DateView.h"
#import "WEPopoverController.h"
#import "EventEditViewController.h"
#import "EventContent.h"
#import "CalendarDAO.h"
#import "Tools.h"
#import "FcConfig.h"
#import "ProjectTool.h"
#import "FcUIComponent.h"
#import "AttendanceViewController.h"
#import "SignOffViewController.h"
#define CellHeight 43.0f
#define TableWidth 284
#define HalfHourSec 1800
#define EVENT_INITX 57
#define EventWidth 225

@interface MobileOfficeViewController(PrivateMethod)
-(void)initTimeMeter;
-(void)tuneWheelEvent:(CGFloat)m_offset;
-(CGFloat)caculateEventHeight:(EKEvent*)_event;
-(CGFloat)caculateEventY:(EKEvent*)_event;
-(void)drawEventOnTable:(CGFloat)xPosition withWidth:(CGFloat)width withDrawEvent:(DrawEventObject*)_drawEvent;
-(void)proceedDrawEvent;
-(void)drawEventSqure:(NSArray*)events;
-(void)setDateForLabels;
-(void)constructSideCalerdarView;
-(void)initSideCalendarView;
-(void)constructLeftSideCalerdarView;
-(void)constructRightSideCalerdarView;
-(IBAction)yearSelectAction:(id)sender;
-(void)setPopover;
-(void)initDatesByWheel;
-(void)initMics;
-(void)removeAllOnTodayEvents;
@end
@implementation MobileOfficeViewController
@synthesize syncEventBtn;
@synthesize v_timeMeter,h_timeMeter,wheelImage,eventView,todayEventTable,todayEventTitle,backgroundSuperView,addEventBtn;
- (void)dealloc
{
    [syncEventBtn release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    [TUNinePatchCache flushCache];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self deleteEvents];
    //[self addRandomEvent];
    _tmpEvents=[[NSMutableArray array] retain];
    datesByWheelArray=[[NSMutableArray array]retain];
    
    
    //init timermeter
    [self initTimeMeter];
    //do wheel
    diff=0;
    xOffset=0;
    yOffset=0;
    CGImageRef wheelImageRef=[[WheelDisk share]performWholeWheel:diff];
    [wheelImage setImage:[UIImage imageWithCGImage:wheelImageRef]];
    CGImageRelease(wheelImageRef);
    //init rotate pan gesture
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [eventView addGestureRecognizer:panGesture];
    [panGesture release];
    panGesture=nil;
    
    //init scroll pan gesture
    panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollXOffSet:)];
    [h_timeMeter addGestureRecognizer:panGesture];
    [panGesture release];
    panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(scrollYOffSet:)];
    [v_timeMeter addGestureRecognizer:panGesture];
    [panGesture release];
    
    
    //today events for drawing
    _eventsForDrawing=[[NSMutableArray array] retain];
#ifdef TESTDATA
    [EventAction share].events=[TestObject testEvents];
    [[EventAction share] drawEvents:eventView];
    [self drawEventSqure:[TestObject eventList]];
#endif
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawTodayEvents:) name:DrawTodayEvents object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawWheelEvents:) name:DrawWheelEvents object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:DrawWheelEvents object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:DrawTodayEvents object:nil];

    //sync from server
    if (syncEvent==nil) {
        syncEvent = [SyncAction new];
    }
    [syncEvent  fetchNewEventsFromServer];
    
    [self initMics];
}

-(void)initMics{
    UIImage *normalImage=[TUNinePatchCache imageOfSize:addEventBtn.frame.size forNinePatchNamed:@"btn_title"];
    UIImage *selectedImage=[TUNinePatchCache imageOfSize:addEventBtn.frame.size forNinePatchNamed:@"btn_title_i"];
    [addEventBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [addEventBtn setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    
    UIImageView *addImage=[[[UIImageView alloc] initWithImage:[FcDrawing loadUIImage:@"ic_add" withType:@"png"]] autorelease];
    addImage.center=CGPointMake(addEventBtn.frame.size.width/2.0f, addEventBtn.frame.size.height/2.0f);
    [addEventBtn addSubview:addImage];
    
    
    [syncEventBtn setBackgroundImage:[TUNinePatchCache imageOfSize:syncEventBtn.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [syncEventBtn setBackgroundImage:[TUNinePatchCache imageOfSize:syncEventBtn.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    //UIImageView *refreshImage=[[[UIImageView alloc] initWithImage:[FcDrawing loadUIImage:@"ic_agree" withType:@"png"]] autorelease];
    //refreshImage.center=CGPointMake(syncEventBtn.frame.size.width/2.0f, syncEventBtn.frame.size.height/2.0f);
    //[syncEventBtn addSubview:refreshImage];
}
-(void)setPopover{
    for(FcEventButton *btn in [EventAction share].eventsInMonth){
        [btn addTarget:self action:@selector(showPopoverAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(IBAction)squrePopoverAction:(id)sender{
    FcEventButton *btn=(FcEventButton*)sender;
    EventContent *eventContent=[[EventContent alloc] initWithEventsId:btn.subEventsId];
    WEPopoverController *pop=[[WEPopoverController alloc]initWithContentViewController:eventContent];
    eventContent.parentView=self.view;
    eventContent.parentPopView=pop;
    CGRect _rect=[self.view convertRect:btn.frame fromView:todayEventTable];
    [pop setPopoverContentSize:eventContent.view.frame.size];
    [pop presentPopoverFromRect:_rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
     
}
-(IBAction)showPopoverAction:(id)sender{
    FcEventButton *btn=(FcEventButton*)sender;
    NSLog(@"subEvents %i",[btn.subEventsId count]);
    EventContent *eventContent=[[EventContent alloc] initWithEventsId:btn.subEventsId];
    WEPopoverController *pop=[[WEPopoverController alloc]initWithContentViewController:eventContent];
    eventContent.parentView=self.view;
    eventContent.parentPopView=pop;
    [pop setPopoverContentSize:eventContent.view.frame.size];
    [pop presentPopoverFromRect:ccRectShift(btn.frame,TABLE_ORIGIN_POINT) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    [popoverController release];
}
- (void)viewDidUnload
{
    [self setSyncEventBtn:nil];
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DrawTodayEvents object:nil];
    
    [datesByWheelArray removeAllObjects];
    [datesByWheelArray release];

    
    if (syncEvent) {
        [syncEvent release];
        syncEvent = nil;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)?YES:NO;
}

#pragma mark - Position&Color
-(void)initDatesByWheel{
    for(DateView *_tmpView in datesByWheelArray){
        [_tmpView.view removeFromSuperview];
    }
    [datesByWheelArray removeAllObjects];
    NSDate *_selectedDate;
    NSDate* firstDate=[[DateCaculator share] firstDateInMonth:[DateCaculator share].selectedDay];
    NSDate* lastDate=[[DateCaculator share]lastDateInMonth:[DateCaculator share].selectedDay];
    _selectedDate=firstDate;
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"dd"];
    NSDateFormatter *formatter2=[NSDateFormatter getFormatterByFormateString:@"ccc"];
    int count=0;
    do {
        DateView *thisView=[[[DateView alloc] initWithDay:[formatter stringFromDate:_selectedDate] withMonth:[formatter2 stringFromDate:_selectedDate]] autorelease];
        CGFloat fc_angle=0+(count*AngleSpace);
        thisView.fc_radian=M_PI*fc_angle/180.0;
        [datesByWheelArray addObject:thisView];
        _selectedDate=[[DateCaculator share] addOneDateFromDate:_selectedDate];
        count++;
    } while ([_selectedDate timeIntervalSince1970]<=[lastDate timeIntervalSince1970]);
    
    for(DateView *thisView in datesByWheelArray){
        [thisView caculateXYFromRadian];
        [self.backgroundSuperView addSubview:thisView.view];
    }
    [[EventAction share]tuneDatesByWheel:datesByWheelArray withRadian:0];
}
-(void)tuneWheelEvent:(CGFloat)m_offset{
    [EventAction share].radiusOffset+=m_offset;
    CGImageRef wheelRef=[[WheelDisk share]performWholeWheel:m_offset];
    [wheelImage setImage:[UIImage imageWithCGImage:wheelRef]];
    CGImageRelease(wheelRef);
    [[EventAction share]tuneEventDistance:m_offset];
}

-(void)initTimeMeter{
    UIImageView *timer1=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time_1.png"]] autorelease];
    
    
    UIImageView *timer2=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time_2.png"]] autorelease];
    [h_timeMeter addSubview:timer1];
    [v_timeMeter addSubview:timer2];
    [h_timeMeter setContentSize:CGSizeMake(1425, 50)];
    [v_timeMeter setContentSize:CGSizeMake(50, 1425)];
    h_timeMeter.tag=1; //tag 1為水平,2為垂直
    v_timeMeter.tag=2;
    
    xOffset=45;
    yOffset=788;
    
    [v_timeMeter setContentOffset:CGPointMake(0, yOffset) animated:NO];
    [h_timeMeter setContentOffset:CGPointMake(xOffset, 0) animated:NO];
}

#pragma mark - PanGestureDelegate
-(IBAction)scrollXOffSet:(UIPanGestureRecognizer*)sender{
    if(sender.state == UIGestureRecognizerStateBegan)
        xOffset=0.0f;
    CGPoint translate = [sender translationInView:self.view];
    if (xOffset==translate.x) return;
    
    diff=xOffset-translate.x;
    xOffset=translate.x;
    if ((h_timeMeter.contentOffset.x+diff)<-63 || (h_timeMeter.contentOffset.x+diff)>850)
        return;
    [h_timeMeter setContentOffset:CGPointMake(h_timeMeter.contentOffset.x+diff, 0)];
    [v_timeMeter setContentOffset:CGPointMake(0, v_timeMeter.contentOffset.y-diff)];
    [self tuneWheelEvent:-diff];
}

-(IBAction)scrollYOffSet:(UIPanGestureRecognizer*)sender{
    if(sender.state == UIGestureRecognizerStateBegan)
        yOffset=0.0f;
    CGPoint translate = [sender translationInView:self.view];
    if (yOffset==translate.y) return;
    
    diff=translate.y-yOffset;
    yOffset=translate.y;
    if ((h_timeMeter.contentOffset.x+diff)<-63 || (h_timeMeter.contentOffset.x+diff)>850)
        return;
    [h_timeMeter setContentOffset:CGPointMake(h_timeMeter.contentOffset.x+diff, 0)];
    [v_timeMeter setContentOffset:CGPointMake(0, v_timeMeter.contentOffset.y-diff)];
    [self tuneWheelEvent:-diff];
}
- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translate = [sender translationInView:self.view];
    if(CGPointEqualToPoint(translate, _tmpPoint))
        return;
    if (sender.state==UIGestureRecognizerStateBegan)
        _tmpPoint=CGPointZero;
    CGPoint originPoint=ccp(_WIDTH,0);
    CGPoint subPoint1=ccpSub(_tmpPoint, originPoint);
    CGPoint subPoint2=ccpSub(translate, originPoint);
    
    double radian=[[EventAction share]caculateRadian:subPoint2 withPoint2:subPoint1];
    if (radian!=radian) //NaN != NaN
        return;
    [[EventAction share]tuneEventRadian:radian];
    [[EventAction share]tuneDatesByWheel:datesByWheelArray withRadian:radian];
    _tmpPoint=translate;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventTableCell *cell=(EventTableCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"EventTableCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[EventTableCell class]]){
                cell=(EventTableCell*)currentObject;
                break;
            }
        }
    }
    NSInteger hour=[indexPath row];
    NSString *timeString=[NSString stringWithFormat:@"%i %@",(hour>12)?hour-12:hour,(hour>12)?@"PM":@"AM"];                          
    [cell.time setText:timeString];
    return cell;
}

#pragma mark - Today Event Drawing
-(void)drawEventSqure:(NSArray*)events{
    NSInteger width=EventWidth;
    NSInteger shiftSpace=5; //shift值預設為5
    [_tmpEvents removeAllObjects];
    [_eventsForDrawing removeAllObjects];
    [self removeAllOnTodayEvents];
    
    [_tmpEvents addObjectsFromArray:events];

    [self proceedDrawEvent];
    
    for(DrawEventObject *thisDrawEvent in _eventsForDrawing){
        NSInteger shiftNum=[thisDrawEvent.durationTimeEvents count];
        NSInteger eventWidth=width-(shiftNum*shiftSpace);
        //drawing main event and sametime event together
        [self drawEventOnTable:EVENT_INITX withWidth:eventWidth withDrawEvent:thisDrawEvent];
        NSInteger counter=1;
        NSInteger durationCount=[thisDrawEvent.durationTimeEvents count];
        for (id durationEvent in thisDrawEvent.durationTimeEvents) {
            if ([durationEvent isKindOfClass:[DrawEventObject class]]) {
                [self drawEventOnTable:EVENT_INITX+(counter*shiftSpace) withWidth:eventWidth withDrawEvent:(DrawEventObject*)durationEvent];
            }else{
                //TODO use the currect Color style
                NSInteger colorIndex=[[ProjectTool getEventTypeFromEvent:(EKEvent*)durationEvent]intValue]; 
                FcEventButton *durationButton=[[FcEventButton buttonWithType:UIButtonTypeCustom] retain];
                [durationButton setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(width-(durationCount*shiftSpace), [self caculateEventHeight:(EKEvent*)durationEvent]) forNinePatchNamed:[[EventAction share] eventColorByStyle:colorIndex]] forState:UIControlStateNormal];
                [durationButton setFrame:CGRectMake(EVENT_INITX+(counter*shiftSpace), [self caculateEventY:(EKEvent*)durationEvent], width-(durationCount*shiftSpace),[self caculateEventHeight:(EKEvent*)durationEvent])];
                durationButton.eventId=[NSString stringWithString:((EKEvent*)durationEvent).eventIdentifier];
                [durationButton insertSubEventId:((EKEvent*)durationEvent).eventIdentifier];
                [durationButton.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:13.0f]];
                [durationButton setTitle:((EKEvent*)durationEvent).title forState:UIControlStateNormal];
                [durationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [durationButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                [durationButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
                UIEdgeInsets titleInset=UIEdgeInsetsMake(2.0, 3.0, 0.0, 0.0);
                [durationButton addTarget:self action:@selector(squrePopoverAction:) forControlEvents:UIControlEventTouchUpInside];
                durationButton.titleEdgeInsets=titleInset;
                [todayEventTable addSubview:durationButton];
                counter++;
                //[durationEvent release];
            }
        }
    }
}

//在同樣一個frame裡加入split event
-(void)drawEventOnTable:(CGFloat)xPosition withWidth:(CGFloat)width withDrawEvent:(DrawEventObject*)_drawEvent{
    
    NSMutableArray *sameTimeEvents=[NSMutableArray arrayWithObjects:_drawEvent.eventLeader, nil];
    if ([_drawEvent.sameTimeEvents count]>0)
        [sameTimeEvents addObjectsFromArray:_drawEvent.sameTimeEvents];
    NSInteger s_width=ceil((double)width/[sameTimeEvents count]);
    NSInteger counter=0;
    for (EKEvent *splitEvent in sameTimeEvents) {
        NSInteger colorIndex=[[ProjectTool getEventTypeFromEvent:splitEvent] intValue];
        FcEventButton *_eventBtn=[[FcEventButton buttonWithType:UIButtonTypeCustom] retain];
        _eventBtn.eventId=splitEvent.eventIdentifier;
        [_eventBtn insertSubEventId:splitEvent.eventIdentifier];
        [_eventBtn setBackgroundImage:[TUNinePatchCache imageOfSize:CGSizeMake(s_width, [self caculateEventHeight:splitEvent]) forNinePatchNamed:[[EventAction share] eventColorByStyle:colorIndex]] forState:UIControlStateNormal];
        [_eventBtn setFrame:CGRectMake(xPosition+(s_width*counter), [self caculateEventY:splitEvent], s_width, [self caculateEventHeight:splitEvent])];
        [_eventBtn setTitle:splitEvent.title forState:UIControlStateNormal];
        [_eventBtn.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:13.0f]];
        [_eventBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_eventBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_eventBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        UIEdgeInsets titleInset=UIEdgeInsetsMake(3.0, 3.0, 0.0, 0.0);
        _eventBtn.titleEdgeInsets=titleInset;
        [_eventBtn addTarget:self action:@selector(squrePopoverAction:) forControlEvents:UIControlEventTouchUpInside];
        [todayEventTable addSubview:_eventBtn];
        counter++;
    }
}
-(CGFloat)caculateEventY:(EKEvent*)_event{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"HH"];
    NSDateFormatter *formatter1=[NSDateFormatter getFormatterByFormateString:@"mm"];
    
    NSString *h=[NSString stringWithString:[formatter stringFromDate:_event.startDate]];
    NSString *m=[formatter1 stringFromDate:_event.startDate];
    
    CGFloat value=[h floatValue]+([m floatValue]/60.0f);
    return value*CellHeight;
}
//計算該event的高度
-(CGFloat)caculateEventHeight:(EKEvent*)_event{
    NSTimeInterval interval=[_event.endDate timeIntervalSinceDate:_event.startDate];
    return (CGFloat)(((double)interval/(double)3600.0f)*CellHeight);
}

-(DrawEventObject*)makeDrawEvent:(NSInteger)eventIndex allowAddDuration:(BOOL)allow{
    DrawEventObject *_drawEvent=[DrawEventObject new];
    _drawEvent.eventLeader=[_tmpEvents objectAtIndex:eventIndex];
    for (int i=eventIndex; i<[_tmpEvents count]; i++) {
        _drawCounter=i;
        BOOL lastOne=((i+1)>=[_tmpEvents count])?YES:NO;
        if(lastOne)
            return [_drawEvent autorelease]; //若為最後一個就返回
        
        EKEvent *thisObject=[_tmpEvents objectAtIndex:i];
        EKEvent *nextObject=[_tmpEvents objectAtIndex:i+1];
        NSTimeInterval interval=[nextObject.startDate timeIntervalSinceDate:_drawEvent.eventLeader.startDate];
        NSTimeInterval occ_time=[_drawEvent.eventLeader.endDate timeIntervalSinceDate:_drawEvent.eventLeader.startDate];
        NSTimeInterval b_interval=[nextObject.startDate timeIntervalSinceDate:thisObject.startDate];
        if (interval<=HalfHourSec) {
            [_drawEvent.sameTimeEvents addObject:nextObject];
        }else if(b_interval<=HalfHourSec && allow==YES){
            //判斷這物件有split,所以要刪除前一個,再加入split
            if([_drawEvent.durationTimeEvents count]>0)
                [_drawEvent.durationTimeEvents removeLastObject];
            [_drawEvent.durationTimeEvents addObject:[self makeDrawEvent:i allowAddDuration:NO]];
        }else if(occ_time>interval && allow==YES){
            [_drawEvent.durationTimeEvents addObject:nextObject];
        }else 
            return [_drawEvent autorelease];
    }
    return [_drawEvent autorelease];
}

-(void)proceedDrawEvent{
    _drawCounter=0;
    for (int i=0; i<[_tmpEvents count]; i++) {
        [_eventsForDrawing addObject:[self makeDrawEvent:i allowAddDuration:YES]];
        i=_drawCounter;
    }
}

-(void)removeDrawEvent{
    for (DrawEventObject *_event in _eventsForDrawing)
        [_event release];
    [_eventsForDrawing removeAllObjects];
}

#pragma mark - CalendarSelectorMethod
-(IBAction)yearSelectAction:(id)sender{
    [super yearSelectAction:sender];
    [[NSNotificationCenter defaultCenter] postNotificationName:DrawWheelEvents object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:DrawTodayEvents object:nil];
}
-(IBAction)monthSelectAction:(id)sender{
    [super monthSelectAction:sender];
    [[NSNotificationCenter defaultCenter] postNotificationName:DrawWheelEvents object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:DrawTodayEvents object:nil];
}

-(void)dateButtonAction:(id)sender{
    [super dateButtonAction:sender];
    [todayEventTable reloadData];
    NSDate *_date=[[DateCaculator share] selectedDay];
    [self drawEventSqure:[[EventAction share]fetchEventsOnDate:_date]];
}

-(void)setDateForLabels{
    [super setDateForLabels];
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"LLL dd"];
    [todayEventTitle setText:[NSString stringWithFormat:@"Events:%@",[formatter stringFromDate:[DateCaculator share].selectedDay]]];
}
#pragma mark - NotifyMethod
-(void)drawTodayEvents:(NSNotification*)noti{
    [[DateCaculator share]resetSelectedDay];
    NSDate *_date=[[DateCaculator share] selectedDay];
    [self drawEventSqure:[[EventAction share]fetchEventsOnDate:_date]];
}

-(void)drawWheelEvents:(NSNotification*)noti{
    [[DateCaculator share] resetSelectedDay];
    [[EventAction share] fetchEventsInWheel:[[DateCaculator share]selectedDay] withInitAngle:0.0f];
    [[EventAction share] drawEvents:eventView];
    [self setPopover];
    [self initDatesByWheel];
}
#pragma mark - EventAction
-(IBAction)addEventAction:(id)sender{
    EventEditViewController *eventEdit=[[EventEditViewController alloc] initWithEvent:nil];
    //TODO add animation
    [self.view addSubview:eventEdit.view];
}

- (void)deleteEvents{
    NSDate *dateNow=[NSDate new];
    
    NSDate *preday=[[NSDate alloc] initWithTimeIntervalSince1970:[dateNow timeIntervalSince1970]-2592000];
    NSDate *nextDay=[[NSDate alloc] initWithTimeIntervalSince1970:[dateNow timeIntervalSince1970]+2592000];
    
    CalendarDAO *dao=[CalendarDAO share];
    NSArray *array=[dao fetchEventsWithStartDate:preday withEndDate:nextDay];
    for(EKEvent *event in array){
        NSLog(@"eventTitle: %@",event.title);
        [dao deleteEvent:event.eventIdentifier];
    }
}

-(void)addRandomEvent{
    NSInteger bound=1123200;
    NSInteger length=10800;
    NSDate *dateNow=[NSDate new];
    CalendarDAO *dao=[CalendarDAO share];
    for(int i=0;i<300;i++){
        BOOL r=(BOOL)(arc4random()%2);
        NSInteger var=(r)?[dateNow timeIntervalSince1970]+(arc4random()%bound):[dateNow timeIntervalSince1970]-(arc4random()%bound);
        NSDate *startDate=[[[NSDate alloc] initWithTimeIntervalSince1970:var] autorelease];
        NSInteger var1=[startDate timeIntervalSince1970]+(3600+arc4random()%length);
        NSDate *endDate=[[NSDate alloc] initWithTimeIntervalSince1970:var1];
        EKEvent *newEvent=[dao factoryEvent];
        newEvent.startDate=startDate;
        newEvent.endDate=endDate;
        newEvent.title=[NSString stringWithFormat:@"title%i",r];
        newEvent.location=@"Taipei";
        [dao addEventWithEKEvent:newEvent];

    }
}

-(void)removeAllOnTodayEvents{
    for(id subView in todayEventTable.subviews){
        if([subView isKindOfClass:[FcEventButton class]]){
            [((FcEventButton*)subView) removeFromSuperview];
            [((FcEventButton*)subView) release];
        }
    }
}
- (IBAction)syncEvent:(id)sender {
    if (syncEvent==nil) {
        syncEvent = [SyncAction new];
    }
    [syncEvent  fetchNewEventsFromServer];
}
@end
