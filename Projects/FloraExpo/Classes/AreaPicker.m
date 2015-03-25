//
//  AreaPicker.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AreaPicker.h"
#import "MyLifeModel.h"
#import "CommonItem.h"
@implementation AreaPicker
- (id)initWithFrame:(CGRect)frame withTargetTextField:(UITextField*)bindTextField{
	if((self=[super initWithFrame:frame])){
		areaArray=[[MyLifeModel getAllArea]retain];
		targetTextField=[bindTextField retain];
		self.delegate=self;
	}
	/*
	 // selection. in this case, it means showing the appropriate row in the middle
	 - (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;  // scrolls the specified row to center.
	 */
	int centerIndex=[self indexAtArray:areaArray withCompareString:targetTextField.text];
	[self selectRow:centerIndex inComponent:0 animated:NO];
	return self;	
}
-(NSInteger)indexAtArray:(NSArray*)myAreaArray withCompareString:(NSString*)compareString{
	int count=0;
	for(CommonItem *thisCommonItem in myAreaArray){
		if([compareString isEqualToString:thisCommonItem.itemName]==YES)
			break;
		count++;
	}
	return count;
}
-(void)dealloc{
	[areaArray release];
	[targetTextField release];
	[super dealloc];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [areaArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString;
	thisResponseString=((CommonItem*)[areaArray objectAtIndex:row]).itemName;
	return thisResponseString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	int first=[pickerView selectedRowInComponent:0];
	NSString *targetAreaString=((CommonItem*)[areaArray objectAtIndex:first]).itemName;
	[targetTextField setText:[NSString stringWithFormat:@"%@",targetAreaString]];
	[targetTextField setPlaceholder:((CommonItem*)[areaArray objectAtIndex:first]).itemKey];
}
@end
