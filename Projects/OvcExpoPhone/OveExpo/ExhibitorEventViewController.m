//
//  ExhibitorEventViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorEventViewController.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "UITuneLayout.h"
#import "QueryPattern.h"
#import "LoginDataObject.h"
#import "ExhibitorEventCell.h"
#import "ExhibitorEventDatoObject.h"
#import "DateUtilty.h"
#import "SBJsonParser.h"
#define cellHeight 72
@implementation ExhibitorEventViewController
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
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [self initDataArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self initDataArray];
    [self setUIDefault];
    // Do any additional setup after loading the view from its nib.
}
-(void) setUIDefault{
    self.title = AMLocalizedString(@"exhibitors_event",nil);
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
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
#ifdef TESTDATA
    NSString *testjson = @"{\"response\":\"0\",\"reservationList\":[{\"date\":\"Date(1317312000000)\",\"children\":[{\"id\":\"00E7C698-4BF2-4D37-A229-472373902FDE\",\"startDate\":\"Timestamp(1317318000000)\",\"endDate\":\"Timestamp(1317321600000)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"mobile\":\"0988123653\"}]},{\"date\":\"Date(57600000)\",\"children\":[{\"id\":\"D69A48F5-863A-458B-A6A1-B6C4E3D52732\",\"startDate\":\"Timestamp(100932032)\",\"endDate\":\"Timestamp(100932672)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"mobile\":\"0988123653\"},{\"id\":\"3D5078C0-C6C3-44B4-9C9B-BABEBE8E9880\",\"startDate\":\"Timestamp(79938688)\",\"endDate\":\"Timestamp(79921760)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"mobile\":\"0988123653\"},{\"id\":\"938779E6-247F-4773-A722-FD61731936BC\",\"startDate\":\"Timestamp(101060432)\",\"endDate\":\"Timestamp(101059232)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"mobile\":\"0988123653\"}]},{\"date\":\"Date(1320249600000)\",\"children\":[{\"id\":\"EAD57633-10DE-484C-B6B4-19C6D74EF36C\",\"startDate\":\"Timestamp(1320285600000)\",\"endDate\":\"Timestamp(1320292800000)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"status\":\"RC\",\"mobile\":\"0988123653\"}]},{\"date\":\"Date(1320163200000)\",\"children\":[{\"id\":\"BA131C5E-1920-4BAC-A03D-8E560F81FFC8\",\"startDate\":\"Timestamp(1320199200000)\",\"endDate\":\"Timestamp(1320206400000)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"status\":\"RP\",\"mobile\":\"0988123653\"},{\"id\":\"65F26FD7-55A2-4B25-8420-D7159B9444E8\",\"startDate\":\"Timestamp(1320213600000)\",\"endDate\":\"Timestamp(1320217200000)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"status\":\"RP\",\"mobile\":\"0988123653\"},{\"id\":\"160456FC-4CA1-4105-92EC-13FC8DCD4963\",\"startDate\":\"Timestamp(1320199200000)\",\"endDate\":\"Timestamp(1320206400000)\",\"title\":\"鴻海科技\",\"nickname\":\"Jeff\",\"status\":\"RP\",\"mobile\":\"0988123653\"}]}]}";
    SBJsonParser *jsonParser = [SBJsonParser new];
    
	[Query prepareDicWithDictionary:(NSDictionary*)[jsonParser objectWithString:testjson error:NULL]];
     [jsonParser release];
     
#else
	[Query prepareDic:getReservationEventList(loginDO.sessionId)];
#endif
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
                    ExhibitorEventDatoObject *dao = [ExhibitorEventDatoObject new];
                    dao.eventId = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].id" ,i,j]];
                    dao.title = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].title" ,i,j]];
                    dao.attender = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].nickname" ,i,j]];
                    dao.mobile = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].mobile" ,i,j]];
                    dao.status = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].status" ,i,j]];
                    [dataInfoArray addObject:dao];
                    /*dao.note = [Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].notes" ,i,j]];
                    dao.startDate = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].startDate" ,i,j]] withKey:@"timestamp"];
                    dao.endDate = [UITuneLayout getTimestamp:[Query getValueFromNodeString:[NSString stringWithFormat:@"reservationList[%d].children[%d].endDate" ,i,j]] withKey:@"timestamp"];
                    
                    NSLog(@"start %@ end  %@",dao.startDate,dao.endDate);*/
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

- (void)dealloc {
    [tableview release];
    [super dealloc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExhibitorEventCell *cell = (ExhibitorEventCell *)[tableView dequeueReusableCellWithIdentifier:@"ExhibitorEventCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ExhibitorEventCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
    [cell setUIDefault];
    //cellHeight = cell.frame.size.height;
    ExhibitorEventDatoObject *dao = [[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    [cell.admitBtn addTarget:self action:@selector(admitAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell setDO:dao] ;
    
	return cell;
}
-(void)admitAction:(id)sender{
    UIButton* btn =(UIButton*)sender;
    ExhibitorEventCell *cell = (ExhibitorEventCell*)(((UIButton*)sender).superview.superview);
    for (NSMutableArray* arr in dataArray) {
        for (ExhibitorEventDatoObject *dao in arr) {
            if([dao.eventId isEqualToString:cell.eventId]){
                QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
                LoginDataObject *loginDO = [LoginDataObject sharedInstance];
                [Query prepareDic:approveReservationEventById(loginDO.sessionId, cell.eventId)];
                if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
                    dao.status = @"RC";
                    [btn setTitle:AMLocalizedString(@"admited",nil) forState:UIControlStateNormal];
                    btn.enabled = NO;
                    [cell setDO:dao] ;
                    [cell setNeedsLayout];
                    //[tableview reloadData];
                }else{
                    NSString *alertTitle = [NSString stringWithFormat:@"%@", AMLocalizedString(@"approve_err_title",nil)]; 
                    NSString *alertMessage =[NSString stringWithFormat:@"%@", [Query getValue:@"message" withIndex:0]]; 
                    NSString *alertOtherbutton =[NSString stringWithFormat:@"%@", AMLocalizedString(@"login_alert_ok", nil)]; 
                    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:alertOtherbutton,nil]autorelease];
                    [alert show];
                }
            }
        }
    }
    //NSLog(@"admit action:%@", cell.eventId);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_SECTION_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    //section text as a label
    UILabel *sectionHead = [[UILabel alloc] init];
    
    sectionHead.text = [DateUtilty dateStringFull:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime ]; 
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
    return [[dataArray objectAtIndex:section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"[sectionArray count] %d",[sectionArray count]);
    return [sectionArray count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //NSLog(@"[sectionArray objectAtIndex:section] %@",[sectionArray objectAtIndex:section]);
     return  [DateUtilty dateString:((DateUtilty*)[sectionArray objectAtIndex:section]).startTime];    

}
-(void)leftItemAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
