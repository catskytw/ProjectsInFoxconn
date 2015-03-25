//
//  AttendanceView.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/13.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "AttendanceViewController.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "DateCaculator.h"
#import "DateViewStyle1.h"
#import "NSFormatterExtend.h"
#import "MOSearchUserViewController.h"
#import "AttendanceModel.h"
#import "FcConfig.h"
#import "UIView_extend.h"
@interface AttendanceViewController(PrivateMethod)
-(void)tuneContentLayout;
-(void)setDateScrollView;
-(void)settingMonthLabel;
-(UIView*)setOneDateView:(NSDate*)m_date withOrder:(NSInteger)order;
-(void)reloadAttendance;
@end
@implementation AttendanceViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"BasicViewController" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Test Data
    //should query the data in this month for default values.
    addButton.hidden=NO;
    resetButton.hidden=NO;
    //date scrollView
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(266, 120, 740, 27)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.delegate=self;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    monthLabel=[[UILabel alloc] initWithFrame:CGRectMake(126, 126, 150, 17)];
    [monthLabel setTextAlignment:UITextAlignmentCenter];
    [monthLabel setFont:[UIFont fontWithName:DefaultFontName size:17]];
    [monthLabel setTextColor:getUIColorFromRGB(146, 167, 183, 1)];
    [monthLabel setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:monthLabel];
    
    [titleLabel setText:AMLocalizedString(@"attendance", nil)];
    [self tuneContentLayout]; //調整內容view
    [self setDateScrollView]; //調整內容上方時間scrollView
    [self settingMonthLabel];
    [self tuneTitleLayout:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:DrawAttendanceSchedule object:nil];
    //[self setRightSideButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [scrollView release];
    [monthLabel release];
}
#pragma mark - TuneLayout
-(void)tuneContentLayout{
    contentVC=[[ThreeContentViewController alloc]initWithNibName:nil bundle:nil];
    NSMutableArray *contentViewsName = [[NSMutableArray arrayWithObjects:@"Attendance1View", @"Attendance2View", @"Attendance3View",nil]retain];
    NSArray *contentPosition = [[NSArray arrayWithObjects:
                                 [NSValue valueWithCGRect:CGRectMake(0, 0,124, 550)],
                                 [NSValue valueWithCGRect:CGRectMake(114, 0, 156, 550)],
                                 [NSValue valueWithCGRect:CGRectMake(266, 0, 754, 550)],nil]retain];
    [contentVC initWithXibNames:contentViewsName withPosition:contentPosition];
    [contentVC.view setFrame:CGRectMake(5, 145, 1040, 550)];
    
    UIImageView *topBlock=[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(888, 16) forNinePatchNamed:@"bg_topblock"]];
    [topBlock setFrame:CGRectMake(118, 0, 888, 16)];
    [contentVC.view addSubview:topBlock];
    [self.view addSubview:contentVC.view];
    [contentViewsName release];
    [contentPosition release];
}
-(void)settingMonthLabel{
    NSString *dateString=[NSString stringWithFormat:@"yyyy%@/MM%@",AMLocalizedString(@"year", nil),AMLocalizedString(@"month", nil)];
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:dateString];
    [monthLabel setText:[formatter stringFromDate:[DateCaculator share].selectedDay]];
}
-(void)setDateScrollView{
    [[DateCaculator share] resetSelectedDay];
    [scrollView removeAllSubViews];
    
    NSArray *dates=[[DateCaculator share] getAllDaysMainCalendar:[DateCaculator share].selectedDay];
    NSInteger counter=0;
    for (NSDate *_date in dates) {
        if(![[DateCaculator share] inSameMonth:_date withDate2:[DateCaculator share].selectedDay])
            continue;
        UIView *dateView=[self setOneDateView:_date withOrder:counter];
        [scrollView addSubview:dateView];
        counter++;
    }
    [scrollView setContentSize:CGSizeMake(attendanceCellWidth*counter, 27)];
}

-(UIView*)setOneDateView:(NSDate*)m_date withOrder:(NSInteger)order{ 
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DateViewStyle1" owner:nil options:nil];
    DateViewStyle1 *dateView = [topLevelObjects objectAtIndex:0];
    NSDateFormatter *f1=[NSDateFormatter getFormatterByFormateString:@"dd"];
    NSDateFormatter *f2=[NSDateFormatter getFormatterByFormateString:@"ccc"];
    
    [dateView.dayLabel setText:[f1 stringFromDate:m_date]];
    [dateView.cLabel setText:[f2 stringFromDate:m_date]];
    
    [dateView setFrame:CGRectMake(dateView.frame.size.width*order,0,dateView.frame.size.width,dateView.frame.size.height)];
    return dateView;
}
#pragma mark - ActionMethod
-(IBAction)addBtnAction:(id)sender{
    MOSearchUserViewController *searchView=[MOSearchUserViewController new];
    searchView.delegate=[AttendanceModel share];
    [self.view addSubview:searchView.view];
}
-(IBAction)resetBtnAction:(id)sender{
    [[AttendanceModel share].workNos removeAllObjects];
    NSInteger m_tmp=[[AttendanceModel share] attendanceType];
    [[AttendanceModel share] setAttendanceType:m_tmp];
}
#pragma -
#pragma mark - DelegateMethod
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    CGPoint offSet=_scrollView.contentOffset;
    NSMutableDictionary *dicInfo=[NSMutableDictionary dictionary];
    [dicInfo setValue:[[NSValue valueWithCGPoint:offSet]retain] forKey:@"offset"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:Attendance3ViewXOffSet object:nil userInfo:dicInfo];
}

-(void)yearSelectAction:(id)sender{
    [super yearSelectAction:sender];
    [self reloadAttendance];
    [self setDateScrollView];
    [self settingMonthLabel];
}
-(void)monthSelectAction:(id)sender{
    [super monthSelectAction:sender];
    [self reloadAttendance];
    [self setDateScrollView];
    [self settingMonthLabel];
}
-(void)reloadAttendance{
    NSInteger tmp=[AttendanceModel share].attendanceType;
    [AttendanceModel share].attendanceType=tmp;
}
@end
