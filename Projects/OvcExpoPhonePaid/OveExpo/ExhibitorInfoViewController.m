//
//  ExhibitroInfoViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorInfoViewController.h"

#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Tools.h"
#import "LoginDataObject.h"
#import "MapViewController.h"
#import "FeatureCtrlCollections.h"
@implementation ExhibitorInfoViewController
@synthesize placeLabel;
@synthesize websiteLabel;
@synthesize infoLabel;
@synthesize productLocationLabel;
@synthesize contentScroll;
@synthesize seperateImg;
@synthesize nameLable;
@synthesize addScheduleBtn;
@synthesize downloadBtn;
@synthesize bookingBtn;
@synthesize websiteBtn;
@synthesize imgIcon;
@synthesize pathGuideBtn;
@synthesize btnBgImg;
@synthesize exhibitorId;
@synthesize exhibitorName;
@synthesize iconUrl,location;
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

/*-(void)viewWillDisappear:(BOOL)animated{
    [self removeNaviBtn];
}*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    thisLocation=[LocationInfoObject new];
    [self setUIDefault];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.title = AMLocalizedString(@"exhibitors_info",nil);
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
#ifdef ISPAID
    bookingBtn.hidden = NO;
#endif
    [addScheduleBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:addScheduleBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [addScheduleBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:addScheduleBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [addScheduleBtn setTitle:AMLocalizedString(@"exhibitorinfo_addSchedule",nil) forState:UIControlStateNormal];
    [addScheduleBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [downloadBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:downloadBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:downloadBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [downloadBtn setTitle:AMLocalizedString(@"exhibitorinfo_download",nil) forState:UIControlStateNormal];
    [downloadBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [bookingBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:bookingBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [bookingBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:bookingBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [bookingBtn setTitle:AMLocalizedString(@"exhibitorinfo_booking",nil) forState:UIControlStateNormal];
    [bookingBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [pathGuideBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:pathGuideBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [pathGuideBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:pathGuideBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    [pathGuideBtn setTitle:AMLocalizedString(@"pathguide",nil) forState:UIControlStateNormal];
    [pathGuideBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    
    [websiteBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:websiteBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [websiteBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:websiteBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    
    [websiteBtn setTitle:AMLocalizedString(@"exhibitorinfo_btn_website",nil) forState:UIControlStateNormal];
    [websiteBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateHighlighted];
    [productLocationLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [placeLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [websiteLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:seperateImg.frame.size forNinePatchNamed:@"bg_line"]];
    
    [btnBgImg setImage:[TUNinePatchCache imageOfSize:btnBgImg.frame.size forNinePatchNamed:@"bg_black"]];
    
    UIImageView *seperateImg2 = [UIImageView new];
    [seperateImg2 setImage:[TUNinePatchCache imageOfSize:seperateImg.frame.size forNinePatchNamed:@"bg_line"]];
    seperateImg2.frame = CGRectMake(0, websiteLabel.frame.origin.y+ContentSpacingVertical1+ websiteLabel.frame.size.height, seperateImg.frame.size.width, seperateImg.frame.size.height);
    [contentScroll addSubview:seperateImg2];
    [seperateImg2 release];
     
    //[self addBackButton];
    //[self addEditButton];
    
}
-(void) initData{
    
    
    //[imgIcon setImage:[UIImage imageNamed:@"ic_floorplan.png"]];
    productLocationLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"exhibitorinfo_productlocation",nil),@"激光展區"];
    placeLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"exhibitorinfo_place",nil),@"BC-12334-9"];
    websiteLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"exhibitorinfo_website",nil),@"http://www.google.com.tw/"];
    infoLabel.text = @"網路上無奇不有！什麼都有什麼都不奇怪，這兩天在刷機界中最夯的就是剛被流出的 hTC SENSE 3.5 ROM，一開始釋出的是 hTC Bliss/Rhyme，而現在連 Runnymede 都被弄出來了！看到新玩意出來不刷一下，手可是會癢到不知該放哪裡好呢！剛好 BoxmaXMccM 推出了 SD 版的 SENSE 3.5，可以直接丟進 htc HD2 的記憶卡來玩不會動到原生的系統，不測試一下真的說不過去了。就讓我們來看看 SENSE 3.5 做了哪些改變吧!(此為流出版本，可能會與最終手機出貨版本不同！)請注意，此 ROM 僅為 hTC HD2 使用，其他手機需自行去尋找對應的 ROM。下載連結：[BoxmaXMccM S3.5 v3.0][MixTheme v3.0]設計小幅更動：更好的利用螢幕空間";
    //infoLabel.text = @"網路上無奇不有！什麼都有什麼都不奇怪，";

#ifndef TESTDATA
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getExhibitorById(loginDO.sessionId, exhibitorId)];
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            
            productLocationLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"exhibitorinfo_productlocation",nil),[Query getValue:@"area" withIndex:0]];
            location = [[NSString stringWithFormat:@"%@",[Query getValue:@"booth" withIndex:0]] copy];
            NSLog(@"%@", location);
            placeLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"exhibitorinfo_place",nil),[Query getValue:@"booth" withIndex:0]];
            website = [[Query getValue:@"website" withIndex:0] copy];
            websiteLabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"exhibitorinfo_website",nil),website];
            downloadUrl = [[Query getValue:@"download" withIndex:0] copy];
            [Query getValue:@"logo" withIndex:0];
            [Query uiValueBinding:imgIcon withValue:picUrl([Query getValue:@"logo" withIndex:0])];
            infoLabel.text = [UITuneLayout checkQueryStr:[Query getValue:@"introduction" withIndex:0]];
            exhibitorName=[NSString stringWithString:[Query getValue:@"name" withIndex:0]];
            
            thisLocation.locationId=[Query getValue:@"locationId" withIndex:0];
            thisLocation.mapId=[Query getValue:@"mapId" withIndex:0];
            thisLocation.name=[Query getValue:@"name" withIndex:0];
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
    if ([iconUrl length]>1) {
        NSLog(@"iconUrl %@", iconUrl);
        [imgIcon setImage:[UIImage imageNamed:iconUrl]];
    }
    
    CGSize infoSize = [infoLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:14] constrainedToSize:CGSizeMake(infoLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
    //[Tools estimateStringSize:infoLabel.text withFontSize:14];
    infoLabel.frame = CGRectMake(infoLabel.frame.origin.x, websiteLabel.frame.origin.y+ContentSpacingVertical1*2+ websiteLabel.frame.size.height+2, infoSize.width, infoSize.height);
    [contentScroll setContentSize:CGSizeMake(contentScroll.frame.size.width, infoLabel.frame.origin.y+infoSize.height)];
    //NSLog(@"size height %f ",infoLabel.frame.origin.y+infoSize.height);
    nameLable.text = exhibitorName;
}

/*-(void)addEditButton{
    editButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	editButton.frame = CGRectMake(245.0, 7.0, 70, 30);
    editButton.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [editButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
    
	[editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:editButton];
    [editButton setTitle:AMLocalizedString(@"pathguide",nil) forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}
-(void)addBackButton{
    backButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	backButton.frame = ccRectBackBtn();
    backButton.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [backButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:backButton.frame.size forNinePatchNamed:@"btn_back"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:backButton.frame.size forNinePatchNamed:@"btn_back_i"] forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backButton];
    
    [backButton setTitle:AMLocalizedString(@"exhibitorinfo_back",nil) forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}
-(void)backAction:(id)sender{
	
	if(sender == backButton){
        [backButton removeFromSuperview];
        [editButton removeFromSuperview];
        [backButton release];
        [editButton release];
        backButton = nil;
        editButton = nil;
		[self.navigationController popViewControllerAnimated:YES];		
	}
	
}

-(void)editAction:(id)sender{
	
	if(sender == editButton){
		if([editButton.currentTitle isEqualToString:AMLocalizedString(@"edit",nil)] == YES){
			[editButton setTitle:AMLocalizedString(@"done",nil) forState:UIControlStateNormal];
            [editButton setBackgroundImage:
             [TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
            [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];
		}
		else {
			[editButton setTitle:AMLocalizedString(@"edit",nil) forState:UIControlStateNormal];
            [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
            [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
		}
		
	}
	
}*/

