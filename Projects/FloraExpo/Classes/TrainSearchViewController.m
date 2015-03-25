//
//  TrainSearchViewController.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrainSearchViewController.h"
#import "StationPickerView.h"
#import "TrainList.h"
#import "Vars.h"
#import "TrafficDataModel.h"
@implementation TrainSearchViewController
@synthesize startStation;
@synthesize endStation;
@synthesize dateTextField;
@synthesize timeTextField;
@synthesize timeRangeField;
@synthesize trainStyle;
@synthesize departureStyle;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

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

-(id)init{
	if((self=[super init])){
		formatter=[[NSDateFormatter alloc]init];
		//[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:28800]];
		timeRange=1;
		isDeparture=YES;
		//車種預設為 所有車種(2)
		carCategory=2;
	}
	return self;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[formatter release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];	
	[self.navigationItem setTitle:AMLocalizedString(@"TrainSearch",nil)];
	UIBarButtonItem *search=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"Search",nil) style:UIBarButtonItemStylePlain target:self action:@selector(searchResult:)];
	[self.navigationItem setRightBarButtonItem:search animated:NO];
	[search release];

	if([dateTextField.text isEqualToString:@""]){
		NSDate *selectedDate=[NSDate date];
		[formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
		NSString *stringFromDate=[formatter stringFromDate:selectedDate];
		NSArray *dateTime=[stringFromDate componentsSeparatedByString:@" "];
		[dateTextField setText:(NSString*)[dateTime objectAtIndex:0]];
		[timeTextField setText:(NSString*)[dateTime objectAtIndex:1]];
	}
}

-(IBAction)pickStation:(id)sender{
	
	UIActionSheet *pickAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles:nil];
	StationPickerView *pickerView=
	[[StationPickerView alloc]initWithFrame:CGRectMake(0, 185, 0, 0) withStartStation:(UITextField*)sender];
	pickerView.showsSelectionIndicator=YES;
	
	[pickAction addSubview:pickerView];
	[pickAction showInView:self.view];
	[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
	[pickerView release];
	[pickAction release];
}

-(IBAction)pickDateTime:(id)sender{
	NSDateFormatter *thisFormatter=[[NSDateFormatter alloc]init];
	[thisFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
	NSString *tmpString=[NSString stringWithFormat:@"%@ %@:00",dateTextField.text,timeTextField.text];
	NSDate *myDate=[thisFormatter dateFromString:tmpString];
	
	UIActionSheet *pickAction=[[UIActionSheet alloc]initWithTitle:AMLocalizedString(@"PleaseChoose",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:AMLocalizedString(@"Complete",nil) otherButtonTitles:nil];
	UIDatePicker *udp=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 185, 0, 0)];
	[udp setLocale:[NSLocale autoupdatingCurrentLocale]];
	[udp setDate:myDate];
	UITextField *thisTextField=(UITextField*)sender;
	if(thisTextField==dateTextField){
		udp.datePickerMode=UIDatePickerModeDate;
		[udp addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
	}
	else{
		udp.datePickerMode=UIDatePickerModeTime;
		[udp addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
	}
	[pickAction addSubview:udp];
	[pickAction showInView:self.view];
	[pickAction setBounds:CGRectMake(0, 0, 320, 720)];
	
	[udp release];
	[pickAction release];
	[thisFormatter release];
}

//變更時間的selector
-(void)changeDate:(UIDatePicker*)picker{
	NSDate *tmpDate=[picker date];
	NSString *date=[formatter stringFromDate:tmpDate];
	NSArray *splitStrings=[date componentsSeparatedByString:@" "];
	[dateTextField setText:(NSString*)[splitStrings objectAtIndex:0]];
}

-(void)changeTime:(UIDatePicker*)picker{
	NSDate *tmpDate=[picker date];
	NSString *date=[formatter stringFromDate:tmpDate];
	NSArray *splitTime1=[date componentsSeparatedByString:@" "];
	NSString *time=(NSString*)[splitTime1 objectAtIndex:1];
	NSArray *splitTime2=[time componentsSeparatedByString:@":"];
	[timeTextField setText:[NSString stringWithFormat:@"%@:%@",[splitTime2 objectAtIndex:0],[splitTime2 objectAtIndex:1]]];
}
//查詢結果
-(void)searchResult:(id)sender{
	UIAlertView *alert;
	if([startStation.text compare:endStation.text]==NSOrderedSame){
		alert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"Attention",nil) message:AMLocalizedString(@"NotStartEnd",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Close",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else if([dateTextField.text compare:@""]==NSOrderedSame || [timeTextField.text compare:@""]==NSOrderedSame){
		alert=[[UIAlertView alloc]initWithTitle:AMLocalizedString(@"Attention",nil) message:AMLocalizedString(@"ChooseTimeAndNo.",nil) delegate:self cancelButtonTitle:AMLocalizedString(@"Close",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else{
		//先查詢再送入下個頁面
		NSString *dateTimeString=[NSString stringWithFormat:@"%@ %@",dateTextField.text,timeTextField.text];
		NSTimeInterval timeStamp=[[formatter dateFromString:dateTimeString] timeIntervalSince1970];
		NSDictionary *resultDic=[TrafficDataModel getAllTrainLineBetweenTwoStations:startStation.placeholder withEndStation:endStation.placeholder withTrainType:carCategory withDateTicks:[NSString stringWithFormat:@"%0.0f",timeStamp] withDurationHr:timeRange isDeparture:isDeparture];
		TrainList *trainList=[[TrainList alloc]initWithDataDictionary:resultDic withType:TrainType withStartStationId:startStation.placeholder withDestStationId:endStation.placeholder];
		[self.navigationController pushViewController:trainList animated:YES];
		[trainList release];
	}
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	return NO;
}


-(IBAction)addTimeRange:(id)sender{
	if(timeRange<6)
		timeRange++;
	[self updateTimeRange];
}
-(IBAction)reduceTimeRange:(id)sender{
	if(timeRange>1)
		timeRange--;
	[self updateTimeRange];
}

-(void)updateTimeRange{
	NSString *timeRangeString=[NSString stringWithFormat:@"%i%@",timeRange,AMLocalizedString(@"hour",nil)];
	[timeRangeField setText:timeRangeString];
}

-(IBAction)changeCarCategory:(id)sender{
	UISegmentedControl *thisControl=(UISegmentedControl*)sender;
	carCategory=thisControl.selectedSegmentIndex;
}

-(IBAction)changeDeparture:(id)sender{
	UISegmentedControl *thisControl=(UISegmentedControl*)sender;
	isDeparture=(thisControl.selectedSegmentIndex==0)?YES:NO;
}

@end