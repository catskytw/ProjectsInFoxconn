//
//  MyFavoriteDetailTable.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteDetailTable.h"
#import "MyFavoriteBusCell.h"
#import "MyFavoriteBusObject.h"
#import "Vars.h"
#import "MyFavoriteModel.h"
@implementation MyFavoriteDetailTable
-(id)initWithcategory:(NSInteger)categoryQueryType withFolder:(NSString*)folderName withFolderId:(NSString*)folderId{
	if((self=[super init])){
		thisCategoryQueryType=categoryQueryType;
		thisFoldername=[[NSString stringWithString:folderName]retain];
		thisFolderId=[[NSString stringWithString:folderId]retain];
		[self reloadTableDic:categoryQueryType];
		
		myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 66)];
	}
	return self;
}

//override,取得該列表下之所有資料
-(void)reloadTableDic:(NSInteger)queryType{
	switch (queryType) {
		case busQuery:
			tableDataArray=[[NSArray arrayWithArray:[MyFavoriteModel getFavoriteButItem:thisFolderId]]retain];
			break;
		case parkingQuery:
			tableDataArray=[[NSArray arrayWithArray:[MyFavoriteModel getFavoriteParkingItem:thisFolderId]]retain];
			break;
		default:
			tableDataArray=[[NSArray arrayWithArray:[MyFavoriteModel getFavLifeItem:thisFolderId]]retain];
			break;
	}
}

-(void)dealloc{
	if(selectedIndexPath!=nil)
		[selectedIndexPath release];
	[thisFoldername release];
	[thisFolderId release];
	[super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {	
	self.title=thisFoldername;
	[self scrollViewSettingUp:thisCategoryQueryType];
}
#pragma mark Delegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	selectedIndexPath=[[indexPath copy]retain];
	UIActionSheet *thisActionSheet;
	switch (thisCategoryQueryType) {
		case busQuery:
			thisActionSheet=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ThisEntryData",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"ViewThisRoute",nil),AMLocalizedString(@"AllBusOnThisStation",nil),AMLocalizedString(@"StartRoutePlan",nil),AMLocalizedString(@"DeleteFromMyFavorite",nil),nil];
			break;
		case parkingQuery:
			thisActionSheet=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ThisEntryData",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DetailInfo",nil),AMLocalizedString(@"StartRoutePlan",nil),AMLocalizedString(@"DeleteFromMyFavorite",nil),nil];
			break;
		default:
			thisActionSheet=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ThisEntryData",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DetailInfo",nil),AMLocalizedString(@"StartRoutePlan",nil),AMLocalizedString(@"DeleteFromMyFavorite",nil),nil];
			break;
	}
	[thisActionSheet showInView:self.view];
	[thisActionSheet release];
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [tableDataArray count];
}

-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	[myFavoriteTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return cellHeightTypeLarge;
}

#pragma mark -
@end
