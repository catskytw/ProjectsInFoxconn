//
//  MyFavoriteParkDetail.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteParkDetail.h"
#import "MyFavoriteParkCell.h"
#import "Vars.h"
#import "GoogleMapBaseViewController.h"
#import "BusSearchCategoryList.h"
#import "MyFavoriteBusObject.h"
#import "MyFavoriteParkObject.h"
#import "GoogleMapRoutePlainViewController.h"
#import "DescriptionViewController.h"
#import "TrafficDataModel.h"
#import "MyFavoriteModel.h"
@implementation MyFavoriteParkDetail
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"MyFavoriteDetailTable" bundle:nibBundleOrNil]) {
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyFavoriteParkCell *thisCell=(MyFavoriteParkCell*)[tableView dequeueReusableCellWithIdentifier:@"MyFavoriteParkCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyFavoriteParkCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyFavoriteParkCell class]]){
				thisCell=(MyFavoriteParkCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	
	int myIndex=[indexPath row];
	
	MyFavoriteParkObject *thisObject=(MyFavoriteParkObject*)[tableDataArray objectAtIndex:myIndex];
	[thisCell.parkName setText:thisObject.parkName];
	[thisCell.desc setText:thisObject.address];
	[thisCell.space setText:thisObject.restSpace];
	NSString *picName=thisObject.icon;
	[thisCell.preImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",picName]]];
	return thisCell;
}

//@"瀏覽此路線",@"站點行經公車一覽",@"開始路線規畫",@"從我的最愛剛除"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{	
	int rowIndex=[selectedIndexPath row];
	MyFavoriteParkObject *thisObject=(MyFavoriteParkObject*)[tableDataArray objectAtIndex:rowIndex];
	DescriptionViewController *parkingDetail;
	switch (buttonIndex) {
		//詳細資訊
		case 0:
			parkingDetail=[[DescriptionViewController alloc]initWithDefaultStartY];
			parkingDetail.dataStringArray=[NSMutableArray arrayWithArray:[TrafficDataModel getParkingDetailInfo:thisObject.parkName]];
			parkingDetail.titleString=[NSString stringWithString:AMLocalizedString(@"DetailInfo",nil)];
			[self.navigationController pushViewController:parkingDetail animated:YES];
			[parkingDetail release];
			break;
			
		//開始路線規畫
		case 1:
			[GoogleMapRoutePlainViewController StartRoutPlain:thisObject.parkName withThisUINavigationController:self.navigationController];
			break;
			//剛除我的最愛
		case 2:
			[MyFavoriteModel deleteParkFavoriteItem:thisObject.itemId];
			[self reloadTableDic:parkingQuery];
			[myFavoriteTable reloadData];
			break;
		default:
			break;
	}
}
@end
