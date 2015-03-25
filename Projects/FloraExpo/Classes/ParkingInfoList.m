//
//  ParkingInfoList.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ParkingInfoList.h"
#import "ParkingInfoListCell.h"
#import "TrafficDataModel.h"
#import "ParkingInfoObject.h"
#import "GoogleMapBaseViewController.h"
#import "Vars.h"
#import "DescriptionViewController.h"
#import "MyFavoriteDirectoryPickerActionSheet.h"
#import "GoogleMapRoutePlainViewController.h"
@implementation ParkingInfoList
@synthesize thisSearchBar;
@synthesize thisTableView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentArray=[[TrafficDataModel getParkingInfoData]retain];
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
-(id)initwithParkingName:(NSString*)parkName{
	if((self=[super init])){
		contentArray=[[TrafficDataModel getParkingInfoData:parkName]retain];
		searchArray=[[NSMutableArray arrayWithArray:contentArray]retain];
		selectedIndex=nil;
	}
	return self;
}
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
	if(selectedIndex!=nil)
		[selectedIndex release];
	[searchArray release];
	[contentArray release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [searchArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	ParkingInfoListCell *thisCell=(ParkingInfoListCell*)[tableView dequeueReusableCellWithIdentifier:@"ParkingInfoListCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ParkingInfoListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[ParkingInfoListCell class]]){
				thisCell=(ParkingInfoListCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	ParkingInfoObject *tmpObject=(ParkingInfoObject*)[searchArray objectAtIndex:myIndex];
	[thisCell.titleBackground setImage:(tmpObject.isPublic)?[UIImage imageNamed:@"trafficui_ic_parklist_public.png"]:[UIImage imageNamed:@"trafficui_ic_parklist_private.png"]];
	[thisCell.categoryLabel setText:(tmpObject.isPublic)?@"":@""];
	[thisCell.parkingNameLabel setText:tmpObject.parkingName];
	[thisCell.totalSpaceLabel setText:[NSString stringWithString:tmpObject.address]];
	[thisCell.spaceLabel setText:[NSString stringWithFormat:@"%i",tmpObject.spaces]];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 64.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	selectedIndex=[[indexPath copy]retain];
	UIActionSheet *tmpView=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ThisEntryData",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DetailInfo",nil),AMLocalizedString(@"AddMyFavorite",nil),AMLocalizedString(@"StartRoutePlan",nil),nil];
	[tmpView showInView:self.parentViewController.tabBarController.view];
	[tmpView release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	GoogleMapRoutePlainViewController *planner;
	DescriptionViewController *parkingDetail;
	MyFavoriteDirectoryPickerActionSheet *pickAction;
	ParkingInfoListCell *selectedCell=(ParkingInfoListCell*)[thisTableView cellForRowAtIndexPath:selectedIndex];
	ParkingInfoObject *thisDataObject=(ParkingInfoObject*)[contentArray objectAtIndex:[selectedIndex row]];
	CLLocationCoordinate2D thisLocation;
	switch (buttonIndex) {
		//詳細資訊
		case 0:
			parkingDetail=[[DescriptionViewController alloc]initWithDefaultStartY];
			parkingDetail.dataStringArray=[NSMutableArray arrayWithArray:[TrafficDataModel getParkingDetailInfo:selectedCell.parkingNameLabel.text]];
			parkingDetail.titleString=[NSString stringWithString:AMLocalizedString(@"DetailInfo",nil)];
			[self.navigationController pushViewController:parkingDetail animated:YES];
			[parkingDetail release];
			break;
		//加入我的最愛
		case 1:
			pickAction=[[MyFavoriteDirectoryPickerActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles:nil];
			pickAction.delegate=pickAction;
			pickAction.itemId=thisDataObject.parkId;
			pickAction.queryType=parkingQuery;
			MyFavoriteDirectoryPickerView *pickerView=[[MyFavoriteDirectoryPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withFavoriteType:parkingQuery];
			pickAction.selectedPicker=pickerView;
			pickerView.destLabel=pickAction.destLabel;
			pickerView.showsSelectionIndicator=YES;
			
			[pickAction addSubview:pickerView];
			[pickAction showInView:self.view];
			[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
			
			[pickerView release];
			[pickAction release];
			break;
		case 2:
			thisLocation.latitude=[thisDataObject.lat doubleValue];
			thisLocation.longitude=[thisDataObject.lon doubleValue];
			planner=[[GoogleMapRoutePlainViewController alloc]initWithAnnotationClickFlag:NO withStartLocation:thisLocation withType:noneQuery];
			planner.lat=thisLocation.latitude;
			planner.lon=thisLocation.longitude;
			planner.endStationString=[NSString stringWithString:thisDataObject.parkingName];
			[self.navigationController pushViewController:planner animated:YES];
			[planner release];
			break;
		default:
			break;
	}
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[self buildSearchArrayFrom:searchBar.text];
	if([searchBar.text length]==0){
		[searchArray removeAllObjects];
		[searchArray addObjectsFromArray:contentArray];
	}
	[thisTableView reloadData];
	[searchBar resignFirstResponder];
}

-(void)buildSearchArrayFrom:(NSString*)matchString{
	if(searchArray)
		[searchArray removeAllObjects];
	int count=0;
	for(ParkingInfoObject *thisObject in contentArray){
		NSRange range=[thisObject.parkingName rangeOfString:matchString];
		if(range.location!=NSNotFound)
			[searchArray addObject:(ParkingInfoObject*)[contentArray objectAtIndex:count]];
		count++;
	}
}
@end
