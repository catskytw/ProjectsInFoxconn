//
//  CategoryPicker.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryPicker.h"
#import "MyLifeModel.h"
#import "CategoryObject.h"
#import "SubCategoryObject.h"
#import "Vars.h"
@implementation CategoryPicker
- (id)initWithFrame:(CGRect)frame withTargetTextField:(UITextField*)bindTextField{
	if((self=[super initWithFrame:frame])){
		secondSelectedKey=0;
		categoryArray=[[MyLifeModel getAllCategory:DefaultUserId isSetting:NO]retain];
		targetTextField=bindTextField;
		self.delegate=self;
		mainSelectedIndex=0;
	}
	[self indexAtArray:categoryArray withCompareString:targetTextField.text];
	[self selectRow:mainSelectedIndex inComponent:0 animated:NO];
	[self reloadComponent:1];
	[self selectRow:secondSelectedKey inComponent:1 animated:NO];
	return self;
	
}
-(void)indexAtArray:(NSArray*)myCategoryArray withCompareString:(NSString*)compareString{
	NSArray *splitArray=[compareString componentsSeparatedByString:@"/"];
	NSString *mainString=[[splitArray objectAtIndex:0]stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSString *subString=[[splitArray objectAtIndex:1]stringByReplacingOccurrencesOfString:@" " withString:@""];
	for(CategoryObject *thisCategoryObject in myCategoryArray){
		if([mainString isEqualToString:thisCategoryObject.mainCategoryName]==YES){
			mainSelectedIndex=[myCategoryArray indexOfObject:thisCategoryObject];
			for(SubCategoryObject *subObject in thisCategoryObject.subCategoryNames){
				if([subString isEqualToString:subObject.subCategoryName]==YES){
					secondSelectedKey=[thisCategoryObject.subCategoryNames indexOfObject:subObject];
					break;
				}
			}
			break;
		}
	}
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger count;
	if(component==0){
		count=[categoryArray count];
	}else if(component==1){
		CategoryObject *thisObject=(CategoryObject*)[categoryArray objectAtIndex:mainSelectedIndex];
		count=[thisObject.subCategoryNames count];
	}
	return count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString;
	if(component==0){
		CategoryObject *thisObject=(CategoryObject*)[categoryArray objectAtIndex:row];
		thisResponseString=thisObject.mainCategoryName;
	}else{
		CategoryObject *thisObject=(CategoryObject*)[categoryArray objectAtIndex:mainSelectedIndex];
		SubCategoryObject *subObject=(SubCategoryObject*)[thisObject.subCategoryNames objectAtIndex:row];
		thisResponseString=subObject.subCategoryName;	
	}
	return thisResponseString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	int first=[pickerView selectedRowInComponent:0];
	int second=[pickerView selectedRowInComponent:1];
	
	if(first!=mainSelectedIndex){
		mainSelectedIndex=first;
		second=0;
		[self reloadComponent:1];
		[self selectRow:second inComponent:1 animated:YES]; 
	}
	
	CategoryObject *thisObject=(CategoryObject*)[categoryArray objectAtIndex:mainSelectedIndex];
	NSString *mainString=[NSString stringWithString:thisObject.mainCategoryName];
	SubCategoryObject *subObject=(SubCategoryObject*)[thisObject.subCategoryNames objectAtIndex:second];
	[targetTextField setText:[NSString stringWithFormat:@"%@ / %@",mainString,subObject.subCategoryName]];
	[targetTextField setPlaceholder:[NSString stringWithFormat:@"%@,%@",thisObject.categoryKey,subObject.key]];
}
@end
