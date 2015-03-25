//
//  EventEditViewController.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface EventEditViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate> {
    BOOL isEditEvent,isOpenSelectedOption,isSelectDate,isSlideForKeyboard,isAllDay;
    NSArray *repeatStringArray,*alarmStringArray,*eventTypeStringArray;
    NSInteger viewType; //1是repeat,2是alarm,3是eventType
    IBOutlet UIView *contentView,*slideBackView;
    IBOutlet UIImageView *backgroundView,*titleView,*locationView,*h_line,*v_line,*commentView;
    IBOutlet UIButton *repeatBtn,*tipBtn,*completedBtn,*cancelBtn,*deleteBtn,*startTimeFrame,*endTimeFrame,*kindBtn;
    
    //dateTime SelectorView
    IBOutlet UIView *dateTimeSelectorView;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIImageView *v_line_pointer1,*v_line_pointer2;
    IBOutlet UIButton *allDayBtn,*confirmBtn;
    IBOutlet UIImageView *checkAllDay,*datePickerMask;
    IBOutlet UILabel *allDayLabel;
    IBOutlet UITableView *selectTable;
    
    //inputData
    EKEvent *thisEvent;
    IBOutlet UITextView *commentTextView;
    IBOutlet UITextField *titleText,*locationText;
    IBOutlet UILabel *repeatLabel,*tipLabel,*eventTypeLabel;
    IBOutlet UILabel *startTimeLabel,*endTimeLabel;
    NSDate *startDate,*endDate;
    NSInteger dateOption; //1是startDate,2是endDate
    NSInteger repeatIndex,tipIndex,typeIndex;
    EKRecurrenceRule *eventRecurrence;
    EKAlarm *alarm;
    NSDateFormatter *dateTimeFormatter,*dateFormatter,*usingFormatter;
}
@property(nonatomic,retain)UIImageView *backgroundView,*titleView,*locationView,*h_line,*v_line,*commentView,*v_line_pointer1,*v_line_pointer2;
@property(nonatomic,retain)UIButton *repeatBtn,*tipBtn,*completedBtn,*cancelBtn,*deleteBtn,*startTimeFrame,*endTimeFrame,*allDayBtn,*confirmBtn,*kindBtn;
@property(nonatomic,retain)UIView *contentView,*dateTimeSelectorView,*slideBackView;
@property(nonatomic,retain)UIDatePicker *datePicker;
@property(nonatomic,retain)UIImageView *checkAllDay,*datePickerMask;
@property(nonatomic,retain)UILabel *allDayLabel;
@property(nonatomic,retain)UITextView *commentTextView;
@property(nonatomic,retain)UITextField *titleText,*locationText;
@property(nonatomic,retain)UITableView *selectTable;
@property(nonatomic,retain)UILabel *repeatLabel,*tipLabel,*startTimeLabel,*endTimeLabel,*eventTypeLabel;
@property(nonatomic,retain)NSDate *startDate,*endDate;
-(id)initWithEvent:(EKEvent*)event;
-(IBAction)closeSelf:(id)sender;
-(IBAction)selectRepeatOptin:(id)sender;
-(IBAction)selectStartDateTime:(id)sender;
-(IBAction)selectEndDateTime:(id)sender;
-(IBAction)confirmDate:(id)sender;
-(IBAction)datePickerChangeValue:(id)sender;
-(IBAction)switchAllDay:(id)sender;
-(IBAction)completeAddEvent:(id)sender;
-(IBAction)deleteEventAction:(id)sender;
@end