- (void)viewDidUnload
{
    [thisLocation release];
    [self setImgIcon:nil];
    [self setSeperateImg:nil];
    [self setNameLable:nil];
    [self setAddScheduleBtn:nil];
    [self setDownloadBtn:nil];
    [self setBookingBtn:nil];
    [self setWebsiteBtn:nil];
    [self setContentScroll:nil];
    [self setProductLocationLabel:nil];
    [self setPlaceLabel:nil];
    [self setWebsiteLabel:nil];
    [self setInfoLabel:nil];
    [self setBtnBgImg:nil];
    [self setPathGuideBtn:nil];
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
    if (psView) {
        [psView release];
    }
    if (bookingView) {
        [bookingView release];
    }
    [imgIcon release];
    [seperateImg release];
    [nameLable release];
    [addScheduleBtn release];
    [downloadBtn release];
    [bookingBtn release];
    [websiteBtn release];
    [contentScroll release];
    [productLocationLabel release];
    [placeLabel release];
    [websiteLabel release];
    [infoLabel release];
    [btnBgImg release];
    [pathGuideBtn release];
    [super dealloc];
}
- (IBAction)toWebSite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}
- (IBAction)booking:(id)sender {
    if (!bookingView) {
        bookingView= [ExhibitorBookingViewController new];
        
    }
    bookingView.exhibitorId = self.exhibitorId;
    bookingView.exhibitorName = self.exhibitorName;
    bookingView.iconUrl = self.iconUrl;
    
    [self.navigationController pushViewController:bookingView animated:YES];
    
}

- (IBAction)download:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadUrl]];
}

- (IBAction)addToSchedule:(id)sender {
    if (!psView) {
        psView = [ExhibitorAddToPSViewController new];
        
    }
    psView.exhibitorId = self.exhibitorId;
    psView.exhibitorName = self.exhibitorName;

    psView.area = location;
    psView.iconUrl = self.iconUrl;
    [self.navigationController pushViewController:psView animated:YES];
    
}
-(void)rightItemAction:(id)sender{
    [[FeatureCtrlCollections current] loadMapData:[thisLocation.mapId intValue]]; //決定樓層
    MapViewController *map=[MapViewController current];
    [map settingFloor:[thisLocation.mapId intValue]];
    [map setBackItem:self.title];
    [self.navigationController pushViewController:map animated:YES];
    [map showExhibitorInfo:thisLocation.locationId isFacility:NO]; //決定攤位
}
- (IBAction)pathGuide:(id)sender {
    [[FeatureCtrlCollections current] loadMapData:B_1F]; //決定樓層
    MapViewController *map=[MapViewController current];
    [map settingFloor:B_1F];
    [map setBackItem:self.title];
    
    [self.navigationController pushViewController:map animated:YES];
    [map showExhibitorInfo:@"0"]; //決定攤位
}
@end
