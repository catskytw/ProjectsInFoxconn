//
//  PersonalEventInfoViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PersonalEventInfoViewController.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "DateUtilty.h"
#import "FeatureCtrlCollections.h"
#import "MapViewController.h"
@implementation PersonalEventInfoViewController
@synthesize startTimeLabel;
@synthesize endTimeLabel;
@synthesize scrollView;
@synthesize locationLabel;
@synthesize statusLabel;
@synthesize remarkLabel;
@synthesize titleLabel;
@synthesize seperateImg;
@synthesize eventId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
- (void)viewDidAppear:(BOOL)animated{
    //NSLog(@"viewWillApper");
    [self initData];

    
}

-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"eventInfo",nil);
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:seperateImg.frame.size forNinePatchNamed:@"bg_line"]];
    
    [startTimeLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [endTimeLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [locationLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [statusLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    
    [self setBackItem:AMLocalizedString(@"back",nil)];
    [self setRightItem:AMLocalizedString(@"pathguide", nil)];
    
}
-(void) initData{
    
#ifdef TESTDATA
    remarkLabel.text = @"網路上無奇不有！什麼都有什麼都不奇怪，這兩天在刷機界中最夯的就是剛被流出的 hTC SENSE 3.5 ROM，一開始釋出的是 hTC Bliss/Rhyme，而現在連 Runnymede 都被弄出來了！看到新玩意出來不刷一下，手可是會癢到不知該放哪裡好呢！剛好 BoxmaXMccM 推出了 SD 版的 SENSE 3.5，可以直接丟進 htc HD2 的記憶卡來玩不會動到原生的系統，不測試一下真的說不過去了。就讓我們來看看 SENSE 3.5 做了哪些改變吧!(此為流出版本，可能會與最終手機出貨版本不同！)請注意，此 ROM 僅為 hTC HD2 使用，其他手機需自行去尋找對應的 ROM。下載連結：[BoxmaXMccM S3.5 v3.0][MixTheme v3.0]設計小幅更動：更好的利用螢幕空間";
    
    CGSize infoSize = [remarkLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:14.0f] constrainedToSize:CGSizeMake(remarkLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
    //[Tools estimateStringSize:infoLabel.text withFontSize:14];
    remarkLabel.frame = CGRectMake(remarkLabel.frame.origin.x, remarkLabel.frame.origin.y, infoSize.width, infoSize.height);
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, remarkLabel.frame.origin.y+infoSize.height)];
    titleLabel.text = @"test11";
    startTimeLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_start",nil),@"time test"];
    endTimeLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_end",nil),@"time test"];
    locationLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_location",nil),@"time test"];
    statusLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_status",nil),@"time test"];
#else
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getPersonalEventById(loginDO.sessionId, eventId)];
    //{"response":"0","personalEvent":{"id":"76A6916C-6DD2-4841-8B7B-72928E8E85AB","startDate":"Timestamp(102033968)","title":"鴻海科技","location":"TB002","endDate":"Timestamp(102034512)"}}
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            titleLabel.text = [Query getValue:@"title" withIndex:0];
            startTimeLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_start",nil), [DateUtilty dateStringFull:[UITuneLayout getTimestamp:[Query getValue:@"startDate" withIndex:0] withKey:@"timestamp"]]];
            endTimeLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_end",nil),[DateUtilty dateStringFull:[UITuneLayout getTimestamp:[Query getValue:@"endDate" withIndex:0]withKey:@"timestamp"]]];
            locationLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_location",nil),[Query getValue:@"location" withIndex:0]];
            statusLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"eventInfo_status",nil),[UITuneLayout checkQueryStr:[Query getValue:@"status" withIndex:0]]];
            remarkLabel.text = [UITuneLayout checkQueryStr:[Query getValue:@"notes" withIndex:0]];
            
            thisLocation.locationId=[Query getValue:@"locationId" withIndex:0];
            thisLocation.mapId=[Query getValue:@"mapId" withIndex:0];
            thisLocation.name=[Query getValue:@"name" withIndex:0];
            //依據標題長度調整位置 
            CGSize titleSize = [titleLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:22.0f] constrainedToSize:CGSizeMake(ContentWidth,500000) lineBreakMode:UILineBreakModeWordWrap];
            
            CGRect cgTitle =  CGRectMake(LeftMargin, TopMargin, ContentWidth, titleSize.height);
            
            CGRect cgStartDate = CGRectMake(LeftMargin, cgTitle.origin.y+cgTitle.size.height+ContentSpacingVertical2, ContentWidth, 14.0f);
            
            CGRect cgEndDate = CGRectMake(LeftMargin, cgStartDate.origin.y+cgStartDate.size.height+ContentSpacingVertical2, ContentWidth, 14.0f);
            
            CGRect cgLocation = CGRectMake(LeftMargin, cgEndDate.origin.y+cgEndDate.size.height+ContentSpacingVertical2, ContentWidth, 14.0f);
            
            CGRect cgStatus = CGRectMake(LeftMargin, cgLocation.origin.y+cgLocation.size.height+ContentSpacingVertical2, ContentWidth, 14.0f);
            
            CGRect cgSeperate = CGRectMake(0, cgStatus.origin.y+cgStatus.size.height+ContentSpacingVertical1, ScreenWidth, 2);
            
            //NSLog(@"remark width %f",remarkLabel.frame.size.width);
            CGSize infoSize = [remarkLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:14.0f] constrainedToSize:CGSizeMake(ContentWidth,500000) lineBreakMode:UILineBreakModeWordWrap];
            
            titleLabel.frame = cgTitle;
            startTimeLabel.frame = cgStartDate;
            endTimeLabel.frame = cgEndDate;
            locationLabel.frame = cgLocation;
            statusLabel.frame = cgStatus;
            seperateImg.frame = cgSeperate;
            
            //NSLog(@"infoSize width %f %f",infoSize.width , infoSize.height);
            remarkLabel.frame = CGRectMake(remarkLabel.frame.origin.x, cgSeperate.origin.y+cgSeperate.size.height+ContentSpacingVertical1, ContentWidth, infoSize.height);
            [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, remarkLabel.frame.origin.y+infoSize.height)];
        }else{
            
        }
        
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [Query release];
        
    }

#endif

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    thisLocation=[LocationInfoObject new];
    [self setUIDefault];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [thisLocation release];
    [self setScrollView:nil];
    [self setStartTimeLabel:nil];
    [self setEndTimeLabel:nil];
    [self setLocationLabel:nil];
    [self setStatusLabel:nil];
    [self setRemarkLabel:nil];
    [self setTitleLabel:nil];
    [self setSeperateImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [scrollView release];
    [startTimeLabel release];
    [endTimeLabel release];
    [locationLabel release];
    [statusLabel release];
    [remarkLabel release];
    [titleLabel release];
    [seperateImg release];
    [super dealloc];
}
-(void)rightItemAction:(id)sender{
    [[FeatureCtrlCollections current] loadMapData:[thisLocation.mapId intValue]];
    MapViewController *map=[MapViewController current];
    [map settingFloor:[thisLocation.mapId intValue]];
    [map setBackItem:self.title];
    
    [self.navigationController pushViewController:map animated:YES];
    [map showExhibitorInfo:thisLocation.locationId isFacility:NO];
}
@end