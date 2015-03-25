//
//  MyLifeMapSettingView.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapSettingDataObject.h"

@interface MyLifeMapSettingView : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource> {
	IBOutlet UIButton *rangeBtn;
	IBOutlet UISlider *rangeSlider;
	NSMutableArray *contentArray;
	/**mainSelectedIndex,上次選擇firstIndex之值
	 pickerFisrIndex,pickerSecondIndex則是同步目前所選擇之index
	 */
	NSInteger mainSelectedIndex,pickerFirstIndex,pickerSecondIndex;
	IBOutlet UIPickerView *thisSettingPicker;
	
	MapSettingDataObject *thisDataObject;
}
@property(nonatomic,retain)UIButton *rangeBtn;
@property(nonatomic,retain)UISlider *rangeSlider;
@property(nonatomic,retain)UIPickerView *thisSettingPicker;
-(IBAction)changeValue:(id)sender;
-(void)addSearchPOIAction:(id)sender;
-(void)deleteSearchPOIAction:(id)sender;
-(BOOL)isSelectedKey:(NSString*)subCategoryKey;
-(void)writeBackSettingToDataStructure;
-(void)checkSubCategorySelected;
@end
