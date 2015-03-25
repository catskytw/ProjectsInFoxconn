//
//  StationPickerView.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationPickerView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource> {
	NSMutableArray *stationsArray;
	UITextField *myStationTextField;
	//選中哪個區域之index
	NSInteger areaSelectedIndex;
}
- (id)initWithFrame:(CGRect)frame withStartStation:(UITextField*)bindStation;
@end
