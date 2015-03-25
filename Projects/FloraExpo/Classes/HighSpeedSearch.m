//
//  HighSpeedSearch.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HighSpeedSearch.h"
#import "HighSpeedStationPickerView.h"
#import "TrainList.h"
#import "Vars.h"
#import "TrafficDataModel.h"
@implementation HighSpeedSearch


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"TrainSearchViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	[self.navigationItem setTitle:AMLocalizedString(@"HighSpeedSearch",nil)];
	UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Search",nil) style:UIBarButtonItemStylePlain target:self action:@selector(highSpeedSearch:)];
	[self.navigationItem setRightBarButtonItem:rightButton animated:NO];
	[rightButton release];
	
	[trainStyle setHidden:YES];
	
	[startStation setText:AMLocalizedString(@"TaipeiHS",nil)];
	[startStation setPlaceholder:@"1000"];
	[endStation setText:AMLocalizedString(@"ShouyinHS",nil)];
	[endStation setPlaceholder:@"1070"];
}

-(IBAction)pickStation:(id)sender{
	UIActionSheet *pickAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil)  otherButtonTitles:nil];
	HighSpeedStationPickerView *pickerView=
	[[HighSpeedStationPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withStartStation:(UITextField*)sender];
	pickerView.showsSelectionIndicator=YES;
	
	[pickAction addSubview:pickerView];
	[pickAction showInView:self.view];
	[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
	[pickerView release];
	[pickAction release];
}

//查詢
-(IBAction)highSpeedSearch:(id)sender{
	UIAlertView *alert;
	if([startStation.text compare:endStation.text]==NSOrderedSame){
		alert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"Attention",nil) message:AMLocalizedString(@"NotStartEnd",nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"End",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else if([startStation.text compare:@""]==NSOrderedSame || [endStation.text compare:@""]==NSOrderedSame){
		alert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"Attention",nil) message:AMLocalizedString(@"ChooseStartEnd",nil) delegate:nil cancelButtonTitle:AMLocalizedString(@"End",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else{
		//先查詢再送入下個頁面
		NSString *dateTimeString=[NSString stringWithFormat:@"%@ %@",dateTextField.text,timeTextField.text];
		NSTimeInterval timeStamp=[[formatter dateFromString:dateTimeString] timeIntervalSince1970];
		
		NSDictionary *resultDic=
		[TrafficDataModel getAllHighSpeedBetweenTwoStations:startStation.placeholder withEndStation:endStation.placeholder isDeparture:isDeparture withDuration:timeRange withQueryTime:[NSString stringWithFormat:@"%0.0f",timeStamp]];
		TrainList *trainList=[[TrainList alloc]initWithDataDictionary:resultDic withType:HighSpeedType withStartStationId:startStation.placeholder withDestStationId:endStation.placeholder];

		[self.navigationController pushViewController:trainList animated:YES];
		[trainList release];
	}
}



@end
