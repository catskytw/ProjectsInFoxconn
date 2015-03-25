//
//  ImportViewController.m
//  logistic
//
//  Created by Chang Link on 11/8/4.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffViewController.h"
#import "UITuneLayout.h"
#import "ContentView.h"
#import "NinePatch.h"
#import "FcDrawing.h"
#import "UITuneLayout.h"
#import "FcUIComponent.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "AttendanceViewController.h"
#import "MobileOfficeViewController.h"
#import "DateCaculator.h"
#import "EventAction.h"
#import "Tools.h"
#import "UIView_extend.h"
@interface BasicViewController(PrivateMethod)
-(BOOL)searchExistViewControllerWithClass:(Class)_class;
-(void)switchViewController:(Class)_class;
@end
@implementation BasicViewController
@synthesize msgView;
@synthesize msgBtn;
@synthesize menuIcon,addButton,resetButton;
@synthesize backgroudImg;
@synthesize navigationBar;
@synthesize titleLabel;
@synthesize calendarMainView;
@synthesize miscArray,mainCalendarDates,mainCalendarButtons;
@synthesize dateLabel,dateSelectorLabel;
@synthesize p_leftCalendarView,c_leftCalendarView,c_rightCalendarView,p_rightCalendarView,s_leftCalendarScrollView,s_rightCalendarScrollView;
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
    [TUNinePatchCache flushCache];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"Calendar";
    [DateCaculator share].selectedDay=[NSDate date];//預設日期為今日
    isOpen=NO;
    isInitFlag=YES;
    [UITuneLayout setNaviTitle:self];
    UIImage *img = [UIImage imageNamed:@"bg_blue.png"];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
    
     backgroudImg.image = [TUNinePatchCache imageOfSize:backgroudImg.frame.size forNinePatchNamed:@"img_belowbar"];
    [navigationBar setImage:[TUNinePatchCache imageOfSize:navigationBar.frame.size forNinePatchNamed:@"img_navigationbar"]];
    
    [addButton setBackgroundImage:[TUNinePatchCache imageOfSize:addButton.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[TUNinePatchCache imageOfSize:addButton.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    [resetButton setBackgroundImage:[TUNinePatchCache imageOfSize:resetButton.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [resetButton setBackgroundImage:[TUNinePatchCache imageOfSize:resetButton.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];

    UIImageView *addImage=[[[UIImageView alloc] initWithImage:[FcDrawing loadUIImage:@"ic_add" withType:@"png"]] autorelease];
    addImage.center=CGPointMake(addButton.frame.size.width/2.0f, addButton.frame.size.height/2.0f);
    addImage.frame=fixBlurryRect(addImage.frame);
    [addButton addSubview:addImage];
    addButton.hidden=YES;
    resetButton.hidden=YES;
    mainCalendarButtons=[[NSMutableArray array]retain];
    miscArray=[[NSMutableArray array]retain];
    leftButtons=[[NSMutableArray array] retain];
    rightButtons=[[NSMutableArray array] retain];
    [self initSideCalendarView];
    [self constructSideCalerdarView];
    [self constructMainCalendarView];
    [self setDateForLabels];
    isLeftOpen=NO;
    isRightOpen=NO;
    msgView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMsg:) name:SIGHOFF_SHOWMSG object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMsg:) name:SIGHOFF_CLOSEMSG object:nil];
    
    [msgBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:msgBtn.frame.size forNinePatchNamed:@"popup_bg"] forState:UIControlStateNormal];

}
-(void)showMsg:(NSNotification*)noti{
    [msgBtn setTitle:(NSString*)[noti object] forState:UIControlStateNormal];
    msgView.hidden = NO;
}
-(void)hideMsg:(NSNotification*)noti{
    msgView.hidden = YES;
}
- (void)viewDidUnload
{
    [self setBackgroudImg:nil];
    [self setMenuIcon:nil];
    [self setNavigationBar:nil];
    [self setMsgView:nil];
    [self setMsgBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [mainCalendarDates removeAllObjects];
    [mainCalendarDates release];
    
    [mainCalendarButtons removeAllObjects];
    [mainCalendarButtons release];
    
    [leftButtons removeAllObjects];
    [leftButtons release];
    
    [rightButtons removeAllObjects];
    [rightButtons release];
    
    [miscArray removeAllObjects];
    [miscArray release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
// Return YES for supported orientations
    return (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)?YES:NO;
}


- (IBAction)showMenu:(id)sender {
    NSMutableArray *menuNameArray = [NSMutableArray arrayWithObjects:AMLocalizedString(@"attendance",nil), AMLocalizedString(@"calendar",nil), AMLocalizedString(@"chat",nil), AMLocalizedString(@"sign",nil), nil];
    NSMutableArray *menuIconArray = [NSMutableArray arrayWithObjects:@"ic_attendance.png", @"ic_calendar.png",@"ic_chat.png", @"ic_sign.png", nil];
    [FcUIComponent showMenu:self.view withTarget:self action:@selector(menuAction:) withNames:menuNameArray withIcon:menuIconArray withPoint:CGPointMake(565,540) withWidth:450];
}
-(void)menuAction:(id)sender{
	UIButton *thisBtn=(UIButton*)sender;
    //ugly
    if([thisBtn.titleLabel.text isEqualToString:AMLocalizedString(@"attendance", nil)]){
        [self switchViewController:[AttendanceViewController class]];
    }else if([thisBtn.titleLabel.text isEqualToString:AMLocalizedString(@"calendar", nil)]){
        [self switchViewController:[MobileOfficeViewController class]];
    }else if([thisBtn.titleLabel.text isEqualToString:AMLocalizedString(@"chat", nil)]){
        return;//目前還沒有chat功能
    }else if([thisBtn.titleLabel.text isEqualToString:AMLocalizedString(@"sign", nil)]){
        [self switchViewController:[SignOffViewController class]];
    }
    
    NSLog(@"navigationViewControllers:%i",[[self.navigationController viewControllers]count]);
}
-(void)switchViewController:(Class)_class{
    if (![self searchExistViewControllerWithClass:_class]) {
        UIViewController *nextController=(UIViewController*)[_class new];
        [self.navigationController pushViewController:nextController animated:YES];
    }
}
-(IBAction)addBtnAction:(id)sender{
    
}
-(IBAction)resetBtnAction:(id)sender{
    
}
//檢查是否有己經push之viewController在navigationController.viewcontrollers裡
-(BOOL)searchExistViewControllerWithClass:(Class)_class{
    BOOL r=NO;
    NSMutableArray *viewControllers=[NSMutableArray arrayWithArray: [self.navigationController viewControllers]];
    NSMutableArray *newViewControllers;
    for(UIViewController *_v in viewControllers){
        if([_v isKindOfClass:_class]){
            /*
            newViewControllers=[NSMutableArray arrayWithObjects:_v, nil];
            [viewControllers removeObject:_v];
            [newViewControllers addObjectsFromArray:viewControllers];
             */
            [viewControllers removeObject:_v];
            newViewControllers=[NSMutableArray arrayWithArray:viewControllers];
            [newViewControllers addObject:_v];
            [self.navigationController setViewControllers:(NSArray*)newViewControllers animated:YES];
            r=YES;
            break;
        }
    }
    return r;
}
- (void)dealloc {
    [backgroudImg release];
    [menuIcon release];
    [navigationBar release];
    [msgView release];
    [msgBtn release];
    [super dealloc];
}
-(void)tuneTitleLayout:(BOOL)isShowCalendar{
    [self.view bringSubviewToFront:calendarMainView];
    [self.view bringSubviewToFront:navigationBar];
    [self.view bringSubviewToFront:resetButton];
    [self.view bringSubviewToFront:addButton];
    [self.view bringSubviewToFront:titleLabel];
    calendarMainView.hidden=!isShowCalendar;
}
-(IBAction)slideView:(id)sender{
    [UIView beginAnimations:nil context:NULL];
	[UIView animateWithDuration:0.75f animations:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationBeginsFromCurrentState:YES];
    NSInteger m_yOffset=(isOpen)?-227:227;
    
	calendarMainView.center=CGPointMake(calendarMainView.center.x, calendarMainView.center.y+m_yOffset);
    
	[UIView commitAnimations];
	isOpen=!isOpen;
}
-(void)constructMainCalendarView{
    int startX=60,startY=52;
    int xSpace=27,ySpace=29;
    
    mainCalendarDates=[NSMutableArray arrayWithArray: [[DateCaculator share] getAllDaysMainCalendar:[DateCaculator share].selectedDay]];
    for (DateButton *oldButton in mainCalendarButtons) {
        [oldButton removeFromSuperview];
    }
    for(UIImageView *pointImage in miscArray){
        [pointImage removeFromSuperview];
    }
    [miscArray removeAllObjects];
    [mainCalendarButtons removeAllObjects];
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"d"];
    for (int i=0; i<6; i++) {
        for (int j=0; j<7; j++) {
            NSInteger index=i*7+j;
            NSDate *_thisDate=[mainCalendarDates objectAtIndex:index];
            if(_thisDate==nil) return;
            CGPoint thisDateButtonPoint=ccp(startX+(j*xSpace), startY+(i*ySpace));
            DateButton *thisButton=[DateButton buttonWithType:UIButtonTypeCustom];
            thisButton.frame=CGRectMake(thisDateButtonPoint.x, thisDateButtonPoint.y, xSpace, xSpace);
            thisButton.backgroundColor=[UIColor clearColor];
            if([[DateCaculator share] inSameMonth:[DateCaculator share].selectedDay withDate2:_thisDate]){
                thisButton.enabled=YES;
                [thisButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                thisButton.enabled=NO;
                [thisButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            thisButton.thisDate=_thisDate;
            [mainCalendarButtons addObject:thisButton];
            NSDateFormatter *dateFormatter=[NSDateFormatter getFormatterByFormateString:@"yyyyMMdd"];
            if([[dateFormatter stringFromDate:_thisDate] isEqualToString:[dateFormatter stringFromDate:[DateCaculator share].selectedDay]]){
                [thisButton setBackgroundImage:[UIImage imageNamed:@"month cal_focus_day"]  forState:UIControlStateNormal];
                _selectedDateBtn=thisButton;
            }
            else
                [thisButton setBackgroundImage:nil forState:UIControlStateNormal];
            
            [thisButton setTitle:[formatter stringFromDate:_thisDate]  forState:UIControlStateNormal];
            [thisButton.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:14]];
            thisButton.titleLabel.textAlignment=UITextAlignmentCenter;
            [calendarMainView addSubview:thisButton];
            BOOL hasEvent=[[EventAction share] hasEventsOnDate:_thisDate];
            if (hasEvent) {
                UIImageView *pointImage=[[UIImageView alloc] initWithImage: [FcDrawing loadUIImage:@"month cal_point" withType:@"png"]];
                pointImage.center=ccp(thisButton.center.x,thisButton.center.y+10);
                [miscArray addObject:pointImage];
                [calendarMainView addSubview:pointImage];
            }
            [thisButton addTarget:self action:@selector(dateButtonAction:) forControlEvents:UIControlEventTouchDown];
        }
    }
}
-(void)dateButtonAction:(id)sender{
    [_selectedDateBtn setBackgroundImage:nil forState:UIControlStateNormal];
    DateButton *thisButton=(DateButton*)sender;
    _selectedDateBtn=thisButton;
    [thisButton setBackgroundImage:[UIImage imageNamed:@"month cal_focus_day"] forState:UIControlStateNormal];
    [DateCaculator share]._day=thisButton.titleLabel.text;
    [[DateCaculator share] resetSelectedDay];
    [self setDateForLabels];
}

-(void)setDateForLabels{
    NSDateFormatter *formatter=[NSDateFormatter getFormatterByFormateString:@"LLL yyyy"];
    [dateLabel setText:[formatter stringFromDate:[DateCaculator share].selectedDay]];
    // jeff said this label would not change
    if(isInitFlag){
        formatter=[NSDateFormatter getFormatterByFormateString:@"LLL dd, yyyy"];
        [dateSelectorLabel setText:[formatter stringFromDate:[NSDate date]]];
        isInitFlag=NO;
    }
}

#pragma mark - CalendarSelectorMethod
-(IBAction)slideLeftCalendarBar:(id)sender{
    [UIView beginAnimations:nil context:NULL];
	[UIView animateWithDuration:0.75f animations:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationBeginsFromCurrentState:YES];
    NSInteger m_xOffset=(isLeftOpen)?388:-388;
    
	c_leftCalendarView.center=CGPointMake(c_leftCalendarView.center.x+m_xOffset, c_leftCalendarView.center.y);
    
	[UIView commitAnimations];
    isLeftOpen=!isLeftOpen;
    
}
-(IBAction)slideRightCalendarBar:(id)sender{
    [UIView beginAnimations:nil context:NULL];
	[UIView animateWithDuration:0.75f animations:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationBeginsFromCurrentState:YES];
    NSInteger m_xOffset=(isRightOpen)?-388:388;
    
	c_rightCalendarView.center=CGPointMake(c_rightCalendarView.center.x+m_xOffset, c_rightCalendarView.center.y);
    
	[UIView commitAnimations];
    isRightOpen=!isRightOpen;
    
}

- (IBAction)msgClick:(id)sender {
    msgView.hidden = TRUE;
}
-(void)initSideCalendarView{
    c_leftCalendarView.frame=CGRectMake(388, 0, c_leftCalendarView.frame.size.width, c_leftCalendarView.frame.size.height);
    c_rightCalendarView.frame=CGRectMake(-388, 0, c_rightCalendarView.frame.size.width, c_rightCalendarView.frame.size.height);
    [p_leftCalendarView addSubview:c_leftCalendarView];
    [p_rightCalendarView addSubview:c_rightCalendarView];
    
}
-(void)constructSideCalerdarView{
    [self constructRightSideCalerdarView];
    [self constructLeftSideCalerdarView];
}
-(void)constructRightSideCalerdarView{
    [rightButtons removeAllObjects];
    [s_rightCalendarScrollView removeAllSubViews];
    
    //add button in c_rightCalendarView
    UIButton *rightButton;
    [s_rightCalendarScrollView setContentSize:CGSizeMake((60*12)+40, 56)];
    for (int i=1; i<=12; i++) {
        NSString *textString=[NSString stringWithFormat:@"%i",i+2007];
        rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame=CGRectMake(60*(i-1)+20, 8, 60, 40);
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [rightButton setTitle:textString forState:UIControlStateNormal];
        if([textString isEqualToString:[DateCaculator share]._year]){
            [rightButton setBackgroundImage:[FcDrawing loadUIImage:@"month cal_focus_year" withType:@"png"] forState:UIControlStateSelected];
            rightButton.selected=YES;
        }
        else
            [rightButton setBackgroundImage:nil forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(yearSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightButtons addObject:rightButton];
        [s_rightCalendarScrollView addSubview:rightButton];
    }
}
-(void)constructLeftSideCalerdarView{
    CGFloat xSpace=20.0f;
    [leftButtons removeAllObjects];
    [s_leftCalendarScrollView removeAllSubViews];
    
    //add button in c_leftCalendarView
    NSDateFormatter *formatter1=[NSDateFormatter getFormatterByFormateString:@"L"];
    NSDateFormatter *formatter2=[NSDateFormatter getFormatterByFormateString:@"LLL"];
    UIButton *leftButton;
    CGFloat xPosition=20.0f;
    //[s_leftCalendarScrollView setContentSize:CGSizeMake((50*12)+40, 56)];
    for (int i=1; i<=12; i++) {
        NSString *textString=[formatter2 stringFromDate:[formatter1 dateFromString:[NSString stringWithFormat:@"%i",i]]];
        
        leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        //leftButton.frame=CGRectMake(50*(i-1)+20, 8, 50, 40);
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [leftButton setTitle:textString forState:UIControlStateNormal];
        
        CGSize _btnSize=[Tools estimateStringSize:leftButton.titleLabel.text withFontSize:leftButton.titleLabel.font.pointSize];
        [leftButton setFrame:CGRectMake(xPosition, 8, _btnSize.width+xSpace, 40)];
        xPosition+=_btnSize.width+xSpace;
        [leftButton setBackgroundImage:[TUNinePatchCache imageOfSize:ccs(_btnSize.width+xSpace, 40)forNinePatchNamed:@"cal_focus"] forState:UIControlStateSelected];
        [leftButton setBackgroundImage:nil forState:UIControlStateNormal];
        if([textString isEqualToString:[DateCaculator share]._month])
            [leftButton setSelected:YES];
        else
            [leftButton setSelected:NO];
        
        [leftButton addTarget:self action:@selector(monthSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [leftButtons addObject:leftButton];
        [s_leftCalendarScrollView addSubview:leftButton];
    }
    [s_leftCalendarScrollView setContentSize:ccs(xPosition, s_leftCalendarScrollView.frame.size.height)];
}
-(IBAction)yearSelectAction:(id)sender{
    UIButton *btn=(UIButton*)sender;
    [DateCaculator share]._year=btn.titleLabel.text;
    [[DateCaculator share] resetSelectedDay];
    [self constructRightSideCalerdarView];
    [self constructMainCalendarView];
    [self setDateForLabels];
}
-(IBAction)monthSelectAction:(id)sender{
    UIButton *btn=(UIButton*)sender;
    [DateCaculator share]._month=btn.titleLabel.text;
    [[DateCaculator share] resetSelectedDay];
    [self constructLeftSideCalerdarView];
    [self constructMainCalendarView];
    [self setDateForLabels];
}

@end
