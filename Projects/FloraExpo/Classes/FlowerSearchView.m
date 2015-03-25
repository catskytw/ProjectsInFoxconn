//
//  FlowerSearchView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerSearchView.h"
#import "FloraExpoModel.h"
#import "FlowerInfoContentView.h"
#import "LocalizationSystem.h"
@implementation FlowerSearchView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"ExhibitionTableView" bundle:nibBundleOrNil]) {
		FloraExpoModel *myModel=[FloraExpoModel new];
		[contentArray removeAllObjects];
		[contentArray addObjectsFromArray:[myModel searchFlowerByKey:@""]];
		[myModel release];
		
		tableHeadTitle=AMLocalizedString(@"SearchResult",nil);
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *thisCell=[tableView cellForRowAtIndexPath:indexPath];
	FlowerInfoContentView *nextViewController=[FlowerInfoContentView new];
	nextViewController.myArea=[NSString stringWithString:tableHeadTitle];
	nextViewController.myTitle=[NSString stringWithString:thisCell.textLabel.text];
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	[searchBar resignFirstResponder];
}
@end
