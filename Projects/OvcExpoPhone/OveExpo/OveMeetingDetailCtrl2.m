//
//  OveMeetingDetailCtrl.m
//  OveExpo
//
//  Created by  on 11/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "OveMeetingDetailCtrl2.h"
#import "Meeting.h"
#import "QueryPattern.h"
#import "FcConfig.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "LoginDataObject.h"
#import "MapViewController.h"
#import "FeatureCtrlCollections.h"
#import "DateUtilty.h"
//#define MY_TEST YES

@interface OveMeetingDetailCtrl2(PrivateMethod)
- (void) prepareData;
- (BOOL) _joinMeeting:(NSString *)result;
- (Meeting *) _getMeetingDetail;
- (NSString *) _fcStamp2DateTime:(double) timestamp;
- (NSString *) _fcStamp2Date:(double) timestamp;
@end

@implementation OveMeetingDetailCtrl2
@synthesize isJoined, joinName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMeetingId:(NSString *)_meetingId
{
    meetingId = [_meetingId retain];
    return [self initWithNibName:nil bundle:nil];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) dealloc
{
    [super dealloc];
    [meeting release];
    [backButton removeFromSuperview];
    [editButton removeFromSuperview];
    [backButton release];
    [editButton release];
}

#pragma mark - View lifecycle
//會議沒有導灠
-(void)rightItemAction:(id)sender
{
    [[FeatureCtrlCollections current] loadMapData:A_3F];
    MapViewController *mapView=[MapViewController current];
    [mapView settingFloor:A_3F];
    [mapView setBackItem:self.title];
    
    //TODO 設定樓層,攤位
    [self.navigationController pushViewController:mapView animated:YES];
    [mapView showExhibitorInfo:@"0"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self navigationController]setNavigationBarHidden:NO];
    [self prepareData];
    //*** setup navigation bar
    //[[[self navigationController] view] addSubview:editButton];
    //[self setEditButton];
    //[self.navigationController.view addSubview:backButton];
    //[self setBackButton];
    [[self navigationItem]setHidesBackButton:YES];
    [self setTitle:AMLocalizedString(@"meeting_schedule_title",nil)/*@"會議時程表"*/];
    [UITuneLayout setNaviTitle:self];
    
    //[title_1 setText:meeting.title];
    [title_1 setText:meeting.title];
    
    //CGSize stringSize = [Tools estimateStringSize:meeting.title withFontSize:22.0f];
    //CGSize stringSize = [[title_1 text] sizeWithFont:[title_1 font]];
    CGSize stringSize = [meeting.title sizeWithFont:title_1.font constrainedToSize:CGSizeMake(title_1.frame.size.width,title_1.font.lineHeight*2) lineBreakMode:UILineBreakModeWordWrap];
    [title_1 setFrame:CGRectMake(title_1.frame.origin.x, title_1.frame.origin.y, title_1.frame.size.width, stringSize.height)];
    [title_1 setText:meeting.title];
    
    [timeLabel setText:[NSString stringWithFormat:@"%@：%@",AMLocalizedString(@"meeting_schedule_time_start",nil)/*@"時間"*/, meeting.timeFrom]];
    [timeLabel2 setText:[NSString stringWithFormat:@"%@：%@",AMLocalizedString(@"meeting_schedule_time_end",nil)/*@"時間"*/, meeting.timeTo]];
    [speakerLabel setText:[NSString stringWithFormat:@"%@：%@",AMLocalizedString(@"主講人",nil)/*@"主講人"*/, meeting.speaker]];
    [locationLabel setText:[NSString stringWithFormat:@"%@：%@",AMLocalizedString(@"meeting_schedule_location",nil)/*@"地點"*/, meeting.location]];
    [scaleLabel setText:[NSString stringWithFormat:@"%@：%@",AMLocalizedString(@"meeting_schedule_scale",nil)/*@"規模"*/, meeting.scale]];
    
    //[content_view setText:meeting.desc];
    CGSize contentSize = [meeting.desc sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16] constrainedToSize:CGSizeMake(contentLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
    [contentLabel setText:meeting.desc];
    [contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentSize.width, contentSize.height)];
    
    //[joinBt setFrame:CGRectMake(0 , 0, joinBt.frame.size.width, joinBt.frame.size.height)];
    [joinBt setTitle:AMLocalizedString(@"報名會議",nil) forState:UIControlStateNormal];
    [joinBt setBackgroundImage:[TUNinePatchCache imageOfSize:joinBt.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [joinBt setBackgroundImage:[TUNinePatchCache imageOfSize:joinBt.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [joinBt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [joinBt setEnabled:NO];//XXXX : 此功能被要求暫時關掉, 因為已經先使用人工方式報名了.
    [buttons_view_bg setImage:[TUNinePatchCache imageOfSize:buttons_view_bg.frame.size forNinePatchNamed:@"bg_black"]];
    [buttons_view_spliter setImage:[TUNinePatchCache imageOfSize:buttons_view_spliter.frame.size forNinePatchNamed:@"bg_line"]];
    [top_sub_view setFrame:CGRectMake(top_sub_view.frame.origin.x, title_1.frame.origin.y+title_1.frame.size.height+9, top_sub_view.frame.size.width, top_sub_view.frame.size.height)];
    [separateLine setFrame:CGRectMake(0, top_sub_view.frame.origin.y+top_sub_view.frame.size.height+14, separateLine.frame.size.width, separateLine.frame.size.height)];
    [contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, top_sub_view.frame.origin.y+top_sub_view.frame.size.height+28, contentLabel.frame.size.width, contentLabel.frame.size.height)];
    
    [baseScroll setContentSize:CGSizeMake(baseScroll.contentSize.width, contentLabel.frame.origin.y + contentLabel.frame.size.height)];
    NSLog(@"reach : joinStatus=%@", meeting.joinStatus);
    if ((meeting.joinStatus!=nil) && ![meeting.joinStatus isEqualToString:@"-"]) {
        NSLog(@"joinName = %@...", meeting.joinName);
        [joinBt setTitle:meeting.joinName forState:UIControlStateNormal];
        [joinBt setEnabled:NO];
    }
    
    [separateLine setImage:[TUNinePatchCache imageOfSize:buttons_view_spliter.frame.size forNinePatchNamed:@"bg_line"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self.navigationController popViewControllerAnimated:YES];
    [self release];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationItem] setHidesBackButton:YES];
    //[self setBackButton];
}

-(void)viewDidDisappear:(BOOL)animated
{
    /*[backButton setHidden:YES];
     [editButton setHidden:YES];*/
    [backButton removeFromSuperview];
    [editButton removeFromSuperview];
    [backButton release];
    [editButton release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)ui_joinMeeting:(id)sender
{
    NSLog(@"ui_joinMeeting is trigger...");
    NSString *result = [[NSString alloc]init];
    if([self _joinMeeting:result] == YES)
    {
        UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"報名會議",nil) message:AMLocalizedString(@"成功",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
        //[self viewDidLoad];
        if (meeting != nil) {
            [meeting release];
        }
        meeting = [self _getMeetingDetail];
        if (![meeting.joinStatus isEqualToString:@"-"]) {
            NSLog(@"joinName = %@...", meeting.joinName);
            [joinBt setTitle:meeting.joinName forState:UIControlStateNormal];
            [joinBt setEnabled:NO];
        }
        else
        {
            [joinBt setTitle:AMLocalizedString(@"參加會議",nil) forState:UIControlStateNormal];
            [joinBt setEnabled:YES];
        }
        [_alert show];
        [_alert release];
    }
    else
    {
        //UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:@"報名會議" message:[NSString stringWithFormat:@"失敗:%@",result] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
        NSLog(@"ui_joinMeeting : result = %@", joinMeeting_res);
        UIAlertView *_alert = [[UIAlertView alloc]initWithTitle:AMLocalizedString(@"報名會議",nil) message:[NSString stringWithFormat:@"%@:%@",AMLocalizedString(@"失敗",nil), joinMeeting_res] delegate:self cancelButtonTitle:AMLocalizedString(@"確定",nil) otherButtonTitles:nil];
        [_alert show];
        [_alert release];
    }
}

#pragma mark - Utilities
- (NSString *) _fcStamp2DateTime:(double) timestamp
{
    NSDate *_time = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //NSDate* _time2 = [ [ NSDate alloc] initWithString:@"2520-9-26 17:10:00 +0600" ];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"] ];
    NSString *correctDate = [formatter stringFromDate:_time];
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

- (void) prepareData
{
    meeting = [[self _getMeetingDetail] retain];
}

- (BOOL) _joinMeeting:(NSString *)result
{
    //XXXX
    BOOL r=NO;
    if (MY_TEST == YES) {
        r = NO;
        joinMeeting_res = @"test...";
    }
    else
    {
        LoginDataObject *_login = [LoginDataObject sharedInstance];
        QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        @try {
            if (meetingId == nil || _login.sessionId == nil) {
                NSLog(@"Warning : meetingID or sessionId is nil...");
                return r;
            }
            NSLog(@"_joinMeeting : (sessionId=%@, meetingId=%@)", _login.sessionId, meetingId);
            [query prepareDic:joinMetting(_login.sessionId, meetingId)];
            r=![[query getValue:@"response" withIndex:0] boolValue];
            if (r == NO) {
                joinMeeting_res = [query getValue:@"message" withIndex:0];
            }
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
        }
        
        [query release];
    }
    return r;
    
}

- (Meeting *) _getMeetingDetail
{
    Meeting *returnVal = nil;
    
    if (MY_TEST == YES) {
        Meeting *testVal = [[[Meeting alloc]init]autorelease];
        testVal.meetingId = @"1234567789";
        testVal.title = @"第九届“武汉中国光谷”";//one line
        //testVal.title = @"第九届“武汉中国光谷”知识产权保护国际论坛第九届“武汉中国光谷”知识产权保护国际论坛";//two line
        testVal.timeFrom = [self _fcStamp2Date:1320163200];
        testVal.timeTo = [self _fcStamp2Date:1320163200];
        testVal.speaker = @"Job Steve";
        testVal.location = @"A501會議室";
        testVal.scale = @"2000人";
        testVal.isJoined = NO;
        testVal.joinStatus=nil;
        testVal.joinName=@"未報名";
        testVal.desc = @"以“知识产权保护与经济转型”为主题，探讨知识产权在转变经济发展方式中的地位和作用；知识产权对提高经济发展质量和效益的贡献；加快经济发展方式转变的知识产权政策研究；知识产权对提高经济竞争力和抗风险能力的研究；知识产权与经济结构调整；知识产权与自主创新；知识产权与推进发展方式转变；知识产权与经济社会协调发展；知识产权与文化产业发展；知识产权与培育新的支柱产业；知识产权与培育战略性新兴产业；知识产权与推进区域经济协调发展；知识产权促进经济发展方式转变的成功案例等。";
        //returnVal = [testVal autorelease];
        returnVal = [testVal retain];
    }
    else
    {
        //XXXX : need to vierfy
        Meeting *_meeting = [[[Meeting alloc]init]autorelease];
        @try {
            QueryPattern *query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            if (meetingId == nil) {
                NSLog(@"Warning : meetingID is nil...");
                return nil;
            }
            LoginDataObject *_login = [LoginDataObject sharedInstance];
            NSString *_queryStr = getMeetingById(_login.sessionId, meetingId);
            _queryStr = [_queryStr stringByAppendingFormat:@"&rnd=%i",arc4random()];
            [query prepareDic:_queryStr];
            NSDictionary* eventData=(NSDictionary*)[query getObjectUnderNode:@"conference" withIndex:0];
            _meeting.meetingId = [eventData valueForKey:@"id"];
            _meeting.title = [eventData valueForKey:@"title"];
            
            //_meeting.timeFrom = [eventData valueForKey:@"startTime"];//XXXX : need to convert timestamp value.(ps. fixed need to verify.)
            NSString *_time_str = [eventData valueForKey:@"startDate"];//Need to filter the value from format "timestamp(XXXXXXX)".
            _time_str = [_time_str substringFromIndex:10];
            _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
            NSTimeInterval _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
            //_meeting.timeFrom = [self _fcStamp2DateTime:_time_double/1000];
            _meeting.timeFrom = [DateUtilty dateStringFull:_time_str];
            
            //_meeting.timeTo = [eventData valueForKey:@"endTime"];//XXXX : need to convert timestamp value.(ps. fixed need to verify.)
            _time_str = [eventData valueForKey:@"endDate"];//Need to filter the value from format "timestamp(XXXXXXX)".
            _time_str = [_time_str substringFromIndex:10];
            _time_str = [_time_str substringToIndex:(_time_str.length - 1)];
            _time_double = [_time_str doubleValue];//XXXX : need to convert timestamp value. (ps. fixed, but need to verify.)
            //_meeting.timeTo = [self _fcStamp2DateTime:_time_double/1000];
            _meeting.timeTo = [DateUtilty dateStringFull:_time_str];
            _meeting.speaker = [eventData valueForKey:@"speaker"];
            _meeting.location  = [eventData valueForKey:@"location"];
            _meeting.scale   = [eventData valueForKey:@"capacity"];
            _meeting.desc  = [eventData valueForKey:@"content"];
            NSString *_status = nil;
            _status = [eventData valueForKey:@"status"];
            
            if (_status!=[NSNull null] && [_status isEqualToString:@"-"] == NO) {
                _meeting.isJoined = YES;
                [_meeting setJoinStatus:_status];
            }
            else
            {
                _meeting.isJoined = NO;
            }
            
            _meeting.joinName = [eventData valueForKey:@"statusName"];
            returnVal = [_meeting retain];
            [query release];
        }
        @catch (NSException * e) {
            //NPLogException(e);
        }
        @finally {
        }
    }
    
    return returnVal;
}


@end
