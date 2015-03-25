//
//  PersonalScheduleListByDateViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PersonalScheduleListByDateViewController.h"
#import "PSListByDateTableViewCell.h"
#define cellHeight 45
#import "FcTabBarItem.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "LoginDataObject.h"
#import "FcConfig.h"
@implementation PersonalScheduleListByDateViewController
@synthesize tableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"PersonalScheduleListByDateViewController initWithNibName");
        
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
    [self initDataArray];
    [self setUIDefault];
    
   // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
            int number = [Query getNumberUnderNode:@"dateList" withKey:@"date"];
            for (int i=0; i< number  ; i++) {
                NSString *date = [Query getValue:@"date" withIndex:i ];
                date = [UITuneLayout getTimestamp:date withKey:@"date"];
                [dataArray addObject:date];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [dataArray count];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PSListByDateTableViewCell *cell = (PSListByDateTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PSListByDateTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PSListByDateTableViewCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    //cellHeight = cell.frame.size.height;
    [cell setUIDefault];
    cell.contentLabel.text =  [UITuneLayout getDateString:[dataArray objectAtIndex:indexPath.row]];
    
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	pslistViewController = [PersonalScheduleListViewController new];
    pslistViewController.timestamp = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:pslistViewController animated:YES];
	
}
- (void)dealloc {
    [tableview release];
    [pslistViewController release];
    if (dataArray) {
        [dataArray release];
    }
    [super dealloc];
}
@end
