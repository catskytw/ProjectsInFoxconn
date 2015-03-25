  //
//  OveMeetingListCtrl.m
//  OveExpo
//
//  Created by  on 11/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OveMeetingListCtrl.h"
//#import "OveMeetingListCell.h"
#import "OveMeetingListCell2.h"
//#import "OveMeetingDetailCtrl.h"
#import "OveMeetingDetailCtrl2.h"
#import "Meeting.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "PSListDataObject1.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "DateUtilty.h"

//#define MY_TEST YES

@interface OveMeetingListCtrl(PrivateMethod)
- (void) prepareData;
- (NSArray *) _getMeetingsWithRoom;
- (NSArray *) _getMeetingsWithDate;
- (NSArray *) _getMeetingsList;
- (NSArray *) _getMyJoinedMeetings;//ps. 資訊整併到_getMeetingsWithXXX
- (NSString *) _fcStamp2Time:(double) timestamp;
- (NSString *) _fcStamp2Date:(double) timestamp;
@end

@implementation OveMeetingListCtrl

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDate:(NSString *)_date
{
    date = [_date retain];
    
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithRoom:(NSString *)_room withDate:(NSString*)_date
{
    room = [_room retain];
    
    return [self initWithDate:_date];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Utilities
- (NSString *) _fcStamp2Time_org:(double) timestamp
{
    NSDate *_time = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDate* _time2 = [ [ NSDate alloc] initWithString:@"2520-9-26 17:10:00 +0600" ];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit|NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:_time];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"] ];
    int year = [components year];
    int month = [components month];
    int day = [components day];
    int hour = [components hour];
    int minute = [components minute];
    

    NSString *_hour_str=nil;
    if (hour < 10) {
        _hour_str = [NSString stringWithFormat:@"0%d",hour];
    }
    else
    {
        _hour_str = [NSString stringWithFormat:@"%d",hour];
    }
    
    NSString *_minute_str=nil;
    if (minute < 10) {
        _minute_str = [NSString stringWithFormat:@"0%d",minute];
    }
    else
    {
        _minute_str = [NSString stringWithFormat:@"%d",minute];
    }
    
    return [NSString stringWithFormat:@"%@:%@", _hour_str, _minute_str];
}

- (NSString *) _fcStamp2Time:(double) timestamp
{
    NSDate *_time = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //NSDate* _time2 = [ [ NSDate alloc] initWithString:@"2520-9-26 17:10:00 +0600" ];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"HH:mm"];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"] ];
    NSString *correctDate = [formatter stringFromDate:_time];
    //[formatter release];
    return correctDate;
}

- (NSString *) _fcStamp2Date:(double) timestamp
{
    NSDate *_time = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //NSDate* _time2 = [ [ NSDate alloc] initWithString:@"2520-9-26 17:10:00 +0600" ];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"] ];
    NSString *correctDate = [formatter stringFromDate:_time];
    return correctDate;
}

#pragma mark - View lifecycle
-(void)setBackButton{
    backButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	backButton.frame = CGRectMake(10.0, 7.0,60, 30);
    backButton.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [backButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:backButton.frame.size forNinePatchNamed:@"btn_back"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:backButton.frame.size forNinePatchNamed:@"btn_back_i"] forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backButton];
    
    //[backButton setTitle:AMLocalizedString(@"date",nil) forState:UIControlStateNormal];
    [backButton setTitle:AMLocalizedString(@"meeting_schedule_room",nil)/*@"會議室"*/ forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}
-(void)backAction:(id)sender{
	
	if(sender == backButton){
        [backButton removeFromSuperview];
        [backButton release];
		[self.navigationController popViewControllerAnimated:YES];		
	}
	
}
-(void)leftItemAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self prepareData];
    //[self setBackButton];
    [[self navigationItem]setHidesBackButton:YES];
    [[self navigationController] setNavigationBarHidden:NO];
    [self setTitle:AMLocalizedString(@"meeting_schedule_title",nil)/*@"會議時程表"*/];
    [UITuneLayout setNaviTitle:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[self navigationController] popToViewController:self animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated
{
    [self prepareData];
    [mettingsTable reloadData];
}

- (void) prepareData
{
    
    meetings = [[self _getMeetingsList]retain];
}

- (NSArray *) _getMeetingsList
{
    NSArray *returnArray = nil;
    if (MY_TEST == YES) {
        NSMutableArray *_testArray = [[[NSMutableArray alloc]init]autorelease];
        
        for (int i=0; i<10; i++) {
            Meeting *_meeting = [[Meeting alloc]init];
            [_meeting setTitle:[NSString stringWithFormat:@"中國光谷會議"]];
            [_meeting setMeetingId:@"1234567"];
            //[_meeting setTimeFrom:@"13:01"];
            NSString *_time_str = @"Timestamp(1320163200000)";
            _time_str = [_time_str substringFromIndex:10];
            _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
            NSTimeInterval _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
            _meeting.timeFrom = [self _fcStamp2Date:_time_double/1000];
            [_meeting setTimeTo:@"2011/09/11"];
            [_meeting setLocation:@"A501會議室"];
            [_meeting setIsJoined:YES];
            [_meeting setJoinStatus:@"CR"];
            [_meeting setMeetingType:SCHEDULE_TYPE_CONFERENCE];
            [_testArray addObject:[_meeting autorelease]];
        }
        returnArray = [_testArray retain];
    }
    else
    {
        //XXXX
        //NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            //XXXX : Convert date str(eg. 2011/01/01 to timestamp)
            /*if (room == nil || date == nil) {
                NSLog(@"Warning : room or date is nil...");
                return nil;
            }*/
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            NSString *_queryUrl = getMeetingsList(_login.sessionId);
            _queryUrl = [_queryUrl stringByAppendingFormat:@"&rnd=%i",arc4random()];
            [query prepareDic:_queryUrl];
            NSInteger num=[query getNumberUnderNode:@"conferenceList" withKey:@"id"];
            for(int i=0;i<num;i++){
                Meeting *_meeting = [[Meeting alloc]init];
                _meeting.meetingId = [query getValueUnderNode:@"conferenceList" withKey:@"id" withIndex:i];
                _meeting.title = [query getValueUnderNode:@"conferenceList" withKey:@"title" withIndex:i];
                
                //_meeting.timeFrom = [query getValueUnderNode:@"sessionList" withKey:@"startDate" withIndex:i];
                NSString *_time_str = [query getValueUnderNode:@"conferenceList" withKey:@"startDate" withIndex:i];//Need to filter the value from format "timestamp(XXXXXXX)".
                _time_str = [_time_str substringFromIndex:10];
                _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
                NSTimeInterval _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
                //_meeting.timeFrom = [self _fcStamp2Date:_time_double/1000];
                _meeting.timeFrom = [DateUtilty dateString:_time_str];
                
                //_meeting.timeTo = [query getValueUnderNode:@"sessionList" withKey:@"endTime" withIndex:i];
                _time_str = [query getValueUnderNode:@"conferenceList" withKey:@"endDate" withIndex:i];//Need to filter the value from format "timestamp(XXXXXXX)".
                _time_str = [_time_str substringFromIndex:10];
                _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
                _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
                //_meeting.timeTo = [self _fcStamp2Date:_time_double/1000];
                _meeting.timeTo = [DateUtilty dateString:_time_str];
                _meeting.joinName = [query getValueUnderNode:@"conferenceList" withKey:@"statusName" withIndex:i];
                NSString *_status = nil;
                //_status = [query getValueUnderNode:@"conferenceList" withKey:@"status" withIndex:i];
                _status = [query getValueFromNodeString:[NSString stringWithFormat:@"conferenceList[%d].status",i]];//!!!!:若欄位沒有值時server不提供欄位, 則需要用這種方式確保欄位的順序問題.
                _meeting.joinStatus = nil;
                NSLog(@"meetingId=%@, _status = %@",_meeting.meetingId, _status);
                if (_status!=[NSNull null] && [_status isEqualToString:@"-"] == NO) {
                    _meeting.isJoined = YES;
                    [_meeting setJoinStatus:_status];
                }
                else
                {
                    _meeting.isJoined = NO;
                }
                
                [tmpArray addObject:_meeting];
            }
            returnArray = [tmpArray retain];
            [query release];
            //[_date release];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
        }
    }
    
    return [returnArray autorelease];
}

