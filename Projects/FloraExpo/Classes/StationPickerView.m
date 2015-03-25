//
//  StationPickerView.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StationPickerView.h"
#import "TrafficDataModel.h"
#import "AreaStationObject.h"
#import "CommonItem.h"

@implementation StationPickerView
- (id)initWithFrame:(CGRect)frame withStartStation:(UITextField*)bindStation{
	if((self=[super initWithFrame:frame])){
		stationsArray=[[TrafficDataModel getAllTrainStationName]retain];
		myStationTextField=bindStation;
		areaSelectedIndex=0;
		self.delegate=self;
	}
	return self;
}

-(void)dealloc{
	[stationsArray release];
	[super dealloc];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger number=0;
	if(component==0)
		number=[stationsArray count];
	else
		number=[((AreaStationObject*)[stationsArray objectAtIndex:areaSelectedIndex]).stationArray count];
	return number;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString *thisResponseString;
	if(component==0){
		AreaStationObject *thisObject=(AreaStationObject*)[stationsArray objectAtIndex:row];
		thisResponseString=thisObject.areaName;
	}else{
		AreaStationObject *secondObject=(AreaStationObject*)[stationsArray objectAtIndex:areaSelectedIndex];
		thisResponseString=((CommonItem*)[secondObject.stationArray objectAtIndex:row]).itemName;
	}
	return thisResponseString;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	int first=[pickerView selectedRowInComponent:0];
	int second=[pickerView selectedRowInComponent:1];
	
	if(first!=areaSelectedIndex){
		areaSelectedIndex=first;
		[self reloadComponent:1];
	}
	
	AreaStationObject *thisObject=(AreaStationObject*)[stationsArray objectAtIndex:first];
	NSString *areaString=[NSString stringWithString:thisObject.areaName];
	if(second>([thisObject.stationArray count]-1)){
		second=[thisObject.stationArray count]-1;
	}
	NSString *stationString=((CommonItem*)[thisObject.stationArray objectAtIndex:second]).itemName;
	[myStationTextField setText:[NSString stringWithFormat:@"%@-%@",areaString,stationString]];
	NSString *itemKey=[NSString stringWithString:((CommonItem*)[thisObject.stationArray objectAtIndex:second]).itemKey];
	[myStationTextField setPlaceholder:itemKey];			   
}

@end
