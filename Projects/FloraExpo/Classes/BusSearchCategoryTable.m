//
//  BusSearchTable.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BusSearchCategoryTable.h"
#import "BusSearchCategoryCell.h"
#import "TrafficTabViewController.h"
#import "TrafficDataModel.h"
#import "BusSearchCategoryObject.h"
#import "BusSearchCategoryList.h"
#import "TrafficSearch.h"
#import "Vars.h"
@implementation BusSearchCategoryTable
@synthesize thisTableView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentData=[[TrafficDataModel getBusSearchCategory]retain];
		searchArray=[[NSMutableArray arrayWithArray:contentData]retain];
		thisCellHeight=cellHeightTypeSmall;
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
	[contentData release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	[self.navigationItem setTitle:AMLocalizedString(@"BusLineSearch",nil)];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	BusSearchCategoryCell *thisCell=(BusSearchCategoryCell*)[tableView dequeueReusableCellWithIdentifier:@"BusSearchCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"BusSearchCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[BusSearchCategoryCell class]]){
				thisCell=(BusSearchCategoryCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	int myIndex=[indexPath row];
	BusSearchCategoryObject *tmpObject=(BusSearchCategoryObject*)[searchArray objectAtIndex:myIndex];
	[thisCell.busCategory setText:tmpObject.categoryName];
	[thisCell.idLabel setText:tmpObject.categoryId];
	[thisCell.busCategory setFrame:CGRectMake(thisCell.busCategory.frame.origin.x, 0, thisCell.busCategory.frame.size.width, thisCellHeight)];

	[thisCell.pic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tmpObject.picName]]];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	//trafficui_ic_buslist_blue.png的高度
	return thisCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//查單一公車分類下的所有列表
	BusSearchCategoryCell *thisCell=(BusSearchCategoryCell*)[tableView cellForRowAtIndexPath:indexPath];
	BusSearchCategoryList *bscl=[[BusSearchCategoryList alloc]initWithLineType:thisCell.idLabel.text withTitle:thisCell.busCategory.text];
	[[TrafficSearch currentTrafficSearchNavigationController]pushViewController:bscl animated:YES];
	[bscl release];
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
	for(BusSearchCategoryObject *thisObject in contentData){
		NSRange range=[thisObject.categoryName rangeOfString:matchString];
		if(range.location!=NSNotFound)
			[searchArray addObject:(BusSearchCategoryObject*)[contentData objectAtIndex:count]];
		count++;
	}
}
@end
