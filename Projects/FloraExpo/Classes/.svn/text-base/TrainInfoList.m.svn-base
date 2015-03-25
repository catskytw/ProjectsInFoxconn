//
//  TrainInfoList.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrainInfoList.h"
#import "TrafficDataModel.h"
#import "TrainInfoListCell.h"
#import "TrainStationObject.h"
#import "Vars.h"
@implementation TrainInfoList
@synthesize monView;
@synthesize thuView;
@synthesize wedView;
@synthesize tueView;
@synthesize friView;
@synthesize satView;
@synthesize sunView;
@synthesize trainName;
@synthesize trainSchedule;
@synthesize stationsTableView;
@synthesize categoryImageView;
@synthesize trainNumberKind;
@synthesize trainNote;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
-(id)initWithQueryType:(NSInteger)queryType withKey:(NSString*)key withStartStationId:(NSString*)startStationId withDestStationId:(NSString*)destStationId{
	if((self=[super init])){
		thisQueryType=queryType;
		if(queryType==TrainType)
			thisDataObject=[TrafficDataModel getTrainInfoObject:key withStartId:startStationId withDestId:destStationId];
		else if(queryType==HighSpeedType)
			thisDataObject=[TrafficDataModel getHighSpeedInfoObjectWithTrainId:key withStartId:startStationId withDestId:destStationId];
		[thisDataObject retain];
	}
	return self;
}

/*
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
	[thisDataObject release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationItem setTitle:trainNumberKind];
	[self.categoryImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.categoryPic]]];
	[self.trainName setText:thisDataObject.trainName];
	[self.trainSchedule setText:thisDataObject.trainSchedule];
	if(thisQueryType==HighSpeedType){
		[self.trainNote setHidden:YES];
		[self.monView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.monPic]]];
		[self.tueView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.tuePic]]];
		[self.wedView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.wedPic]]];
		[self.thuView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.thuPic]]];
		[self.friView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.friPic]]];
		[self.satView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.satPic]]];
		[self.sunView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisDataObject.sunPic]]];
	}else
		[self.trainNote setText:thisDataObject.note];
		
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [thisDataObject.trainStationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TrainInfoListCell *thisCell=(TrainInfoListCell*)[tableView dequeueReusableCellWithIdentifier:@"TrainInfoListCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"TrainInfoListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[TrainInfoListCell class]]){
				thisCell=(TrainInfoListCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];
	}
	int myIndex=[indexPath row];
	TrainStationObject *thisCellDataObject=(TrainStationObject*)[thisDataObject.trainStationArray objectAtIndex:myIndex];
	UIImage *lineImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisCellDataObject.stationLinePic]];
	[thisCell.lineImageView setImage:lineImage];
	[thisCell.selectedStationImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisCellDataObject.stationPassPic]]];
	[thisCell.stationNameLabel setText:thisCellDataObject.stationName];
	[thisCell.timeLabel setText:thisCellDataObject.arrivedTime];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 64;
}

@end
