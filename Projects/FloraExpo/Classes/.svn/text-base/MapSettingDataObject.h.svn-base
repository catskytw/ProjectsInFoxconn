//
//  MapSettingDataObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MapSettingDataObject : NSObject {
	/*本物件於何種map使用
	 *0:for traffic,  1:for mylife
	 */
	NSInteger mapSettingType;
	//距離
	NSInteger distance;
	/*資料設定陣列
	 *mapSettingType:0,儲存YES,NO
	 *mapSettingType:1,儲存NSString
	 */
	NSMutableArray *settingArray;
}
@property(nonatomic)NSInteger mapSettingType,distance;
@property(nonatomic,retain)NSMutableArray *settingArray;
@end