- (NSArray *) _getMeetingsWithRoom
{
    NSArray *returnArray = nil;
    if (MY_TEST == YES) {
        NSMutableArray *_testArray = [[[NSMutableArray alloc]init]autorelease];
        
        for (int i=0; i<10; i++) {
            Meeting *_meeting = [[Meeting alloc]init];
            [_meeting setTitle:[NSString stringWithFormat:@"%@-%d",room,i]];
            [_meeting setMeetingId:@"1234567"];
            //[_meeting setTimeFrom:@"13:01"];
            NSString *_time_str = @"Timestamp(1320163200000)";
            _time_str = [_time_str substringFromIndex:10];
            _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
            NSTimeInterval _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
            _meeting.timeFrom = [self _fcStamp2Time:_time_double/1000];
            [_meeting setTimeTo:@"15:01"];
            [_meeting setLocation:@"A502"];
            [_meeting setIsJoined:YES];
            [_meeting setMeetingType:SCHEDULE_TYPE_CONFERENCE];
            [_testArray addObject:[_meeting autorelease]];
        }
        returnArray = [_testArray retain];
    }
    else
    {
        //XXXX
        //NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            //XXXX : Convert date str(eg. 2011/01/01 to timestamp)
            if (room == nil || date == nil) {
                NSLog(@"Warning : room or date is nil...");
                return nil;
            }
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            NSString *_date = [date retain];//XXXX : need to convert to timestamp.(ps. fixed, but need to verify)
            //[query prepareDic:getMeetingsWithRoom(_login.sessionId, _date, room)];
            NSString *_queryUrl_org = getMeetingsWithRoom(_login.sessionId,_date, room);
            NSLog(@"query org : %@", _queryUrl_org);
            NSString *_queryUrlString = [_queryUrl_org stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"query : %@", _queryUrlString);
            [query prepareDic:_queryUrlString];
            //NSInteger num=[query getNumberForKey:@"meetingsList"];
            //NSLog(@"query result : %@", [query getJSONRawResult:getMeetingsWithRoom(_date, room)]);
            NSInteger num=[query getNumberUnderNode:@"sessionList" withKey:@"id"];
            //NSDictionary* eventData=(NSDictionary*)[query getObjectUnderNode:@"sessionList" withIndex:i];
            for(int i=0;i<num;i++){
                Meeting *_meeting = [[Meeting alloc]init];
                _meeting.meetingId = [query getValueUnderNode:@"sessionList" withKey:@"id" withIndex:i];
                _meeting.title = [query getValueUnderNode:@"sessionList" withKey:@"title" withIndex:i];
                _meeting.subTitle = [query getValueUnderNode:@"sessionList" withKey:@"subTitle" withIndex:i];
                
                //_meeting.timeFrom = [query getValueUnderNode:@"sessionList" withKey:@"startDate" withIndex:i];
                //NSString *_time_str = [query getValueUnderNode:@"sessionList" withKey:@"startDate" withIndex:i];//Need to filter the value from format "timestamp(XXXXXXX)".
                NSString *_time_str = @"Timestamp(1320163200000)";
                _time_str = [_time_str substringFromIndex:10];
                _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
                NSTimeInterval _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
                _meeting.timeFrom = [self _fcStamp2Time:_time_double/1000];
                
                //_meeting.timeTo = [query getValueUnderNode:@"sessionList" withKey:@"endTime" withIndex:i];
                _time_str = [query getValueUnderNode:@"sessionList" withKey:@"endDate" withIndex:i];//Need to filter the value from format "timestamp(XXXXXXX)".
                _time_str = [_time_str substringFromIndex:10];
                _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
                _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
                _meeting.timeTo = [self _fcStamp2Time:_time_double/1000];
                
                _meeting.joinStatus = [query getValueUnderNode:@"sessionList" withKey:@"status" withIndex:i];//XXXX : change string to bool.(fixed)
                _meeting.location = room;
                _meeting.meetingType = SCHEDULE_TYPE_CONFERENCE;//XXXX
                //[tmpArray addObject:[_meeting autorelease]];
                [tmpArray addObject:_meeting];
            }
            returnArray = [tmpArray retain];
            //[_date release];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
        }
    }
    
    return [returnArray autorelease];
}

