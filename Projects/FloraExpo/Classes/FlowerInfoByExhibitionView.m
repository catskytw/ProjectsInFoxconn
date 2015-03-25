//
//  FlowerInfoByExhibitionView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerInfoByExhibitionView.h"
#import "FlowerInfoByAreaTableView.h"
#import "ExhibitionCell.h"
#import "FlowerSearchView.h"
#import "LocalizationSystem.h"
@implementation FlowerInfoByExhibitionView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"ExhibitionTableView" bundle:nibBundleOrNil]) {
        // Custom initialization
		thisSearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
		tableStartY=0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	if(tableStartY==0){
		tableStartY=thisContentTable.frame.origin.y+44;
		[thisContentTable setFrame:CGRectMake(thisContentTable.frame.origin.x, tableStartY, thisContentTable.frame.size.width, thisContentTable.frame.size.height)];
		thisSearchBar.delegate=self;
		[self.view addSubview:thisSearchBar];
	}
	thisSearchBar.placeholder=AMLocalizedString(@"InputPlantName",nil);
	[self.navigationItem setTitle:AMLocalizedString(@"FlowerInfo",nil)];
}

-(void)deacllo{
	[thisSearchBar release];
	[super dealloc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	ExhibitionCell *thisCell=(ExhibitionCell*)[tableView cellForRowAtIndexPath:indexPath];
	FlowerInfoByAreaTableView *nextViewController=[FlowerInfoByAreaTableView new];
	nextViewController.tableHeadTitle=[NSString stringWithString:thisCell.exhibitionName.text];
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[searchBar resignFirstResponder];
	FlowerSearchView *nextViewController=[FlowerSearchView new];
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}
@end
