//
//  MyLifeMapSettingView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "MyLifeMapSettingView.h"
#import "CategoryObject.h"
#import "MyLifeModel.h"
#import "SubCategoryObject.h"
#import "MyLifeMapSearchView.h"
#import "Vars.h"
@implementation MyLifeMapSettingView
@synthesize rangeBtn;
@synthesize rangeSlider;
@synthesize thisSettingPicker;

-(id)init{
	if((self=[super init])){
		contentArray=[[MyLifeModel getAllCategory:DefaultUserId isSetting:YES]retain];
		thisDataObject=[[MyLifeModel getMapSetting]retain];
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated {
	[self checkSubCategorySelected];
	rangeSlider.value=thisDataObject.distance;
	[rangeBtn setTitle:[NSString stringWithFormat:@"%0.0f%@",rangeSlider.value,AMLocalizedString(@"Meter",nil) ] forState:UIControlStateNormal];
	//UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Search",nil) style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnAction:)];
	//[self.navigationItem setRightBarButtonItem:right animated:YES];
	[self.navigationItem setTitle:AMLocalizedString(@"SettingRange",nil)];
	//[right release];
}
- (void)viewWillDisappear:(BOOL)animated{
	[self writeBackSettingToDataStructure];
	[MyLifeModel setMapQuerySetting:thisDataObject];
}
-(void)dealloc{
	[thisDataObject release];
	[contentArray release];
	[super dealloc];
}
	
#pragma mark ButtonAction
-(void)addSearchPOIAction:(id)sender{
	@try {
		CategoryObject *cateObj=(CategoryObject*)[contentArray objectAtIndex:pickerFirstIndex];
		SubCategoryObject *thisObject=(SubCategoryObject*)[cateObj.subCategoryNames objectAtIndex:pickerSecondIndex];
		thisObject.isSelected=YES;
		[thisSettingPicker reloadComponent:1];
	}
	@catch (NSException * e) {

	}
}
-(void)deleteSearchPOIAction:(id)sender{
	@try {
		CategoryObject *cateObj=(CategoryObject*)[contentArray objectAtIndex:pickerFirstIndex];
		SubCategoryObject *thisObject=(SubCategoryObject*)[cateObj.subCategoryNames objectAtIndex:pickerSecondIndex];
		thisObject.isSelected=NO;
		[thisSettingPicker reloadComponent:1];
	}
	@catch (NSException * e) {
	}
}
//依設定值搜尋地圖
-(void)searchBtnAction:(id)sender{
	[self writeBackSettingToDataStructure];
	[self.navigationController popViewControllerAnimated:YES];
}
//slider值改變之delegate method
-(IBAction)changeValue:(id)sender{
	UISlider *thisSlider=(UISlider*)sender;
	[rangeBtn setTitle:[NSString stringWithFormat:@"%0.0f%@",thisSlider.value,AMLocalizedString(@"Meter",nil)] forState:UIControlStateNormal];
}
#pragma mark -
#pragma mark DELEGATE
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger count;
	if(component==0){
		count=[contentArray count];
	}else if(component==1){
		CategoryObject *thisObject=(CategoryObject*)[contentArray objectAtIndex:mainSelectedIndex];
		count=[thisObject.subCategoryNames count];
	}
	return count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString;
	if(component==0){
		CategoryObject *thisObject=(CategoryObject*)[contentArray objectAtIndex:row];
		thisResponseString=thisObject.mainCategoryName;
	}else{
		CategoryObject *thisObject=(CategoryObject*)[contentArray objectAtIndex:mainSelectedIndex];
		SubCategoryObject *subObject=(SubCategoryObject*)[thisObject.subCategoryNames objectAtIndex:row];
		NSString *startString=(subObject.isSelected)?@"V":@"  ";
		thisResponseString=[startString stringByAppendingString:subObject.subCategoryName];
	}
	return thisResponseString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	int first=[pickerView selectedRowInComponent:0];
	int second=[pickerView selectedRowInComponent:1];
	
	pickerFirstIndex=first;
	pickerSecondIndex=second;
	
	if(first!=mainSelectedIndex){
		mainSelectedIndex=first;
		CategoryObject *thisObject=(CategoryObject*)[contentArray objectAtIndex:mainSelectedIndex];
		int count=[thisObject.subCategoryNames count];
		second=(second>count-1)?count-1:second;
		[pickerView reloadComponent:1];
	}	
}

//判斷是否為被設定的subcategorykey
-(BOOL)isSelectedKey:(NSString*)subCategoryKey{
	BOOL returnFlag=NO;
	for(NSString *thisKey in thisDataObject.settingArray){
		if([thisKey isEqualToString:subCategoryKey])
			returnFlag=YES;
	}
	return returnFlag;
}
//檢查哪個subcategory被設定,isSelected設為YES
-(void)checkSubCategorySelected{
	for(CategoryObject *thisCategory in contentArray){
		for(SubCategoryObject *thisSubCategory in thisCategory.subCategoryNames){
			if([self isSelectedKey:thisSubCategory.key])
				thisSubCategory.isSelected=YES;
		}
	}
}

-(void)writeBackSettingToDataStructure{
	thisDataObject.distance=(NSInteger)rangeSlider.value;
	[thisDataObject.settingArray removeAllObjects];
	for(CategoryObject *thisCategory in contentArray){
		for(SubCategoryObject *thisSubCategory in thisCategory.subCategoryNames){
			if(thisSubCategory.isSelected==YES)
				[thisDataObject.settingArray addObject:thisSubCategory.key];
		}
	}
}
#pragma mark -
@end
