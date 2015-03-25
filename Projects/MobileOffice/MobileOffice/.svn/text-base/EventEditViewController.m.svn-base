//
//  EventEditViewController.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "EventEditViewController.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "EventRepeatSelectCell.h"
#import "LocalizationSystem.h"
#import "DateCaculator.h"
#import "CalendarDAO.h"
#import "EventAction.h"
#import "FcEventButton.h"
#import "ProjectTool.h"
#import "CalendarNetworkInterface.h"
#define kOFFSET_FOR_KEYBOARD 140.0f

@interface EventEditViewController(PrivatedMethod)
-(void)constructLayout;
-(void)setComponentAttr;
-(void)slidePointBar:(id)sender withPointer:(UIImageView*)pointer;
-(void)openSelectOption:(id)sender;
-(void)closeSelectOption;
-(void)openDateSelect;
-(void)closeDateSelect;
-(void)changeRepeatCommentView:(BOOL)isShowComment;
-(void)setViewMovedUp:(BOOL)movedUp;
-(NSInteger)parseAlarmIndex:(EKAlarm*)_alarm;
-(EKAlarm*)alarmForIndex:(NSInteger)alarmIndex;
@end
@implementation EventEditViewController
@synthesize backgroundView,titleView,locationView,repeatBtn,tipBtn,cancelBtn,completedBtn,contentView,deleteBtn,datePicker,h_line,v_line,dateTimeSelectorView,slideBackView,startTimeFrame,endTimeFrame,commentView,v_line_pointer1,v_line_pointer2,confirmBtn,checkAllDay,allDayBtn,allDayLabel,commentTextView,titleText,locationText,selectTable,repeatLabel,tipLabel,startTimeLabel,endTimeLabel,startDate,endDate,datePickerMask,kindBtn,eventTypeLabel;
-(id)initWithEvent:(EKEvent*)event{
    if((self=[super init])){
        thisEvent=(event==nil)?nil:[event retain];
        isEditEvent=(thisEvent==nil)?NO:YES;
        isOpenSelectedOption=NO;
        isSelectDate=NO;
        isAllDay=NO;
        isSlideForKeyboard=NO;
        dateOption=1;
        
        eventRecurrence=(thisEvent==nil)?nil:thisEvent.recurrenceRule;
        alarm=(thisEvent==nil)?nil:(EKAlarm*)[thisEvent.alarms objectAtIndex:0];
        startDate=(thisEvent==nil)?[[NSDate date] retain]:[thisEvent.startDate retain];
        endDate=(thisEvent==nil)?[[NSDate alloc]initWithTimeInterval:3600 sinceDate:startDate]:[thisEvent.endDate retain];
        repeatIndex=0;
        tipIndex=0;
        viewType=1;
        repeatStringArray=[[NSArray arrayWithObjects:
                            AMLocalizedString(@"none", nil),AMLocalizedString(@"weekly", nil),AMLocalizedString(@"twoweekly", nil),AMLocalizedString(@"monthly", nil),AMLocalizedString(@"yearly", nil),nil] retain];
        
        alarmStringArray=[[NSArray arrayWithObjects:
                           AMLocalizedString(@"none", nil),
                           AMLocalizedString(@"before_5mins", nil),
                           AMLocalizedString(@"before_15mins", nil),
                           AMLocalizedString(@"before_30mins", nil),
                           AMLocalizedString(@"before_1hr", nil),
                           AMLocalizedString(@"before_2hrs", nil),
                           AMLocalizedString(@"before_1day", nil),
                           AMLocalizedString(@"before_2days", nil),
                           AMLocalizedString(@"before_endDate", nil),
                           nil] retain];
        eventTypeStringArray=[[NSArray arrayWithObjects:
                               //AMLocalizedString(@"Default", nil),
                               AMLocalizedString(@"Busniess", nil),
                               AMLocalizedString(@"lunch", nil),
                               AMLocalizedString(@"meeting", nil),
                               AMLocalizedString(@"personal", nil),
                               nil]retain];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)dealloc
{
    [startDate release];
    [endDate release];
    if (thisEvent!=nil) {
        [thisEvent release];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self constructLayout];
    [self setComponentAttr];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [eventRecurrence release];
    [dateTimeFormatter release];
    [dateFormatter release];
    [repeatStringArray release];
    [alarmStringArray release];
    [eventTypeStringArray release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)closeSelf:(id)sender{
    //TODO animation?
    [self.view removeFromSuperview];
    [self release];
}
-(IBAction)selectRepeatOptin:(id)sender{
    UIButton *thisBtn=(UIButton*)sender;
    viewType=thisBtn.tag;
    if (isOpenSelectedOption==NO) {
        [self openSelectOption:sender];
        isOpenSelectedOption=YES;
    }
    [self slidePointBar:sender withPointer:v_line_pointer1];
    [selectTable reloadData];
    NSInteger selectedIndex;
    switch (viewType) {
        case 1:
            selectedIndex=repeatIndex;
            break;
        case 2:
            selectedIndex=tipIndex;
            break;
        case 3:
            selectedIndex=typeIndex;
            break;
    }
    [selectTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:NO scrollPosition:0];
}

-(IBAction)selectEndDateTime:(id)sender{
    if (isSelectDate==NO) {
        [self openDateSelect];
        isSelectDate=YES;
    }
    [datePicker setDate:endDate animated:YES];
    [self slidePointBar:sender withPointer:v_line_pointer2];
    dateOption=2;
}
-(IBAction)selectStartDateTime:(id)sender{
    if (isSelectDate==NO) {
        [self openDateSelect];
        isSelectDate=YES;
    }
    [datePicker setDate:startDate animated:YES];
    [self slidePointBar:sender withPointer:v_line_pointer2];
    dateOption=1;
}
-(IBAction)confirmDate:(id)sender{
    if(isSelectDate==YES){
        [self closeDateSelect];
        isSelectDate=NO;
    }
}
-(void)openSelectOption:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    dateTimeSelectorView.center=CGPointMake(dateTimeSelectorView.center.x+330, dateTimeSelectorView.center.y);
    v_line.hidden=YES;
    v_line_pointer1.hidden=NO;
    [UIView commitAnimations];
}
-(void)closeSelectOption{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    dateTimeSelectorView.center=CGPointMake(dateTimeSelectorView.center.x-330, dateTimeSelectorView.center.y);
    v_line.hidden=NO;
    v_line_pointer1.hidden=YES;
    [UIView commitAnimations];
}
-(void)openDateSelect{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    v_line.hidden=YES;
    v_line_pointer2.hidden=NO;
    dateTimeSelectorView.center=CGPointMake(dateTimeSelectorView.center.x-330, dateTimeSelectorView.center.y);
    [UIView commitAnimations];
    [self changeRepeatCommentView:NO];
}
-(void)closeDateSelect{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    v_line.hidden=NO;
    v_line_pointer2.hidden=YES;
    dateTimeSelectorView.center=CGPointMake(dateTimeSelectorView.center.x+330, dateTimeSelectorView.center.y);
    [UIView commitAnimations];
    [self changeRepeatCommentView:YES];
}

-(void)slidePointBar:(id)sender withPointer:(UIImageView *)pointer{
    UIButton *btn=(UIButton*)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    pointer.center=ccp(pointer.center.x, btn.center.y);
    [UIView commitAnimations];
}
-(void)changeRepeatCommentView:(BOOL)isShowComment{
    commentTextView.hidden=!isShowComment;
    commentView.hidden=!isShowComment;
    
    allDayLabel.hidden=isShowComment;
    allDayBtn.hidden=isShowComment;
    confirmBtn.hidden=isShowComment;
    checkAllDay.hidden=isShowComment;
}
#pragma mark - TableDelegateMethod
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *options;
    switch (viewType) {
        case 1:
            options=repeatStringArray;
            break;
        case 2:
            options=alarmStringArray;
            break;
        case 3:
            options=eventTypeStringArray;
            break;
    }
    return [options count]; 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *options;
    NSString *cellId;
    switch (viewType) {
        case 1:
            options=repeatStringArray;
            cellId=@"EventRepeatSelectCell";
            break;
        case 2:
            options=alarmStringArray;
            cellId=@"EventAlarmCell";
            break;
        case 3:
            options=eventTypeStringArray;
            cellId=@"EventTypeCell";
            break;
    }
    NSInteger row=[indexPath row];
    EventRepeatSelectCell *cell=(EventRepeatSelectCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"EventRepeatSelectCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[EventRepeatSelectCell class]]){
                cell=(EventRepeatSelectCell*)currentObject;
                [cell.selectedImage setImage:[TUNinePatchCache imageOfSize:ccs(330, 45) forNinePatchNamed:@"table_cell_select"]];
                [cell.seperatorImage setImage:[TUNinePatchCache imageOfSize:ccs(330, 2) forNinePatchNamed:@"table_cell_line"]];
                [cell.textLabel setTextAlignment:UITextAlignmentCenter];
                [cell.textLabel setFont:[UIFont fontWithName:DefaultFontName size:17.0f]];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    [cell.textLabel setText:[options objectAtIndex:row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self closeSelectOption];
    isOpenSelectedOption=NO;
    NSInteger selectedRow=[indexPath row];
    switch (viewType) {
        case 1:
            repeatIndex=selectedRow;
            [repeatLabel setText:[repeatStringArray objectAtIndex:repeatIndex]];
            break;
        case 2:
            tipIndex=selectedRow;
            [tipLabel setText:[alarmStringArray objectAtIndex:tipIndex]];
            break;
        case 3:
            typeIndex=selectedRow;
            [eventTypeLabel setText:[eventTypeStringArray objectAtIndex:typeIndex]];
            break;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    /*if (!isSlideForKeyboard) {
        [self setViewMovedUp:YES];
        isSlideForKeyboard=!isSlideForKeyboard;
    }*/
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    /*if(isSlideForKeyboard){
        [self setViewMovedUp:NO];
        [textView resignFirstResponder];
        isSlideForKeyboard=!isSlideForKeyboard;
    }*/
}
#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    /*if (isSlideForKeyboard==NO) {
        [self setViewMovedUp:YES];
        isSlideForKeyboard=YES;
    }*/
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    /*if(isSlideForKeyboard==YES){
        [self setViewMovedUp:NO];
        [textField resignFirstResponder];
        isSlideForKeyboard=NO;
    }*/
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - privateMethod
-(void)setComponentAttr{
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    datePicker.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    CGSize size=[datePicker sizeThatFits:CGSizeZero];
    datePicker.frame=CGRectMake(datePicker.frame.origin.x, datePicker.frame.origin.y, size.width, size.height);
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale=locale;
    [locale release];
    
    NSString *dateFormatString=[NSString stringWithFormat:@"M%@d%@EE H:mm",AMLocalizedString(@"month", nil),AMLocalizedString(@"day", nil)];
    NSString *dateFormatString1=[NSString stringWithFormat:@"M%@d%@EE",AMLocalizedString(@"month", nil),AMLocalizedString(@"day", nil)];
    dateTimeFormatter=[[NSDateFormatter getFormatterByFormateString:dateFormatString]retain];
    dateFormatter=[[NSDateFormatter getFormatterByFormateString:dateFormatString1]retain];
    usingFormatter=dateTimeFormatter;
    [startTimeLabel setText:[usingFormatter stringFromDate:startDate]];
    [endTimeLabel setText:[usingFormatter stringFromDate:endDate]];
    
    if (thisEvent!=nil) {
        [titleText setText:thisEvent.title];
        [locationText setText:[[thisEvent.location componentsSeparatedByString:Seperator]objectAtIndex:0]];
        NSInteger _repeatIndex=[ProjectTool parseRepeatIndex:thisEvent.recurrenceRule];
        repeatIndex=_repeatIndex;
        [repeatLabel setText:[repeatStringArray objectAtIndex:_repeatIndex]];
        NSInteger _tipIndex=[self parseAlarmIndex:[thisEvent.alarms objectAtIndex:0]];
        tipIndex=_tipIndex;
        [tipLabel setText:[alarmStringArray objectAtIndex:_tipIndex]];
        [commentTextView setText:thisEvent.notes];
        NSArray *_sep=[thisEvent.location componentsSeparatedByString:Seperator];
        NSLog(@"location %@", thisEvent.location);
        NSInteger _typeIndex=([_sep count]>1)?[ProjectTool parseEventTypeIndex:[[_sep objectAtIndex:1]intValue]]:0;
        typeIndex=_typeIndex;
        NSLog(@"typeIndex:%i", typeIndex);
        [eventTypeLabel setText:[eventTypeStringArray objectAtIndex:_typeIndex]];
    }
}
-(void)constructLayout{
    CGSize frameSize;
    CGSize normalEventOptionSize=ccs(302, 42);
    if (!isEditEvent) {
        frameSize=CGSizeMake(backgroundView.frame.size.width, backgroundView.frame.size.height-35);
        [backgroundView setFrame:CGRectMake(backgroundView.frame.origin.x, backgroundView.frame.origin.y, frameSize.width, frameSize.height)];
        deleteBtn.hidden=YES;
    }else{
        deleteBtn.hidden=NO;
        frameSize=backgroundView.frame.size;
        [deleteBtn setBackgroundImage:[TUNinePatchCache imageOfSize:ccs(191, 32) forNinePatchNamed:@"btn_content_2"] forState:UIControlStateNormal];
        [deleteBtn setBackgroundImage:[TUNinePatchCache imageOfSize:ccs(191, 32) forNinePatchNamed:@"btn_content_2_i"] forState:UIControlStateHighlighted];
        
        //add edit_line
        [h_line setImage:[TUNinePatchCache imageOfSize:ccs(660,3.0f) forNinePatchNamed:@"edit_line"]];
        h_line.center=ccp(frameSize.width/2.0f, 363.0f);
    }
    [v_line setImage:[TUNinePatchCache imageOfSize:ccs(3, 250) forNinePatchNamed:@"edit_line2"]];
    [backgroundView setImage:[TUNinePatchCache imageOfSize:frameSize forNinePatchNamed:@"edit_bg"]];
    [titleView setImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"]];
    [locationView setImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"]];

    [repeatBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateNormal];
    [kindBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateNormal];
    [tipBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[TUNinePatchCache imageOfSize:cancelBtn.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    
    [completedBtn setBackgroundImage:[TUNinePatchCache imageOfSize:completedBtn.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
    
    [completedBtn setBackgroundImage:[TUNinePatchCache imageOfSize:completedBtn.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];
    
    //add dateSelectorView add
    dateTimeSelectorView.frame=CGRectMake(330, 0, dateTimeSelectorView.frame.size.width, dateTimeSelectorView.frame.size.height);
    [slideBackView addSubview:dateTimeSelectorView];
    
    [startTimeFrame setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateNormal];
    [startTimeFrame setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateHighlighted];
    [endTimeFrame setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateNormal];
    [endTimeFrame setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateHighlighted];
    
    [commentView setImage:[TUNinePatchCache imageOfSize:ccs(302,94) forNinePatchNamed:@"editbox"]];
    
    [slideBackView bringSubviewToFront:v_line_pointer1];
    
    [allDayBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateNormal];
    [allDayBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"editbox"] forState:UIControlStateHighlighted];
    [confirmBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[TUNinePatchCache imageOfSize:normalEventOptionSize forNinePatchNamed:@"btn_content"] forState:UIControlStateHighlighted];
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    CGRect rect = self.contentView.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        //rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.contentView.frame = rect;
    [UIView commitAnimations];
}

-(IBAction)datePickerChangeValue:(id)sender{
    if(dateOption==1){
        [startDate release];
        startDate=[datePicker.date retain];
        [startTimeLabel setText:[usingFormatter stringFromDate:startDate]];
    }else if(dateOption==2){
        [endDate release];
        endDate=[datePicker.date retain];
        [endTimeLabel setText:[usingFormatter stringFromDate:endDate]];
    }
    endTimeLabel.textColor=([endDate timeIntervalSinceDate:startDate]<0)?[UIColor redColor]:[UIColor blackColor];
}

-(IBAction)switchAllDay:(id)sender{
    isAllDay=!isAllDay;
    usingFormatter=(isAllDay)?dateFormatter:dateTimeFormatter;
    datePicker.datePickerMode=(isAllDay)?UIDatePickerModeDate:UIDatePickerModeDateAndTime;
    [datePickerMask setImage:(isAllDay)?[UIImage imageNamed:@"time_mask_2.png"]:[UIImage imageNamed:@"time_mask_1.png"]];
    [checkAllDay setImage:(isAllDay)?[UIImage imageNamed:@"btn_checkbox_check.png"]:[UIImage imageNamed:@"btn_checkbox.png"]];
    [startTimeLabel setText:[usingFormatter stringFromDate:startDate]];
     [endTimeLabel setText:[usingFormatter stringFromDate:endDate]];
}

-(EKAlarm*)alarmForIndex:(NSInteger)_alarmIndex{
    NSTimeInterval interval;
    switch (_alarmIndex) {
        case 0:
            return nil;
        case 1:
            interval=-300;
            break;
        case 2:
            interval=-900;
            break;
        case 3:
            interval=-1800;
            break;
        case 4:
            interval=-3600;
            break;
        case 5:
            interval=-7200;
            break;
        case 6:
            interval=-86400;
            break;
        case 7:
            interval=-172800;
            break;
        case 8:
            interval=[[[DateCaculator share] getOnlyDate:thisEvent.startDate]timeIntervalSinceDate:thisEvent.startDate];
            break;
    }
    return [EKAlarm alarmWithRelativeOffset:interval];
}

-(NSInteger)parseAlarmIndex:(EKAlarm*)_alarm{
    NSInteger r=0;
    if(thisEvent==nil) return r;
    if(_alarm.relativeOffset==-300) //五分鐘
        r=1;
    else if(_alarm.relativeOffset==-900)//15分鐘
        r=2;
    else if(_alarm.relativeOffset==-1800)//30分鐘
        r=3;
    else if(_alarm.relativeOffset==-3600)//15分鐘
        r=4;
    else if(_alarm.relativeOffset==-7200)//15分鐘
        r=5;
    else if(_alarm.relativeOffset==-86400)//15分鐘
        r=6;
    else if(_alarm.relativeOffset==-172800)//15分鐘
        r=7;
    else if(_alarm.relativeOffset==[[[DateCaculator share] getOnlyDate:thisEvent.startDate]timeIntervalSinceDate:thisEvent.startDate])//結束時間
        r=8;
    
    return r;
}


-(IBAction)completeAddEvent:(id)sender{
    CalendarDAO *dao=[CalendarDAO share];
    EKEvent *updateEvent=(thisEvent==nil)?[dao factoryEvent]:thisEvent;
    updateEvent.startDate=startDate;
    updateEvent.endDate=endDate;
    updateEvent.title=titleText.text;
    updateEvent.location=locationText.text;
    updateEvent.notes=commentTextView.text;
    updateEvent.recurrenceRule=[ProjectTool recurrenceRuleForType:repeatIndex];
    [updateEvent setAlarms:[NSArray arrayWithObjects:[self alarmForIndex:tipIndex],nil]];
    updateEvent.location=[NSString stringWithFormat:@"%@%@%i",titleText.text,Seperator,[ProjectTool transEventTypeIndexToEventType:typeIndex]];
    BOOL r;
    if (thisEvent) {
        [dao updateEventWithEKEvent:updateEvent withEventId:updateEvent.eventIdentifier];
        r=[[CalendarNetworkInterface share] updateEvent:updateEvent];
    }else{
        [dao addEventWithEKEvent:updateEvent];
         r=[[CalendarNetworkInterface share] addEvent:updateEvent];
    }

    if (!r) {
        //UIAlertView *_alertView = [[[UIAlertView alloc]initWithTitle:@"Error" message:@"add event fail" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil]autorelease];
        //[_alertView show];
        NSLog(@"add event error");
    }
    [[DateCaculator share] resetSelectedDay];
    if ([[DateCaculator share] inSameMonth:[[DateCaculator share]selectedDay] withDate2:updateEvent.startDate]){
        if(thisEvent==nil){ //新增事件
            [[CalendarDAO share].eventsInMainMonthView addObject:updateEvent];
        }
        [[CalendarDAO share].eventsInMainMonthView sortUsingSelector:@selector(compareStartDateWithEvent:)];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:DrawWheelEvents object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:DrawTodayEvents object:nil];
    [self.view removeFromSuperview];
}

-(IBAction)deleteEventAction:(id)sender{
    CalendarDAO *dao=[CalendarDAO share];
    BOOL r=[[CalendarNetworkInterface share] removeEvent:thisEvent];
    if (!r) {
        //UIAlertView *_alertView = [[[UIAlertView alloc]initWithTitle:@"Error" message:@"delete event fail" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil]autorelease];
        //[_alertView show];
        NSLog(@"delete event fail");
    }
    [dao deleteEvent:thisEvent.eventIdentifier];
    for(FcEventButton *thisButton in [EventAction share].eventsInMonth){
        if([thisButton.eventId isEqualToString:thisEvent.eventIdentifier]){
            [thisButton removeFromSuperview];
            [[EventAction share].eventsInMonth removeObject:thisButton];
            break;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DrawTodayEvents object:nil];
    [self.view removeFromSuperview];
}
-(void)keyBoardDidShow:(NSNotification*)noti{
    if (isSlideForKeyboard==NO) {
        [self setViewMovedUp:YES];
        isSlideForKeyboard=YES;
    }
}
-(void)keyBoardDidHide:(NSNotification*)noti{
    if (isSlideForKeyboard==YES) {
        [self setViewMovedUp:NO];
        isSlideForKeyboard=NO;
    }
}
@end
