//
//  ImportViewController.h
//  logistic
//
//  Created by Chang Link on 11/8/4.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateButton.h"
@interface BasicViewController : UIViewController{
    UIImageView *backgroudImg;
    UIImageView *navigationBar;
    UIButton *menuIcon,*addButton,*resetButton;
    UILabel *titleLabel;
    UIView *calendarMainView;
    
    NSMutableArray *mainCalendarDates;
    NSMutableArray *mainCalendarButtons;
    NSMutableArray *miscArray;
    
    DateButton *_selectedDateBtn;
    BOOL isOpen,isInitFlag,isLeftOpen,isRightOpen;
    
    IBOutlet UILabel *dateLabel,*dateSelectorLabel;
    NSMutableArray *leftButtons;
    NSMutableArray *rightButtons;
    //left right Calendar selecting bar
    IBOutlet UIView *p_leftCalendarView,*p_rightCalendarView;
    IBOutlet UIView *c_leftCalendarView,*c_rightCalendarView;
    IBOutlet UIScrollView *s_leftCalendarScrollView, *s_rightCalendarScrollView;

}
@property (retain, nonatomic) IBOutlet UIView *msgView;
@property (retain, nonatomic) IBOutlet UIButton *msgBtn;
@property (nonatomic, retain) IBOutlet UIButton *menuIcon,*addButton,*resetButton;
@property (nonatomic, retain) IBOutlet UIImageView *backgroudImg;
@property (nonatomic, retain) IBOutlet UIImageView *navigationBar;
@property(nonatomic,retain)IBOutlet UILabel *titleLabel;
@property(nonatomic,retain)IBOutlet UIView *calendarMainView;
@property(nonatomic,retain) NSMutableArray *mainCalendarDates,*mainCalendarButtons,*miscArray;
@property(nonatomic,retain)IBOutlet UILabel *dateLabel,*dateSelectorLabel;
@property(nonatomic,retain)UIView *p_leftCalendarView,*p_rightCalendarView,*c_leftCalendarView,*c_rightCalendarView;
@property(nonatomic,retain)UIScrollView *s_leftCalendarScrollView, *s_rightCalendarScrollView;
- (IBAction)showMenu:(id)sender;
-(IBAction)addBtnAction:(id)sender;
-(IBAction)resetBtnAction:(id)sender;
-(void)tuneTitleLayout:(BOOL)isShowCalendar;
-(void)dateButtonAction:(id)sender;
-(IBAction)yearSelectAction:(id)sender;
-(IBAction)monthSelectAction:(id)sender;
-(void)setDateForLabels;
-(void)constructMainCalendarView;
-(void)constructRightSideCalerdarView;
-(void)constructLeftSideCalerdarView;
-(IBAction)slideLeftCalendarBar:(id)sender;
-(IBAction)slideRightCalendarBar:(id)sender;
- (IBAction)msgClick:(id)sender;
-(void)initSideCalendarView;
-(void)constructSideCalerdarView;
@end
