//
//  FlowerInfoByAreaTableView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerInfoByAreaTableView.h"
#import "FloraExpoModel.h"
#import "FlowerInfoContentView.h"
#import "FlowerInfoByFlower.h"
#import "Vars.h"
@implementation FlowerInfoByAreaTableView
@synthesize tableHeadTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"ExhibitionTableView" bundle:nibBundleOrNil]) {
		FloraExpoModel *myModel=[FloraExpoModel new];
		[contentArray removeAllObjects];
		[contentArray addObjectsFromArray:[myModel getFlowerArea]];
		[myModel release];
    }
    return self;
}

//幾個section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int row=[indexPath row];
	UITableViewCell *thisCell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"flowerArea"];
	if(thisCell==nil){
		thisCell=[[[UITableViewCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:@"flowerArea"]autorelease];
		thisCell.selectionStyle=UITableViewCellSelectionStyleGray;
		thisCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	}
	thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	[thisCell.textLabel setText:(NSString*)[contentArray objectAtIndex:row]];
	return thisCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return tableHeadTitle;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *thisCell=[tableView cellForRowAtIndexPath:indexPath];
	FlowerInfoByFlower *nextViewController=[FlowerInfoByFlower new];
	nextViewController.tableHeadTitle=[NSString stringWithString:thisCell.textLabel.text];
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}

@end
