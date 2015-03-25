//
//  SearchBusLineViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchBusLineViewController.h"
#import "GoogleMapBaseViewController.h"
#import "TrafficDataModel.h"
#import "BusSearchCategoryListCell.h"
#import "BusSearchCategoryListObject.h"
#import "BusDescriptionViewController.h"
#import "Vars.h"
@implementation SearchBusLineViewController
@synthesize startStation;
@synthesize endStation;
@synthesize searchTable;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentArray=[[NSMutableArray arrayWithObjects:nil]retain];
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[contentArray release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
	//設定title
	[self.navigationItem setTitle:AMLocalizedString(@"RouteSearch",nil)];
	
	//設定右方按鍵
	UIBarButtonItem *searchBtn=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Search",nil) style:UIBarButtonItemStylePlain target:self action:@selector(searchLineAction:)];
	[self.navigationItem setRightBarButtonItem:searchBtn animated:YES];
	[searchBtn release];
}

-(void)searchLineAction:(id)sender{
	NSString *startString=startStation.text;
	NSString *endString=endStation.text;
	NSString *encodeStartString=[TrafficDataModel getUTF8EncodingString:startString];
	NSString *encodeEndString=[TrafficDataModel getUTF8EncodingString:endString];
	if([startString compare:@""]==NSOrderedSame || [endString compare:@""]==NSOrderedSame || [startString compare:endString]==NSOrderedSame){
		//TODO
		//錯誤狀況
		return;
	}
	[contentArray removeAllObjects];
	[contentArray addObjectsFromArray:[TrafficDataModel getAllBusLine:encodeStartString withEndStation:encodeEndString]];
	[searchTable reloadData];
}

//瀏覽地圖
-(IBAction)mapViewClick:(id)sender{
	GoogleMapBaseViewController *mapClick=[[GoogleMapBaseViewController alloc]initWithAnnotationClickFlag:YES withStartLocation:TaipeiStationPosition withType:busQuery];
	[self.navigationController pushViewController:mapClick animated:YES];
	[mapClick release];
}
//交換起點終點
-(IBAction)exchangeStation:(id)sender{
	NSString *tmpString=[NSString stringWithString:startStation.text];
	[startStation setText:endStation.text];
	[endStation setText:tmpString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	int numCount=[contentArray count];
	return numCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	BusSearchCategoryListCell *thisCell=(BusSearchCategoryListCell*)[tableView dequeueReusableCellWithIdentifier:@"BusSearchCategoryListCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"BusSearchCategoryListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[BusSearchCategoryListCell class]]){
				thisCell=(BusSearchCategoryListCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	int myIndex=[indexPath row];
	BusSearchCategoryListObject *tmpObject=(BusSearchCategoryListObject*)[contentArray objectAtIndex:myIndex];
	[thisCell.busLineName setText:tmpObject.busLineName];
	[thisCell.busLineDescription setText:tmpObject.busLineDescription];
	[thisCell.lineCategoryImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tmpObject.picName]]];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	//trafficui_ic_buslist_blue.png的高度
	return cellHeightTypeLarge;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	int numCount=[contentArray count];
	return (numCount>0)?AMLocalizedString(@"SearchResult",nil):@"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	int selectedIndex=[indexPath row];
	BusSearchCategoryListObject *tmpObject=(BusSearchCategoryListObject*)[contentArray objectAtIndex:selectedIndex];
	BusLineDescriptionObject *tmpDataObject=[TrafficDataModel getBusStationInfoObject:tmpObject.lineId withLeaveMode:@"true"];
	BusDescriptionViewController *bdvc=[[BusDescriptionViewController alloc]initWithDataObject:tmpDataObject];
	[self.navigationController pushViewController:bdvc animated:YES];
	[bdvc showRightBarButtonItem:NO];
	[bdvc release];
}
@end
