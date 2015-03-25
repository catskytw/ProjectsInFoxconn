//
//  TrainList.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrainList.h"
#import "TrainListCell.h"
#import "TrafficDataModel.h"
#import "TrainHSListObject.h"
#import "TrainInfoList.h"
#import "Vars.h"
@implementation TrainList
@synthesize mainViewName;
@synthesize mainViewDescription;

//pageType: trainType,HighspeedType,表示火車或高鐵
-(id)initWithDataDictionary:(NSDictionary*)datadic withType:(NSInteger)pageType withStartStationId:(NSString*)startStationId withDestStationId:(NSString*)destStationId{
	if((self=[super init])){
		contentDic=[[NSMutableDictionary dictionaryWithDictionary:datadic]retain];
		contentObjectArray=(NSArray*)[contentDic objectForKey:@"trainList"];
		startId=[[NSString stringWithString:startStationId]retain];
		destId=[[NSString stringWithString:destStationId]retain];
		queryType=pageType;
	}
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentArray=[[TrafficDataModel getAllTrainLineBetweenTwoStations:@"" withEndStation:@""]retain];
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
	[contentDic release];
	[mainViewName release];
	[mainViewDescription release];
	[startId release];
	[destId release];
    [super dealloc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return cellHeightTypeLarge;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [contentObjectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	TrainListCell *thisCell=(TrainListCell*)[tableView dequeueReusableCellWithIdentifier:@"TrainListCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"TrainListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[TrainListCell class]]){
				thisCell=(TrainListCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	TrainHSListObject *thisCellDataObject=(TrainHSListObject*)[contentObjectArray objectAtIndex:myIndex];
	[thisCell.categoryImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisCellDataObject.categoryPicName]]];
	[thisCell.name setText:thisCellDataObject.trainName];
	[thisCell.brief setText:thisCellDataObject.briefString];
	[thisCell.duration setText:thisCellDataObject.durationString];
	[thisCell.trainId setText:thisCellDataObject.trainId];
	return thisCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	TrainListCell *thisCell=(TrainListCell*)[tableView cellForRowAtIndexPath:indexPath];
	TrainInfoList *til=[[TrainInfoList alloc]initWithQueryType:queryType withKey:thisCell.trainId.text withStartStationId:startId withDestStationId:destId];
	til.trainNumberKind=[NSString stringWithString:thisCell.name.text];
	[self.navigationController pushViewController:til animated:YES];
	[til release];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationItem setTitle:AMLocalizedString(@"SearchResult",nil)];
	[mainViewName setText:(NSString*)[contentDic objectForKey:@"trainLine"]];
	[mainViewDescription setText:(NSString*)[contentDic objectForKey:@"startTime"]];

    [super viewWillAppear:animated];	
}
@end
