//
//  AreaPicker.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AreaPicker : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource> {
	NSArray *areaArray;
	UITextField *targetTextField;
}
- (id)initWithFrame:(CGRect)frame withTargetTextField:(UITextField*)bindTextField;
-(NSInteger)indexAtArray:(NSArray*)myAreaArray withCompareString:(NSString*)compareString;
@end
