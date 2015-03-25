//
//  MyLifeSearchResultTableView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeSearchResultTableView.h"
#import "MyLifeModel.h"
#import "MyLifeSearchResultCell.h"
#import "MyLifeSearchResultObject.h"
#import "GoogleMapBaseViewController.h"
#import "MyLifeDescriptionContentView.h"
#import "Vars.h"
#import "MyFavoriteDirectoryPickerActionSheet.h"
#import "MyFavoriteModel.h"
#import "GoogleMapRoutePlainViewController.h"
@implementation MyLifeSearchResultTableView

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BusSearchCategoryTable" bundle:nibBundleOrNil]) {
    }
    return self;
}

-(id)initWithMainKey:(NSString*)mainKey withSubKey:(NSString*)subKey withDistrictKey:(NSString*)districtKey{
	if((self=[super init])){
		contentData=[[MyLifeModel getAllSearchResult: [Vars emptyOrOriginString:mainKey]
								withSubCategoryKey:[Vars emptyOrOriginString:subKey] 
								withDistrictKey:[Vars emptyOrOriginString:districtKey]]retain];
		//轉換文字與數字的型別對應
		selectedIndexPath=nil;
	}
	return self;
}

-(void)dealloc{
	if(selectedIndexPath!=nil)
		[selectedIndexPath release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	searchArray=[[NSMutableArray arrayWithArray:contentData]retain];
	[self.navigationItem setTitle:AMLocalizedString(@"SearchResult",nil)];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyLifeSearchResultCell *thisCell=(MyLifeSearchResultCell*)[tableView dequeueReusableCellWithIdentifier:@"MyLifeSearchResultCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyLifeSearchResultCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyLifeSearchResultCell class]]){
				thisCell=(MyLifeSearchResultCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	MyLifeSearchResultObject *tmpObject=(MyLifeSearchResultObject*)[searchArray objectAtIndex:myIndex];
	[thisCell.name setText:tmpObject.name];
	[thisCell.address setText:tmpObject.address];
	[thisCell.key setText:tmpObject.objKey];
	[thisCell.teletphone setText:tmpObject.telephone];
	return thisCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	selectedIndexPath=indexPath;
	MyLifeSearchResultObject *tmpObject=(MyLifeSearchResultObject*)[contentData objectAtIndex:[selectedIndexPath row]];
	UIActionSheet *tmpView;
	NSInteger categoryType=[MyFavoriteModel converCategoryStringToInt:tmpObject.mainKey];
	if(categoryType!=-1)
		tmpView=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ThisEntryData",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DetailInfo",nil),AMLocalizedString(@"StartRoutePlan",nil),AMLocalizedString(@"AddMyFavorite",nil),nil];
	else
		tmpView=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"ThisEntryData",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"DetailInfo",nil),AMLocalizedString(@"StartRoutePlan",nil),nil];
	tmpView.delegate=self;
	[tmpView showInView:self.parentViewController.tabBarController.view];
	[tmpView release];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	GoogleMapRoutePlainViewController *planner;
	CLLocationCoordinate2D thisLocation;
	MyLifeDescriptionContentView *descriptionView;
	MyLifeSearchResultObject *selectedDataObject=(MyLifeSearchResultObject*)[contentData objectAtIndex:[selectedIndexPath row]];
	NSInteger thisQueryType=[MyFavoriteModel converCategoryStringToInt:selectedDataObject.mainKey];
	MyFavoriteDirectoryPickerActionSheet *pickAction;
	switch (buttonIndex) {
		case 0:
			descriptionView=[[MyLifeDescriptionContentView alloc]initWithStoreKey:selectedDataObject.objKey];
			[self.navigationController pushViewController:descriptionView animated:YES];
			[descriptionView release];
			break;
		//加入我的最愛
		case 2:
			if(thisQueryType==-1)
				break;
			pickAction=[[MyFavoriteDirectoryPickerActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles:nil];
			pickAction.delegate=pickAction;
			pickAction.itemId=selectedDataObject.objKey;
			pickAction.queryType=thisQueryType;
			NSLog(@"%@",selectedDataObject.mainKey);
			MyFavoriteDirectoryPickerView *pickerView=[[MyFavoriteDirectoryPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withFavoriteType:thisQueryType];
			pickAction.selectedPicker=pickerView;
			pickerView.destLabel=pickAction.destLabel;
			pickerView.showsSelectionIndicator=YES;
			
			[pickAction addSubview:pickerView];
			[pickAction showInView:self.view];
			[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
			
			[pickerView release];
			[pickAction release];
			break;
		case 1:
			thisLocation.latitude=[selectedDataObject.lat doubleValue];
			thisLocation.longitude=[selectedDataObject.lon doubleValue];
			planner=[[GoogleMapRoutePlainViewController alloc]initWithAnnotationClickFlag:NO withStartLocation:thisLocation withType:noneQuery];
			planner.endStationString=[NSString stringWithString:selectedDataObject.name];
			planner.lat=[selectedDataObject.lat doubleValue];
			planner.lon=[selectedDataObject.lon doubleValue];
			[self.navigationController pushViewController:planner animated:YES];
			[planner release];
			break;
		default:
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	//trafficui_ic_buslist_blue.png的高度
	return cellHeightTypeLarge;
}

-(void)buildSearchArrayFrom:(NSString*)matchString{
	if(searchArray)
		[searchArray removeAllObjects];
	int count=0;
	for(MyLifeSearchResultObject *thisObject in contentData){
		NSRange range=[thisObject.name rangeOfString:matchString];
		if(range.location!=NSNotFound)
			[searchArray addObject:(MyLifeSearchResultObject*)[contentData objectAtIndex:count]];
		count++;
	}
}
@end
