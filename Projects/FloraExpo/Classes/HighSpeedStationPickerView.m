//
//  HighSpeedStationPickerView.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighSpeedStationPickerView.h"
#import "TrafficDataModel.h"
#import "CommonItem.h"
@implementation HighSpeedStationPickerView
- (id)initWithFrame:(CGRect)frame withStartStation:(UITextField*)bindStation{
	if((self=[super initWithFrame:frame])){
		stationsArray=[[TrafficDataModel getAllHighSpeedStations]retain];
		myStationTextField=bindStation;
		self.delegate=self;
	}
	return self;
}

-(void)dealloc{
	[stationsArray release];
	[super dealloc];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [stationsArray count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString;
	CommonItem *thisItem=(CommonItem*)[stationsArray objectAtIndex:row];
	thisResponseString=thisItem.itemName;
	return thisResponseString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	CommonItem *thisItem=(CommonItem*)[stationsArray objectAtIndex:row];
	
	[myStationTextField setText:[NSString stringWithFormat:@"%@",thisItem.itemName]];
	[myStationTextField setPlaceholder:[NSString stringWithFormat:@"%@",thisItem.itemKey]];
}
@end
