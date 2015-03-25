//
//  PersonalScheduleListViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PersonalScheduleListViewController.h"
#import "PSListTableViewCell.h"
#import "PSListDataObject.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "LoginDataObject.h"
#define cellHeight 75
@implementation PersonalScheduleListViewController
@synthesize tableview,timestamp;

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
    [self addEditButton];
    [self addBackButton];

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
    
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getPersonalEventList(loginDO.sessionId)];
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            //NSLog(@"number %d",[Query getNumberUnderNode:@"eventList" withKey:@"id"]);
            int number = [Query getNumberUnderNode:@"eventList" withKey:@"id"];
            for (int i=0; i< number  ; i++) {
                PSListDataObject *dao = [PSListDataObject new];
                dao.eventId = [Query getValue:@"id" withIndex:i];
                //NSLog(@"id %@",dao.eventId);
                dao.name = [Query getValue:@"title" withIndex:i];
                dao.location = [Query getValue:@"location" withIndex:i];
                dao.startTime = [UITuneLayout getHMTimeString:[Query getValue:@"startDate" withIndex:i]];
                dao.endTime = [UITuneLayout getHMTimeString:[Query getValue:@"endDate" withIndex:i]];
                dao.targetId = [UITuneLayout getHMTimeString:[Query getValue:@"targetId" withIndex:i]];
                dao.bookingStatusName = [Query getValue:@"statusName" withIndex:i];
                dao.bookingStatus = [Query getValue:@"status" withIndex:i];
                dao.type = [Query getValue:@"targetType" withIndex:i];
                [dataArray addObject:dao];
                [dao release];
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

}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)addEditButton{
    editButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	editButton.frame = ccRectEditBtn();
    editButton.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [editButton setBackgroundImage:
     [TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
    [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];

	[editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:editButton];
    [editButton setTitle:AMLocalizedString(@"edit",nil) forState:UIControlStateNormal];
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
    
    [backButton setTitle:AMLocalizedString(@"date",nil) forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
}
-(void)backAction:(id)sender{
	
	if(sender == backButton){
        [backButton removeFromSuperview];
        [editButton removeFromSuperview];
        [backButton release];
        [editButton release];
		[self.navigationController popViewControllerAnimated:YES];		
	}
	
}

-(void)editAction:(id)sender{
	
	if(sender == editButton){
		if([editButton.currentTitle isEqualToString:AMLocalizedString(@"edit",nil)] == YES){
			[editButton setTitle:AMLocalizedString(@"done",nil) forState:UIControlStateNormal];
			[tableview setEditing:YES animated:YES];
            [editButton setBackgroundImage:
             [TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_2"] forState:UIControlStateNormal];
            [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_2_i"] forState:UIControlStateHighlighted];
		}
		else {
			[editButton setTitle:AMLocalizedString(@"edit",nil) forState:UIControlStateNormal];
			[tableview setEditing:NO animated:YES];
            [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title"] forState:UIControlStateNormal];
            [editButton setBackgroundImage:[TUNinePatchCache imageOfSize:editButton.frame.size forNinePatchNamed:@"btn_title_i"] forState:UIControlStateHighlighted];
		}
		
	}
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [dataArray count];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSListTableViewCell *cell = (PSListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PSListTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PSListTableViewCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    [cell setUIDefault];
    //cellHeight = cell.frame.size.height;
    PSListDataObject *dao = [dataArray objectAtIndex:indexPath.row];
     //NSLog(@"id %@",dao.eventId);
     //NSLog(@"name %@",dao.name);
    [cell setDO:dao] ;

	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	//NSLog(@"selected %@", [dataArray objectAtIndex:indexPath.row]);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"key :%@", [[ShoppingCartDic allKeys] objectAtIndex:indexPath.row]);
        PSListDataObject *dao = [dataArray objectAtIndex:indexPath.row];

        QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
        LoginDataObject *loginDO = [LoginDataObject sharedInstance];
        [Query prepareDic:deletePersonalEventById(loginDO.sessionId,dao.eventId)];
        @try {
            if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                [dataArray removeObject:[dataArray objectAtIndex:indexPath.row]];
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

    }
}
- (void)dealloc {
    [tableview release];
    if (editButton) {
        [editButton release];
    }
    if (dataArray) {
        [dataArray release];
    }
    if (backButton) {
        [backButton release];
    }
    [super dealloc];
}
@end
