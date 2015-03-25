//
//  MyFavoriteBusDetail.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteBusDetail.h"
#import "MyFavoriteBusCell.h"
#import "Vars.h"
#import "MyFavoriteBusObject.h"
#import "GoogleMapBaseViewController.h"
#import "GoogleMapRoutePlainViewController.h"
#import "BusSearchCategoryList.h"
#import "TrafficDataModel.h"
#import "MyFavoriteModel.h"
#import "BusDescriptionViewController.h"
#import "MyFavoriteBusObject.h"
@implementation MyFavoriteBusDetail
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"MyFavoriteDetailTable" bundle:nibBundleOrNil]) {
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyFavoriteBusCell *thisCell=(MyFavoriteBusCell*)[tableView dequeueReusableCellWithIdentifier:@"MyFavoriteBusCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyFavoriteBusCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyFavoriteBusCell class]]){
				thisCell=(MyFavoriteBusCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	
	int myIndex=[indexPath row];
	
	MyFavoriteBusObject *thisObject=(MyFavoriteBusObject*)[tableDataArray objectAtIndex:myIndex];
	[thisCell.stationName setText:thisObject.stationName];
	[thisCell.busLineName setText:[NSString stringWithFormat:@"%@:%@",([thisObject.isGo isEqualToString:@"true"]?AMLocalizedString(@"GoTravel",nil):AMLocalizedString(@"BackTravel",nil)),thisObject.lineName]];
	[thisCell.timeLabel setText:thisObject.min];	
	[thisCell.busLinePic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisObject.icon]]];
	return thisCell;
}

//@"瀏覽此路線",@"站點行經公車一覽",@"開始路線規畫",@"從我的最愛剛除"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{	
	BusDescriptionViewController *thisBusDescriptionViewController;
	BusSearchCategoryList *busLines;
	BusLineDescriptionObject *thisBusInfoObject;
	int rowIndex=[selectedIndexPath row];
	MyFavoriteBusObject *thisObject=(MyFavoriteBusObject*)[tableDataArray objectAtIndex:rowIndex];
	NSMutableArray *thisDataArray;
	switch (buttonIndex) {
		//瀏覽此路線
		case 0:
			thisBusInfoObject=[TrafficDataModel getBusStationInfoObject:thisObject.busRouteId withLeaveMode:@"true"];
			thisBusDescriptionViewController=[[BusDescriptionViewController alloc]initWithDataObject:thisBusInfoObject];
			[self.navigationController pushViewController:thisBusDescriptionViewController animated:YES];
			break;
		//站點行經公車一覽
		case 1:
			thisDataArray=[TrafficDataModel getBusSearchCategoryByStationName:thisObject.stationName];
			busLines=[BusSearchCategoryList new];
			busLines.contentData=thisDataArray;
			[self.navigationController pushViewController:busLines animated:YES];
			[busLines release];
			break;
		//開始路線規畫
		case 2:
			[GoogleMapRoutePlainViewController StartRoutPlain:thisObject.stationName withThisUINavigationController:self.navigationController];
			break;
		//剛除我的最愛
		case 3:
			[MyFavoriteModel deleteBusFavoriteItem:thisObject.itemId];
			[self reloadTableDic:busQuery];
			[myFavoriteTable reloadData];
			break;
		default:
			break;
	}
}
@end
