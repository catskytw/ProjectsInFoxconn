//
//  MyLifeInformationViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeInformationViewController.h"
#import "MyLifeTableCell.h"
#import "MyLifeModel.h"
#import "MyLifeTableCellObject.h"
#import "MyLifeSearchViewController.h"
#import "MyLifeDiscountTableView.h"
#import "Vars.h"
@implementation MyLifeInformationViewController
@synthesize myLifeInformationTable;
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	[self.navigationItem setTitle: AMLocalizedString(@"LifeInfo",nil)];
	contentArray=[[MyLifeModel getAllDirectoryByMyLife]retain];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyLifeTableCell *thisCell=(MyLifeTableCell*)[tableView dequeueReusableCellWithIdentifier:@"MyLifeTableCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyLifeTableCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyLifeTableCell class]]){
				thisCell=(MyLifeTableCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	MyLifeTableCellObject *thisObject=(MyLifeTableCellObject*)[contentArray objectAtIndex:myIndex];
	[thisCell.objectName setText:thisObject.objectName];
	[thisCell.objectImage setImage:[UIImage imageNamed:thisObject.objectPicName]];
	
	return thisCell;
	
}

- (void)dealloc {
	[contentArray release];
    [super dealloc];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	int myIndex=[indexPath row];
	MyLifeSearchViewController *mlsvc;
	MyLifeDiscountTableView *mldtv;
	switch (myIndex) {
		//搜尋生活資料庫
		case 0:
			mlsvc=[MyLifeSearchViewController new];
			[self.navigationController pushViewController:mlsvc animated:YES];
			[mlsvc release];
			break;
		//地圖搜尋
		case 1:
			mldtv=[MyLifeDiscountTableView new];
			[self.navigationController pushViewController:mldtv animated:YES];
			[mldtv release];
			break;
		default:
			break;
	}
}
@end
