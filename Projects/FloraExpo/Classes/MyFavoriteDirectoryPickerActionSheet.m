//
//  MyFavoriteDirectoryPickerActionSheet.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteDirectoryPickerActionSheet.h"
#import "MyfavoritePListTool.h"
#import "MyFavoriteModel.h"
#import "Vars.h"
@implementation MyFavoriteDirectoryPickerActionSheet
@synthesize selectedPicker,destLabel;
@synthesize itemId,busStationId,leaveMode,destId;
@synthesize queryType;
-(id)init{
	if((self=[super init])){
		destLabel=[UILabel new];
	}
	return self;
}

-(void)dealloc{
	[destLabel release];
	[super dealloc];
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch (queryType) {
		case busQuery:
			[MyFavoriteModel addBusFavoriteItem:itemId withBusStationId:busStationId withLeaveMode:leaveMode withDestFolderId:destLabel.text];
			break;
		case parkingQuery:
			[MyFavoriteModel addParkToFavorite:itemId withDestFolderId:destLabel.text];
			break;
		//其他類別
		default:
			[MyFavoriteModel addToFavorite:[MyFavoriteModel converCategoryIntToString:queryType] withStoreId:itemId withFolderId:destLabel.text];
			break;
	}
}

@end
