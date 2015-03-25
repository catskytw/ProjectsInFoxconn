//
//  MyFavoriteDirectoryPickerView.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyFavoriteDirectoryPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource> {
	NSInteger myFavoriteType;
	NSMutableArray *pickerArray;
	NSString *selectedString;
	NSString *destId;
	UILabel *destLabel;
}
@property(nonatomic,retain)NSString *selectedString,*destId;
@property(nonatomic,retain)UILabel *destLabel;
- (id)initWithFrame:(CGRect)frame withFavoriteType:(NSInteger)type;
@end
