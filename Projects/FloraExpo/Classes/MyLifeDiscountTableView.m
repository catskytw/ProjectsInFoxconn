//
//  MyLifeDiscountTableView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeDiscountTableView.h"
#import "MyLifeModel.h"
#import "MyLifeDiscountCell.h"
#import "DiscountObject.h"
#import "MyLifeDiscountDetailView.h"
#import "Vars.h"
@implementation MyLifeDiscountTableView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BusSearchCategoryTable" bundle:nibBundleOrNil]) {
        // Custom initialization
		[contentData removeAllObjects];
		[searchArray removeAllObjects];
		[contentData addObjectsFromArray:[MyLifeModel getAllDiscountAction]];
		[searchArray addObjectsFromArray:contentData];
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	//trafficui_ic_buslist_blue.png的高度
	return cellHeightTypeLarge;
}
- (void)viewWillAppear:(BOOL)animated {	
    [super viewWillAppear:animated];	
	[self.navigationItem setTitle:AMLocalizedString(@"PromoteAction",nil)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyLifeDiscountCell *thisCell=(MyLifeDiscountCell*)[tableView dequeueReusableCellWithIdentifier:@"MyLifeDiscountCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyLifeDiscountCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyLifeDiscountCell class]]){
				thisCell=(MyLifeDiscountCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	DiscountObject *tmpObject=(DiscountObject*)[contentData objectAtIndex:myIndex];
	[thisCell.durationLabel setText:tmpObject.durationString];
	[thisCell.discountActionLabel setText:tmpObject.actionString];
	return thisCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	int index=[indexPath row];
	DiscountObject *selectedData=(DiscountObject*)[contentData objectAtIndex:index];
	DiscountDetailObject *thisDataObject=[MyLifeModel getDicountDetailInfo:selectedData.discountKey];

	MyLifeDiscountDetailView *myDetail=[[MyLifeDiscountDetailView alloc]initWithDataObject:thisDataObject];	
	[self.navigationController pushViewController:myDetail animated:YES];
	[myDetail release];
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
	for(DiscountObject *thisObject in contentData){
		NSRange range=[thisObject.actionString rangeOfString:matchString];
		if(range.location!=NSNotFound)
			[searchArray addObject:(DiscountObject*)[contentData objectAtIndex:count]];
		count++;
	}
}
@end
