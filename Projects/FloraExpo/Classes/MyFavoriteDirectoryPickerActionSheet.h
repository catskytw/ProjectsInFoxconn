//
//  MyFavoriteDirectoryPickerActionSheet.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyFavoriteDirectoryPickerView.h"

@interface MyFavoriteDirectoryPickerActionSheet : UIActionSheet <UIActionSheetDelegate>{
	MyFavoriteDirectoryPickerView *selectedPicker;
	NSString *itemId,*busStationId,*destId,*leaveMode;
	NSInteger queryType;
	UILabel *destLabel;
}
@property(nonatomic)NSInteger queryType;
@property(nonatomic,retain)MyFavoriteDirectoryPickerView *selectedPicker;
@property(nonatomic,retain)UILabel *destLabel;
@property(nonatomic,retain)NSString *itemId,*busStationId,*leaveMode,*destId;
@end
