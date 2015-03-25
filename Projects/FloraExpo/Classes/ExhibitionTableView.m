 //
//  ExhibitionTableView.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExhibitionTableView.h"
#import "FloraExpoModel.h"
#import "AreaExhibitionObject.h"
#import "ExhibitionCell.h"
#import "ExhibitionObject.h"
#import "ExhibitionMapViewController.h"
#import "DescriptionContentViewController.h"
#import "FloraExpoTableViewController.h"
#import "Vars.h"
@implementation ExhibitionTableView
@synthesize thisContentTable;
@synthesize titleString;

-(id)initWithType:(NSInteger)type{
	if((self=[super init])){
		thisType=type;
		DescriptionPageDataObject *thisDataObject;
		switch (type) {
			case HotelArea:
				thisDataObject=[FloraExpoModel getExpoHotelAreaList];
				contentArray=[[NSMutableArray arrayWithArray:thisDataObject.contentArray]retain];
				titleString=thisDataObject.title;
				break;
			case Exhibition:
				thisDataObject=[FloraExpoModel getAllAreaExhibitionName];
				contentArray=[[NSMutableArray arrayWithArray:thisDataObject.contentArray]retain];
				titleString=thisDataObject.title;
				break;
			default:
				break;
		}
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
	switch (thisType) {
		case HotelArea:
			break;
		case Exhibition:
			[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"3DModel",nil) style:UIBarButtonItemStylePlain target:self action:@selector(enterExhibitionBrief:)]autorelease] animated:YES];
			break;
		default:
			break;
	}
	[self.navigationItem setTitle:titleString];
	[thisContentTable.tableHeaderView setBackgroundColor:DefaultTintNavigationButtonColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [contentArray count];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	AreaExhibitionObject *thisArea=(AreaExhibitionObject*)[contentArray objectAtIndex:section];
	return [thisArea.allExhibitionNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *thisCell;
	ExhibitionObject *thisObject;
	int myIndex=[indexPath row];
	int mySection=[indexPath section];
	switch (thisType) {
		case HotelArea:
			thisCell=[tableView dequeueReusableCellWithIdentifier:@"hotelCell"];
			if(thisCell==nil)
				thisCell=[[[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:@"hotelCell"]autorelease];
			thisObject=(ExhibitionObject*)[((AreaExhibitionObject*)[contentArray objectAtIndex:mySection]).allExhibitionNames objectAtIndex:myIndex];
			[thisCell.textLabel setText:thisObject.exhibitionName];
			break;
		case Exhibition:
			thisCell=(ExhibitionCell*)[tableView dequeueReusableCellWithIdentifier:@"ExhibitionCell"];
			if(thisCell==nil){
				NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ExhibitionCell" owner:nil options:nil];
				for(id currentObject in  nib){
					if([currentObject isKindOfClass:[ExhibitionCell class]]){
						thisCell=(ExhibitionCell*)currentObject;
						break;
					}
				}
				thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
				
			}
			thisObject=(ExhibitionObject*)[((AreaExhibitionObject*)[contentArray objectAtIndex:mySection]).allExhibitionNames objectAtIndex:myIndex];
			[((ExhibitionCell*)thisCell).exhibitionName setText:thisObject.exhibitionName];
			[((ExhibitionCell*)thisCell).imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisObject.exhibitionPicName]]];
			break;
		default:
			break;
	}
	thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return cellHeightTypeMedium;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSString *title=((AreaExhibitionObject*)[contentArray objectAtIndex:section]).areaNme;
	return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIViewController *nextViewController;
	ExhibitionObject *selectedObject;
	int myIndex=[indexPath row];
	int mySection=[indexPath section];
	switch (thisType) {
		case HotelArea:
			selectedObject=(ExhibitionObject*)[((AreaExhibitionObject*)[contentArray objectAtIndex:mySection]).allExhibitionNames objectAtIndex:myIndex];
			nextViewController=[[FloraExpoTableViewController alloc]initwithTableType:HotelList withKey:selectedObject.key];
			break;
		case Exhibition:
			selectedObject=(ExhibitionObject*)[((AreaExhibitionObject*)[contentArray objectAtIndex:mySection]).allExhibitionNames objectAtIndex:myIndex];
			nextViewController=[[DescriptionContentViewController alloc]initWithType:ExhibitionInfo withKey:selectedObject.key];
			break;
		default:
			break;
	}
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}

-(void)enterExhibitionBrief:(id)sender{
	ExhibitionMapViewController *tmpController=[ExhibitionMapViewController new];

	[self.navigationController pushViewController:tmpController animated:YES];
	[tmpController release];
}
@end