- (NSArray *) _getMeetingsWithDate
{
    NSArray *returnArray = nil;
    if (MY_TEST == YES) {
        NSMutableArray *_testArray = [[[NSMutableArray alloc]init]autorelease];
        
        for (int i=0; i<10; i++) {
            Meeting *_meeting = [[Meeting alloc]init];
            NSTimeInterval _date_double = [date doubleValue];
            NSDate *_date=[NSDate dateWithTimeIntervalSince1970:_date_double];
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:_date];
            int year = [components year];
            int month = [components month];
            int day = [components day];    
            NSString *_date_display = [NSString stringWithFormat:@"%d年 %d月 %d日", year, month, day];
            [_meeting setTitle:[NSString stringWithFormat:@"%@-%d",_date_display,i]];
            [_meeting setMeetingId:@"1234567"];
            [_meeting setTimeFrom:@"13:00"];
            [_meeting setTimeTo:@"15:00"];
            [_meeting setLocation:@"A501"];
            [_meeting setMeetingType:SCHEDULE_TYPE_CONFERENCE];
            [_meeting setIsJoined:YES];
            [_meeting setJoinStatus:@"CR"];
            [_testArray addObject:[_meeting autorelease]];
        }
        returnArray = _testArray;
    }
    else
    {
        //XXXX
        NSMutableArray *tmpArray = [[[NSMutableArray alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            //XXXX : Convert date str(eg. 2011/01/01 to timestamp)
            if (date == nil) {
                NSLog(@"Warning : room or date is nil...");
                return nil;
            }
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            NSString *_date = [date retain];//XXXX : need to convert to timestamp.(ps. fixed, but need to verify)
            [query prepareDic:getMeetingsWithDate(_login.sessionId, _date)];
            NSInteger num=[query getNumberForKey:@"conferenceList"];
            for(int i=0;i<num;i++){
                NSDictionary* eventData=(NSDictionary*)[query getObjectUnderNode:@"meetingsList" withIndex:i];
                Meeting *_meeting = [[Meeting alloc]init];
                _meeting.meetingId = [eventData valueForKey:@"id"];
                _meeting.title = [eventData valueForKey:@"title"];
                _meeting.subTitle = [eventData valueForKey:@"subTitle"];
                
               // _meeting.timeFrom = [eventData valueForKey:@"startTime"];
                NSString *_time_str = [eventData valueForKey:@"startDate"];//Need to filter the value from format "timestamp(XXXXXXX)".
                _time_str = [_time_str substringFromIndex:10];
                _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
                
                _meeting.timeTo = [eventData valueForKey:@"endTime"];
                _meeting.joinStatus = [eventData valueForKey:@"status"];//XXXX : change string to bool.(fixed)
                _meeting.joinName = [eventData valueForKey:@"joinName"];
                [tmpArray addObject:[_meeting autorelease]];
            }
            returnArray = tmpArray ;
            [_date release];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
            [tmpArray release];
        }
    }
    
    return returnArray;
}

-(void) dealloc
{
    [super dealloc];
    [mettingsTable release];
    [detailView release];
    [date release];
    [room release];
    [meetings release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableView
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*static NSString *CellIdentifier = @"OveMeetingListCell";
	OveMeetingListCell *cell = (OveMeetingListCell *)[mettingsTable dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"OveMeetingListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[OveMeetingListCell class]]){
                cell=(OveMeetingListCell*)currentObject;
                break;
            }
        }
        
	}*/
    static NSString *CellIdentifier = @"OveMeetingListCell2";
	OveMeetingListCell2 *cell = (OveMeetingListCell2 *)[mettingsTable dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"OveMeetingListCell2" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[OveMeetingListCell2 class]]){
                cell=(OveMeetingListCell2*)currentObject;
                [cell setUIDefault];
                break;
            }
        }
	}
    
    //Set cell text
    Meeting *meeting = [meetings objectAtIndex:indexPath.row];
    PSListDataObject1 *dao = [[PSListDataObject1 alloc]init];
    dao.startTime = [NSString stringWithFormat:@"%@ - %@",meeting.timeFrom, meeting.timeTo];
    //dao.endTime = meeting.timeTo;
    if (meeting.isJoined == YES) {
        dao.bookingStatus = BOOKING_STATUS_BOOKED;
    }
    else
    {
        dao.bookingStatus = BOOKING_STATUS_BOOKING;
    }
    dao.name = meeting.title;
    dao.location = meeting.location;
    //dao.type = meeting.meetingType;
    [cell setDO:dao];
    
    
    if ([meeting.joinStatus isEqualToString:@"CR"]) {
        UIImage *_typeImg = [[UIImage imageNamed:@"ic_addtoschedule.png"]autorelease];
        [[cell typeImg] setImage:_typeImg];
        [[cell typeImg] setFrame:CGRectMake([cell typeImg].frame.origin.x , [cell typeImg].frame.origin.y, _typeImg.size.width, _typeImg.size.height)];
    }
    else if([meeting.joinStatus isEqualToString:@"CC"])
    {
        UIImage *_typeImg = [[UIImage imageNamed:@"ic_addtoschedule_check.png"]autorelease]; 
        [[cell typeImg] setImage:_typeImg]; 
        [[cell typeImg] setFrame:CGRectMake([cell typeImg].frame.origin.x , [cell typeImg].frame.origin.y, _typeImg.size.width, _typeImg.size.height)];
    }
	return cell;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *thisCell=[mettingsTable cellForRowAtIndexPath:indexPath];
    return [thisCell frame].size.height;
    //return 63.0f;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Meeting *_meeting = [meetings objectAtIndex:indexPath.row];
    OveMeetingDetailCtrl2 *_detailView = [[OveMeetingDetailCtrl2 alloc] initWithMeetingId:_meeting.meetingId];
    [_detailView setBackItem:AMLocalizedString(@"meeting_schedule_meeting_list",nil)];
    //[_detailView setRightItem:AMLocalizedString(@"meeting_schedule_path",nil)];
    [[self navigationController] pushViewController:_detailView animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSInteger row_count = 0;
    row_count = [meetings count];
    return row_count;
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section_count = 0;
	return section_count;//plus 1 is for user undefined group
}

- (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)sectionIndex
{
	return nil;
}*/


@end
