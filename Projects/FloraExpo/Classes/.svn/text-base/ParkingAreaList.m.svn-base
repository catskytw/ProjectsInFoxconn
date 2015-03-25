//
//  ParkingAreaList.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ParkingAreaList.h"
#import "TrafficDataModel.h"
#import "ParkingAreaListCell.h"
#import "ParkingAreaListCellObject.h"
#import "ParkingInfoList.h"
#import "Vars.h"
@implementation ParkingAreaList
@synthesize parkingSearchBar;
@synthesize parkingTableView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentArray=[[TrafficDataModel getParkingAreaData]retain];
		searchArray=[[NSMutableArray arrayWithArray:contentArray]retain];
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
	[searchArray release];
	[contentArray release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [searchArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	ParkingAreaListCell *thisCell=(ParkingAreaListCell*)[tableView dequeueReusableCellWithIdentifier:@"ParkingAreaListCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ParkingAreaListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[ParkingAreaListCell class]]){
				thisCell=(ParkingAreaListCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	
	int myIndex=[indexPath row];
	ParkingAreaListCellObject *tmpObject=(ParkingAreaListCellObject*)[searchArray objectAtIndex:myIndex];
	[thisCell.areaNameLabel setText:tmpObject.areaName];
	/*
	[thisCell.publicLabel setText:[NSString stringWithFormat:@"公有停車場:%i",tmpObject.publicNumber]];
	[thisCell.privateLabel setText:[NSString stringWithFormat:@"私有停車場:%i",tmpObject.privateNumber]];
	 */
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 64.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//int index=[indexPath row];
	ParkingAreaListCell *thisCell=(ParkingAreaListCell*)[self.parkingTableView cellForRowAtIndexPath:indexPath];
	ParkingInfoList *pil=[[ParkingInfoList alloc]initwithParkingName:thisCell.areaNameLabel.text];
	[pil.navigationItem setTitle:thisCell.areaNameLabel.text];
	[self.navigationController pushViewController:pil animated:YES];
	[pil release];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationItem setTitle:AMLocalizedString(@"ParkingInfo",nil)];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[self buildSearchArrayFrom:parkingSearchBar.text];
	if([parkingSearchBar.text length]==0){
		[searchArray removeAllObjects];
		[searchArray addObjectsFromArray:contentArray];
	}
	[parkingTableView reloadData];
	[searchBar resignFirstResponder];
}

-(void)buildSearchArrayFrom:(NSString*)matchString{
	if(searchArray)
		[searchArray removeAllObjects];
	int count=0;
	for(ParkingAreaListCellObject *thisObject in contentArray){
		NSRange range=[thisObject.areaName rangeOfString:matchString];
		if(range.location!=NSNotFound)
			[searchArray addObject:(ParkingAreaListCellObject*)[contentArray objectAtIndex:count]];
		count++;
	}
}
@end
