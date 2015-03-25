//
//  MyFavoriteLifeDetail.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteLifeDetail.h"
#import "MyFavoriteLifeCell.h"
#import "Vars.h"
#import "MyFavoriteLifeObject.h"
#import "MyLifeModel.h"
#import "MyLifeDescriptionContentView.h"
#import "GoogleMapRoutePlainViewController.h"
#import "MyFavoriteModel.h"
@implementation MyFavoriteLifeDetail
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"MyFavoriteDetailTable" bundle:nibBundleOrNil]) {
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MyFavoriteLifeCell *thisCell=(MyFavoriteLifeCell*)[tableView dequeueReusableCellWithIdentifier:@"MyFavoriteLifeCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MyFavoriteLifeCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MyFavoriteLifeCell class]]){
				thisCell=(MyFavoriteLifeCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	
	int myIndex=[indexPath row];
	
	MyFavoriteLifeObject *thisObject=(MyFavoriteLifeObject*)[tableDataArray objectAtIndex:myIndex];
	[thisCell.name setText:thisObject.name];
	[thisCell.address setText:thisObject.address];
	[thisCell.tel setText:thisObject.tel];
	return thisCell;
}

//@"瀏覽此路線",@"站點行經公車一覽",@"開始路線規畫",@"從我的最愛剛除"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{	
	
	int rowIndex=[selectedIndexPath row];
	MyFavoriteLifeObject *thisObject=(MyFavoriteLifeObject*)[tableDataArray objectAtIndex:rowIndex];
	MyLifeDescriptionContentView *myLifeDetail;
	switch (buttonIndex) {
			//詳細資訊
		case 0:
			//-(id)initWithDataObject:(MyLifeDescriptionObject*)dataObject{
			myLifeDetail=[[MyLifeDescriptionContentView alloc]initWithStoreKey:thisObject.storeKey];
			[self.navigationController pushViewController:myLifeDetail animated:YES];
			[myLifeDetail release];
			break;
			
			//開始路線規畫
		case 1:
			[GoogleMapRoutePlainViewController StartRoutPlain:thisObject.name withThisUINavigationController:self.navigationController];
			break;
			//剛除我的最愛
		case 2:
			[MyFavoriteModel deleteLifeFavoriteItem:thisFolderId withItemId:thisObject.itemId];
			[self reloadTableDic:parkingQuery];
			[myFavoriteTable reloadData];
			break;
		default:
			break;
	}
	 
}

@end
