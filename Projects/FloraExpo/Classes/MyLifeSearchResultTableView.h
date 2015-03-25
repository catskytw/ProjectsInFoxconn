//
//  MyLifeSearchResultTableView.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusSearchCategoryTable.h"
//因layout與BusSearchCategoryTable一樣,因此繼承
@interface MyLifeSearchResultTableView : BusSearchCategoryTable <UIActionSheetDelegate>{
	NSIndexPath *selectedIndexPath;
}
-(id)initWithMainKey:(NSString*)mainKey withSubKey:(NSString*)subKey withDistrictKey:(NSString*)districtKey;

@end
