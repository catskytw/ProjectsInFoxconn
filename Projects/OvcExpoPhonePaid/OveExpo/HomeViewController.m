//
//  HomeViewController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginDataObject.h"
#import "FcDrawing.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "OveMeetingListCtrl.h"
#import "BusinessCardHome.h"
#import "FloorSelectionViewController.h"
#import "ExhibitorAddBookingListViewController.h"
#import "RegisterViewController.h"
#import "AboutUsViewCtrl.h"
#import "HomeButtonDataObject.h"
#import "FcResourceUtility.h"
#import "QRCodeSingletonObject.h"
#import "MapDAO.h"
@interface HomeViewController(PrivateMethod)
-(void)tuneButtonsInMainView:(NSArray*)buttonObjects;
-(void)changeTab:(NSNotification*)noti;
@end
@implementation HomeViewController
@synthesize topBarViewController;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTab:) name:CHANGE_TAB object:nil];
    _buttons=[[NSMutableArray array] retain];
    
    [topBarViewController setImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 50) forNinePatchNamed:@"img_actionbar"]];
    
    NSArray *buttonObjects=[NSArray arrayWithObjects:
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"AbountUs", nil) withImage:@"ic_aboutus.png" withTag:0],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"floorplan", nil) withImage:@"ic_floorplan.png" withTag:2],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"exhibitors_list", nil) withImage:@"ic_exhibitors_list.png" withTag:5],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"qrcode", nil) withImage:@"ic_qrcode.png" withTag:8],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"namecard", nil) withImage:@"ic_namecard.png" withTag:9],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"conferences", nil) withImage:@"ic_conferences.png" withTag:4],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"schedule", nil) withImage:@"ic_schedule.png" withTag:6],
#ifdef ISPAID
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"booking_exhibitors", nil) withImage:@"ic_booking_exhibitors.png" withTag:3],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"schedule_exhibitors", nil) withImage:@"ic_schedule_exhibitors.png" withTag:7],
#endif
    /* 活動訊息及交通資訊,先暫時mark
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"events", nil) withImage:@"ic_events.png" withTag:1],
    [[HomeButtonDataObject alloc]initWithTitle:AMLocalizedString(@"transportation", nil) withImage:@"ic_transportation.png" withTag:10],*/
                            nil];
    
    if (TEST_REGISTER ==1) {
        RegisterViewController *regView = [RegisterViewController new];
        [self.tabBarController.view addSubview:regView.view];
    }
    
    if(CloseLogin!=1)
        [self checkLogin];
    [self tuneButtonsInMainView:buttonObjects];
    
    //圖臺版本資料同步
    [FcResourceUtility updateResources];
}

-(void)checkLogin{
    LoginDataObject *loginDao= [LoginDataObject sharedInstance];
    
    [loginDao readPlist];
    if (CLOSE_AUTO_LOGIN||![loginDao checkLogin]) {
         loginView = [AccountLoginViewController new];
        [self.tabBarController.view addSubview:loginView.view];
    };
}

-(void)tuneButtonsInMainView:(NSArray*)buttonObjects{
    NSInteger counter=0;
    
    CGFloat xStart=15.0f;
    CGFloat xSpace=87+xStart;
    CGFloat yStart=60;
    CGFloat ySpace=103+13;
    for (HomeButtonDataObject *thisObject in buttonObjects) {
        NSInteger column=counter%3;
        NSInteger row=floor((double)counter/3.0f);
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=thisObject.tag;
        [_buttons addObject:btn];
        [btn setImage:[UIImage imageNamed:thisObject.imageFileName]  forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(xStart+column*xSpace, yStart+row*ySpace, 87, 103)];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(xStart+column*xSpace, 87+yStart+row*ySpace, 87, 12)];
        [label setTextColor:[UIColor whiteColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName:DefaultFontName size:12.0f]];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setText:thisObject.title];
        [self.view addSubview:label];
        [label release];
        
        counter++;
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [_buttons release];
    if (loginView) {
        [loginView release];
    }
    if (meetingCtrl) {
        [meetingCtrl release];
    }
    if (companyListView) {
        [companyListView release];
    }
    
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGE_TAB object:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationPortrait|| interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
        return YES;
    return NO;
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =YES;
}


-(void)buttonAction:(id)sender{
    FloorSelectionViewController *f;
    
    UIButton *btn=(UIButton*)sender;
    //借用tag來辨認按下哪個按鍵.
    switch (btn.tag) {
        case 0: //關於我們
            aboutUs = [[AboutUsViewCtrl alloc] initWithNibName:nil bundle:nil];
            [aboutUs setBackItem:AMLocalizedString(@"title_backhome", nil)];
            [self.navigationController pushViewController:aboutUs animated:YES];
            [aboutUs autorelease];
            break;
        case 1: //活動信息
            break;
        case 2: //展區平面圖
            f=[FloorSelectionViewController new];
            [f setBackItem:AMLocalizedString(@"title_backhome", nil)];
            [self.navigationController pushViewController:f animated:YES];
            [f autorelease];
            break;
        case 3: //廠商專用
            if (bookingListView ==nil) {
                bookingListView  = [ExhibitorAddBookingListViewController new];
            }
            [bookingListView setRightItemWithPic:@"btn_add" withHighlightPic:@"btn_add_i"];
            [bookingListView setBackItem:AMLocalizedString(@"title_backhome", nil)];
            [self.navigationController pushViewController:bookingListView animated:YES];
            
            break;
        case 4: //會議時程表
            meetingCtrl = [[OveMeetingListCtrl alloc]initWithNibName:nil bundle:nil];
            [meetingCtrl setBackItem:AMLocalizedString(@"title_backhome", nil)];
            [self.navigationController pushViewController:meetingCtrl animated:YES];
            [meetingCtrl autorelease];
            break;
        case 5: //廠商列表
            if (companyListView == nil) {
                companyListView = [ExhibitorListViewController new];
            }
            [companyListView setBackItem:AMLocalizedString(@"title_backhome", nil)];
            [self.navigationController pushViewController:companyListView animated:YES];
            break;
        case 6: //個人行程表
            [self.tabBarController setSelectedIndex:1];
            break;
        case 7: //廠商行程表
            if (exhibitorEvent==nil) {
                exhibitorEvent = [ExhibitorEventViewController new];
            }
            [exhibitorEvent setBackItem:AMLocalizedString(@"title_backhome", nil)];
            [self.navigationController pushViewController:exhibitorEvent animated:YES];
            break;
        case 8: //QRCode
            [self.tabBarController setSelectedIndex:2];
            break;
        case 9: //我的名片
            [self.tabBarController setSelectedIndex:3];
            break;
        case 10: //交通信息
            break;
    }
}

-(void)changeTab:(NSNotification*)noti{
    NSDictionary *dic=(NSDictionary*)noti.userInfo;
    [QRCodeSingletonObject current].functionType=[[dic valueForKey:@"functionType"] intValue];
    NSString *value=[dic valueForKey:@"tabIndex"];
    [self.tabBarController setSelectedIndex:[value intValue]];
    
}
@end
