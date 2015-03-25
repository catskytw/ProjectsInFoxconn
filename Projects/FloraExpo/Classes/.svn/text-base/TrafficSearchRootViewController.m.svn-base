//
//  TrafficSearchRootViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrafficSearchRootViewController.h"
#import "BusSearchCategoryTable.h"
#import "TrafficSearch.h"
#import "TrainSearchViewController.h"
#import "HighSpeedSearch.h"
#import "MRTList.h"
#import "ParkingAreaList.h"
#import "Vars.h"
#import "TrafficDataModel.h"
#import "TrafficRootTableCell.h"
@implementation TrafficSearchRootViewController
@synthesize myTableView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
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
	[labelArray release];
	[imageArray release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	[self.navigationController.navigationBar setTintColor:DefaultTintNavigationButtonColor];
	[self.navigationController setNavigationBarHidden:NO];
	[self.navigationItem setTitle:AMLocalizedString(@"TrafficInfo",nil)];
	
	labelArray=[[TrafficDataModel getTrafficSearchItems]retain];
	imageArray=[[TrafficDataModel getTrafficSearchItemImages]retain];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return cellHeightTypeSmall;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [labelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TrafficRootTableCell *thisCell=(TrafficRootTableCell*)[tableView dequeueReusableCellWithIdentifier:@"TrafficRootTableCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"TrafficRootTableCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[TrafficRootTableCell class]]){
				thisCell=(TrafficRootTableCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	int myIndex=[indexPath row];
	[thisCell.titleLabel setText:(NSString*)[labelArray objectAtIndex:myIndex]];
	[thisCell.imageView setImage:[UIImage imageNamed:(NSString*)[imageArray objectAtIndex:myIndex]]];
	return thisCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	int myIndex=[indexPath row];
	UIViewController *nextViewController;
	switch (myIndex) {
		case 0:
			nextViewController=[[BusSearchCategoryTable alloc]init];
			break;
		case 1:
			nextViewController=[[MRTList alloc]init];
			break;
		case 2:
			nextViewController=[[HighSpeedSearch alloc]init];
			break;
		case 3:
			nextViewController=[[TrainSearchViewController alloc]init];
			break;
		case 4:
			nextViewController=[[ParkingAreaList alloc]init];
			break;
	}
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}

@end
