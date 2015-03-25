//
//  PersonalEventListViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PersonalEventListViewController.h"
#import "PersonalEventListCell.h"
#import "PSListDataObject.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "LoginDataObject.h"
#import "DateUtilty.h"
#import <EventKit/EventKit.h>
#define cellHeight 72
@implementation PersonalEventListViewController
@synthesize tableview;
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
    self.navigationItem.hidesBackButton = YES;
    [self initDataArray];
    [self setUIDefault];
    //[self addEditButton];
    //[self setRightItem:AMLocalizedString(@"edit",nil)];
    isEdit = YES;
    // Do any additional setup after loading the view from its nib.
}
-(void) setUIDefault{
    self.title = AMLocalizedString(@"personalschedule",nil);
    [UITuneLayout setNaviTitle:self];

}

-(void)initDataArray{
    if(!dataArray)
        dataArray = [NSMutableArray new];
    else
        [dataArray removeAllObjects];
    if(!sectionArray)
        sectionArray = [NSMutableArray new];
    else
        [sectionArray removeAllObjects];
#ifdef TESTDATA
    [sectionArray addObject:@"2011/10/2"];
    [sectionArray addObject:@"2011/11/3"];
    [sectionArray addObject:@"2011/11/4"];
    [sectionArray addObject:@"2011/11/5"];
    for (int i=0; i<5; i++) {
        NSMutableArray  *infoArray = [NSMutableArray new];
        for (int j=0; j<5; j++) {
            PSListDataObject *dao = [PSListDataObject new];
            dao.name = [NSString stringWithFormat:@"test %d-%d", i,j];
            dao.startTime = [NSString stringWithFormat:@"%d", 1900000+j*100];
            dao.endTime = [NSString stringWithFormat:@"%d", 1900000+j*1000];
            dao.type = [NSString stringWithFormat:@"%d",j%2];
            [infoArray addObject:dao];
            [dao release];
        }
        [dataArray addObject:infoArray];
        [infoArray release];
    }

#else
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getPersonalEventList(loginDO.sessionId)];
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            //NSLog(@"number %d",[Query getNumberForKey:@"children"]);
            int number = [Query getNumberForKey:@"children"];
            for (int i=0; i< number  ; i++) {
                DateUtilty *Datedao = [DateUtilty new];
                Datedao.startTime = [UITuneLayout getTimestamp:[Query getValue:@"date" withIndex:i] withKey:@"date"];
                [sectionArray addObject:Datedao];
                [Datedao release];
                int idCount = [[Query getObjectUnderNode:@"children" withIndex:i] count];
                NSMutableArray *dataInfoArray = [NSMutableArray new];
                for (int j=0; j< idCount  ; j++) {
                    PSListDataObject *dao = [PSListDataObject new];
                    dao.eventId = [Query getValueFromNodeString:[NSString stringWithFormat:@"personalEventList[%d].children[%d].id" ,i,j]];
                    dao.name = [Query getValueFromNodeString:[NSString stringWithFormat:@"personalEventList[%d].children[%d].title" ,i,j]];
                    dao.location = [Query getValueFromNodeString:[NSString stringWithFormat:@"personalEventList[%d].children[%d].location" ,i,j]];
                    dao.type =[Query getValueFromNodeString:[NSString stringWithFormat:@"personalEventList[%d].children[%d].status" ,i,j]];
                    dao.startTime = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"personalEventList[%d].children[%d].startDate" ,i,j]] withKey:@"timestamp"];
                    dao.endTime = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"personalEventList[%d].children[%d].endDate" ,i,j]] withKey:@"timestamp"];
                    NSLog(@"dao %@ %@ %@ %@ %@ %@", dao.eventId,dao.location, dao.startTime,dao.endTime, dao.name, dao.type);
                    [dataInfoArray addObject:dao];
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

-(void)rightItemAction:(id)sender{
	
    if(isEdit == YES){
        [self setRightItem2:AMLocalizedString(@"done",nil)];
        [tableview setEditing:YES animated:YES];
        isEdit = NO;
    }
    else {
        [self setRightItem:AMLocalizedString(@"edit",nil)];
        isEdit = YES;
        [tableview setEditing:NO animated:YES];
        
    }
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalEventListCell *cell = (PersonalEventListCell *)[tableView dequeueReusableCellWithIdentifier:@"PSListTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PersonalEventListCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    [cell setUIDefault];
    //cellHeight = cell.frame.size.height;
    PSListDataObject *dao = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell setDO:dao] ;
    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	//NSLog(@"selected %@", [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
    PSListDataObject *dao = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    if(!infoView)
        infoView = [PersonalEventInfoViewController new];
    
    infoView.eventId = dao.eventId;
    [self.navigationController pushViewController:infoView animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
-(void)viewWillAppear:(BOOL)animated{
    [self initDataArray];
    [tableview reloadData];
}
-(void) deleteEvent:(PSListDataObject *)dao{
    EKEventStore *eventStore=[[EKEventStore alloc] init];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:([dao.startTime doubleValue]/1000)];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:([dao.endTime doubleValue]/1000)];
    NSPredicate *predicate=[eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    NSArray *_tmpArray=[eventStore eventsMatchingPredicate:predicate];
    for(EKEvent *event in _tmpArray){
        NSLog(@"event.location: %@ dao location %@",event.location, dao.location);
        if ([event.location isEqualToString:dao.location]) {
            NSError *error=nil;
            EKSpan span=EKSpanThisEvent;
            [eventStore removeEvent:event span:span error:&error];
        }
        
    }
    [eventStore release];
}
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"key :%@", [[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]);
        
        if(CloseLogin!=1){
            PSListDataObject *dao = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            [self deleteEvent:dao];
            QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
            LoginDataObject *loginDO = [LoginDataObject sharedInstance];
            [Query prepareDic:deletePersonalEventById(loginDO.sessionId,dao.eventId)];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_SECTION_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    //section text as a label
    UILabel *sectionHead = [[UILabel alloc] init];
    
    sectionHead.text = [DateUtilty dateString:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime]; 
    sectionHead.font = [UIFont fontWithName:DefaultBoldFontName size:14.0f];
    sectionHead.textColor = [UIColor whiteColor];
    sectionHead.frame = CGRectMake(15, 0, 300, 28);
    sectionHead.backgroundColor = [UIColor clearColor];
    UIImageView *imgBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_subtitle.png"]];
    [imgBg addSubview:sectionHead];
    // add button to right corner of section
    return imgBg;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    //NSLog(@"[[dataArray objectAtIndex:section] count] %d",[[dataArray objectAtIndex:section] count]);
    if(isEdit == YES){
        [self setRightItem:AMLocalizedString(@"edit",nil)];
    }
    else {
        [self setRightItem2:AMLocalizedString(@"done",nil)];
    }
    return [[dataArray objectAtIndex:section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"[sectionArray count] %d",[sectionArray count]);
    return [sectionArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //NSLog(@"[sectionArray objectAtIndex:section] %@",[DateUtilty dateString:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime] );
    return  [DateUtilty dateString:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime];
    
}
- (void)viewDidUnload
{
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
    if (dataArray) {
        [dataArray release];
    }
    if (sectionArray) {
        [sectionArray release];
    }
    if (tableview) {
        [tableview release];
    }
    if (infoView) {
        [infoView release];
    }
       
    [super dealloc];
}
@end
