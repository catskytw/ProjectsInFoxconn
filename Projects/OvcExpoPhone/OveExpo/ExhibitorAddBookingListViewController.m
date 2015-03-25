//
//  ExhibitorAddBookingListViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorAddBookingListViewController.h"
#import "ExhibitorAddBookingListCell.h"
#import "ExhibitorAddBookingViewController.h"
#import "ExhibitorAddBookingListDataObject.h"
#define cellHeight 72
#import "FcTabBarItem.h"
#import <QuartzCore/QuartzCore.h>
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "LoginDataObject.h"
#import "FcConfig.h"
#import "NinePatch.h"
#import "DateUtilty.h"
#import "Tools.h"
@interface ExhibitorAddBookingListViewController(PrivateMethod)
-(void)addEditButton:(NSString*)title;
-(void)editTableAction:(id)sender;
@end
@implementation ExhibitorAddBookingListViewController
@synthesize dataTable;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    editButton=nil;
    //[self initData];
    [self setUIDefault];
    // Do any additional setup after loading the view from its nib.
}

-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"exhibitorsBooking",nil);

    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];

    //[self setRightItem:AMLocalizedString(@"edit",nil)];
}  
-(void)addEditButton:(NSString*)title{
    CGSize _stringSize=[Tools estimateStringSize:title withFontSize:14.0f withMaxSize:ccs(70, 32)];

    if(editButton==nil)
        editButton=[[UIButton buttonWithType:UIButtonTypeCustom] retain];
    else
        [editButton removeFromSuperview];
    NSString *normalImageString=(isEdit)?@"btn_title":@"btn_title_2";
    NSString *highLightString=(isEdit)?@"btn_title_i":@"btn_title_2_i";
    UIImage *normalImage=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:normalImageString];
    UIImage *highLight=[TUNinePatchCache imageOfSize:ccs(_stringSize.width+20.0f, 32) forNinePatchNamed:highLightString];
    [editButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [editButton setBackgroundImage:highLight forState:UIControlStateHighlighted];
    [editButton setTitle:title forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editTableAction:) forControlEvents:UIControlEventTouchUpInside];
    [editButton setFrame:CGRectMake(232, 6, normalImage.size.width, normalImage.size.height)];
    [editButton.titleLabel setFont:[UIFont fontWithName:DefaultFontName size:14.0f]];
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.navigationController.navigationBar addSubview:editButton];
}
-(void)editTableAction:(id)sender{
    if(isEdit == YES){
        isEdit = NO;
        [self addEditButton:AMLocalizedString(@"done", nil)];
        [dataTable setEditing:YES animated:YES];
    }
    else {
        isEdit = YES;
        [self addEditButton:AMLocalizedString(@"edit", nil)];
        [dataTable setEditing:NO animated:YES];
        
    }
}
-(void)goBack:(id)sender{
    [editButton removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightItemAction:(id)sender{
    if(!bookingViewController)
        bookingViewController = [ExhibitorAddBookingViewController new];
    [editButton removeFromSuperview];
    [self.navigationController pushViewController:bookingViewController animated:YES];
}
/*
-(void)leftItemAction:(id)sender{
        if(!bookingViewController)
            bookingViewController = [ExhibitorAddBookingViewController new];
        
		[self.navigationController pushViewController:bookingViewController animated:YES];
}
 */
-(void) initData{
    

    if(!sectionArray)
        sectionArray = [NSMutableArray new];
    else
        [sectionArray removeAllObjects];
    
    if(!dataArray)
        dataArray = [NSMutableArray new];
    else
        [dataArray removeAllObjects];

#ifdef TESTDATA

#else
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getReservationList(loginDO.sessionId)];
    //{"response":"0","reservationList":[{"children":[{"id":"38648CC5-8010-4686-A61C-1FD9DA944E37","startDate":"Timestamp(1320286320000)","endDate":"Timestamp(1320250320000)","notes":"Zack Test"}],"date":"Date(1320249600000)"},{"children":[{"id":"A356E3AD-66F6-4353-BA55-86594BE99647","startDate":"Timestamp(1320199200000)","endDate":"Timestamp(1320206400000)","notes":"測試資料01"},{"id":"7E9E9FAB-994D-4981-A58D-8B75B8BB9DA9","startDate":"Timestamp(1320213600000)","endDate":"Timestamp(1320217200000)","notes":"測試資料02"}],"date":"Date(1320163200000)"}]}
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            //NSLog(@"number %d",[Query getNumberForKey:@"children"]);
            int number = [Query getNumberForKey:@"children"];
            for (int i=0; i< number  ; i++) {
                DateUtilty *Datedao = [DateUtilty new];
                Datedao.startTime = [UITuneLayout getTimestamp:[Query getValue:@"date" withIndex:i] withKey:@"date"];
                [sectionArray addObject:Datedao];
                [Datedao release];
                //id childrennode= [Query getObjectUnderNode:@"children" withIndex:i];
                int idCount = [[Query getObjectUnderNode:@"children" withIndex:i] count];
                NSMutableArray *dataInfoArray = [NSMutableArray new];
                for (int j=0; j< idCount  ; j++) {
                    ExhibitorAddBookingListDataObject *dao = [ExhibitorAddBookingListDataObject new];
                    dao.reserveId = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].id" ,i,j]];

                    dao.note = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].notes" ,i,j]];
                    dao.startDate = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].startDate" ,i,j]] withKey:@"timestamp"];
                    dao.endDate = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].endDate" ,i,j]] withKey:@"timestamp"];
                    [dataInfoArray addObject:dao];
                    //NSLog(@"start %@ end  %@",dao.startDate,dao.endDate);
                    [dao release];
                }
                //NSLog(@"idCount %d", idCount);
                [dataArray addObject:dataInfoArray];
                [dataInfoArray release];
            }
            
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
- (void)viewDidUnload
{
    [self setDataTable:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    /*
    if(currentEditingStyle == UITableViewCellEditingStyleDelete){
        [self setRightItem2:AMLocalizedString(@"done",nil)];
        NSLog(@"set edit button done");
    }
    else {
        [self setRightItem:AMLocalizedString(@"edit",nil)];
        NSLog(@"set edit button edit");
    }

    */
    return [[dataArray objectAtIndex:section] count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    //section text as a label
    UILabel *sectionHead = [[UILabel alloc] init];
    
    sectionHead.text = [DateUtilty dateString:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime]; 
    sectionHead.textColor = [UIColor whiteColor];
    sectionHead.backgroundColor = [UIColor clearColor];
    sectionHead.font = [UIFont fontWithName:DefaultBoldFontName size:14.0f];
    sectionHead.frame = CGRectMake(15, 0, 300, 28);
    
    UIImageView *imgBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_subtitle.png"]];
    [imgBg addSubview:sectionHead];
    // add button to right corner of section
    
    
    return imgBg;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [sectionArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   return  [DateUtilty dateString:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime];    
}
- (void)viewWillAppear:(BOOL)animated{
    isEdit = YES;
    [self addEditButton:AMLocalizedString(@"edit", nil)];
    [self initData];
    [dataTable reloadData];
    self.navigationController.navigationBarHidden = NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExhibitorAddBookingListCell *cell = (ExhibitorAddBookingListCell *)[tableView dequeueReusableCellWithIdentifier:@"ExhibitorAddBookingListCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ExhibitorAddBookingListCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
   
    [cell setUIDefault];
    ExhibitorAddBookingListDataObject *dao = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell setDO:dao] ;
    //cell.contentLabel.text =  [UITuneLayout getDateString:[dataArray objectAtIndex:indexPath.row]];
    
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_SECTION_HEIGHT;
}
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
	currentEditingStyle = editingStyle;
	if(editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"key :%@", [[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]);
        
        if(CloseLogin!=1){
            ExhibitorAddBookingListDataObject *dao = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            
            QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            LoginDataObject *loginDO = [LoginDataObject sharedInstance];
            [Query prepareDic:deleteReservationById(loginDO.sessionId,dao.reserveId)];
            @try {
                if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                    [[dataArray objectAtIndex:indexPath.section] removeObject:[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                }else{
                    NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"input_alert_title",nil)]; 
                    NSString *alertMessage =[NSString stringWithFormat:@"%@", [Query getValue:@"message" withIndex:0]]; 
                    NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"getpwd_alert_ok", nil)]; 
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
                    [alert show];
                }
                
            }
            @catch (NSException * e) {
                //NPLogException(e);
            }
            @finally {
                [Query release];
                
            }
        }else{
            [tableView beginUpdates];
            
            [[dataArray objectAtIndex:indexPath.section] removeObject:[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView endUpdates];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}


- (void)dealloc {
    [editButton release];
    [dataTable release];
    if (sectionArray) {
        [sectionArray release];
    }
    if (dataArray) {
        [dataArray release];
    }
    [super dealloc];
}
@end
