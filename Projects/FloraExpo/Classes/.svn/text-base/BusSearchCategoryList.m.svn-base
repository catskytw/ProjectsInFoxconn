//
//  BusSearchCategoryList.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BusSearchCategoryList.h"
#import "BusSearchCategoryListCell.h"
#import "TrafficDataModel.h"
#import "BusSearchCategoryListObject.h"
#import "BusDescriptionViewController.h"
#import "TrafficSearch.h"
#import "Vars.h"
@implementation BusSearchCategoryList
@synthesize contentData;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentData=[[TrafficDataModel getBusSearchCategoryList]retain];
    }
    return self;
}
 */


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
    [super dealloc];
	[searchArray release];
	[contentData release];
	[lineTypeString release];
	[thisPageTitle release];
}
-(id)initWithLineType:(NSString*)lineType withTitle:(NSString*)thisTitle{
	if((self=[super init])){
		lineTypeString=[[NSString stringWithString:lineType]retain];
		thisPageTitle=[[NSString stringWithString:thisTitle]retain];
		contentData=[[TrafficDataModel getBusSearchCategoryList:lineTypeString]retain];
		isDeparture=YES;
	}
	return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	searchArray=[[NSMutableArray arrayWithArray:contentData]retain];
	//TODO 應由某一介面決定此處為何種公車路線
	[self.navigationItem setTitle:thisPageTitle];
	NSLog([NSString stringWithFormat:@"(%@)",thisPageTitle]);
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [searchArray count];
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
	BusSearchCategoryListObject *tmpObject=(BusSearchCategoryListObject*)[searchArray objectAtIndex:myIndex];
	[thisCell.busLineName setText:tmpObject.busLineName];
	[thisCell.busLineDescription setText:tmpObject.busLineDescription];
	[thisCell.lineCategoryImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tmpObject.picName]]];
	[thisCell.lineIdLabel setText:tmpObject.lineId];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	//trafficui_ic_buslist_blue.png的高度
	return cellHeightTypeLarge;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//int selectedIndex=[indexPath row];
	BusSearchCategoryListCell *thisCell=(BusSearchCategoryListCell*)[tableView cellForRowAtIndexPath:indexPath];
	BusLineDescriptionObject *thisDataObject=[TrafficDataModel getBusStationInfoObject:thisCell.lineIdLabel.text withLeaveMode:isDeparture?@"true":@"false"];
	BusDescriptionViewController *bdvc=[[BusDescriptionViewController alloc]initWithDataObject:thisDataObject];
	[[TrafficSearch currentTrafficSearchNavigationController] pushViewController:bdvc animated:YES];
	[bdvc release];
}

/*****************************
 search bar method
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[self buildSearchArrayFrom:searchBar.text];
	if([searchBar.text length]==0){
		[searchArray removeAllObjects];
		[searchArray addObjectsFromArray:contentData];
	}
	[thisTableView reloadData];
	[searchBar resignFirstResponder];
}

-(void)buildSearchArrayFrom:(NSString*)matchString{
	if(searchArray)
		[searchArray removeAllObjects];
	int count=0;
	for(BusSearchCategoryListObject *thisObject in contentData){
		NSRange range=[thisObject.busLineName rangeOfString:matchString];
		if(range.location!=NSNotFound)
			[searchArray addObject:(BusSearchCategoryListObject*)[contentData objectAtIndex:count]];
		count++;
	}
}
@end
