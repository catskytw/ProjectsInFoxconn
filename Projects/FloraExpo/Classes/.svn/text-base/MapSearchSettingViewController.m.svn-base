//
//  MapSearchSettingViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapSearchSettingViewController.h"
#import "SearchCellViewController.h"
#import "TrafficDataModel.h"
#import "LocalizationSystem.h"
@implementation MapSearchSettingViewController
@synthesize distanceSlider;
@synthesize settingTable;
@synthesize distanceBtn;
-(id)init{
	if((self=[super init])){
		thisDataObject=[[TrafficDataModel getMapQuerySetting]retain];
	}
	return self;
}

-(void)changeSliderValue:(id)sender{
	[distanceBtn.titleLabel setText:[NSString stringWithFormat:@"%0.0f%@",distanceSlider.value,AMLocalizedString(@"Meter",nil)]];
}

-(void)settingValue{
	thisDataObject.distance=distanceSlider.value;
	int arrayCount=[thisDataObject.settingArray count];
	[thisDataObject.settingArray removeAllObjects];
	for(int i=0;i<arrayCount;i++){
		SearchCellViewController *thisCell=(SearchCellViewController*)[settingTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		NSLog(@"%@",thisCell.settingLabel.text);
		[thisDataObject.settingArray addObject:[NSNumber numberWithInt:(thisCell.settingSwitch.on==YES)?1:0]];
	}
}
- (void)dealloc {
	//寫回資料庫
	[self settingValue];
	[TrafficDataModel setMapQuerySetting:thisDataObject];
	[thisDataObject release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	[self.navigationItem setTitle:AMLocalizedString(@"SettingRange",nil)];
	distanceSlider.value=thisDataObject.distance;
	[distanceBtn.titleLabel setText:[NSString stringWithFormat:@"%i%@",thisDataObject.distance,AMLocalizedString(@"Meter",nil)]];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [thisDataObject.settingArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSArray *labelStringArray=[NSArray arrayWithObjects:
							   AMLocalizedString(@"TRTCStation",nil),
							   AMLocalizedString(@"Parking",nil),
							   [NSString stringWithFormat:@"%@/%@",AMLocalizedString(@"HighSpeed",nil),AMLocalizedString(@"Train",nil)],
							   AMLocalizedString(@"BusStation",nil),
							   nil];
	SearchCellViewController *thisCell=(SearchCellViewController*)[tableView dequeueReusableCellWithIdentifier:@"SearchCellViewController"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"SearchCellViewController" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[SearchCellViewController class]]){
				thisCell=(SearchCellViewController*)currentObject;
				break;
			}
		}
	}
	int myIndex=[indexPath row];
	NSNumber *settingNumber=(NSNumber*)[thisDataObject.settingArray objectAtIndex:myIndex];
	[thisCell.settingLabel setText:[labelStringArray objectAtIndex:myIndex]];
	[thisCell.settingSwitch setOn:([settingNumber intValue]==0)?NO:YES animated:NO];
	//[thisCell.hiddenLabel setText:thisRowKey];
	return thisCell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	return nil;
}
#pragma mark -

@end
