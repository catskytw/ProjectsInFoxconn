//
//  MRTList.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MRTList.h"
#import "MRTListCell.h"
#import "TrafficDataModel.h"
#import "MRTListObject.h"
#import "MRTDescriptionViewController.h"
#import "Vars.h"
#import "MRTMapViewController.h"
@implementation MRTList


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		contentArray=[[TrafficDataModel getAllMRTLine]retain];
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

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationItem setTitle:AMLocalizedString(@"TRTCLineSearch",nil)];
	UIBarButtonItem *mrtButton=[[UIBarButtonItem alloc]initWithTitle:AMLocalizedString(@"TRTCMap",nil) style:UIBarButtonItemStylePlain target:self action:@selector(enterMRTMap)];
	[self.navigationItem setRightBarButtonItem:mrtButton animated:YES];
	[mrtButton release];
}
- (void)dealloc {
	[contentArray release];
    [super dealloc];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	MRTListCell *thisCell=(MRTListCell*)[tableView dequeueReusableCellWithIdentifier:@"MRTListCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"MRTListCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[MRTListCell class]]){
				thisCell=(MRTListCell*)currentObject;
				break;
			}
		}
		thisCell.selectedBackgroundView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:DefaultCellSelectedBackground]]autorelease];

	}
	int myIndex=[indexPath row];
	MRTListObject *thisObject=(MRTListObject*)[contentArray objectAtIndex:myIndex];
	[thisCell.mrtLineName setText:thisObject.mrtLineName];
	[thisCell.categoryImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thisObject.picName]]];
	[thisCell.mrtLineId setText:thisObject.mrtLineId];
	return thisCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	MRTListCell *thisCell=(MRTListCell*)[tableView cellForRowAtIndexPath:indexPath];
	NSString *lineId=thisCell.mrtLineId.text;
	MRTDescriptionViewController *bdvc=[[MRTDescriptionViewController alloc]initWithKey:lineId];
	[self.navigationController pushViewController:bdvc animated:YES];
	[bdvc release];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return cellHeightTypeSmall;
}

-(void)enterMRTMap{
	MRTMapViewController *mvc=[MRTMapViewController new];
	[self.navigationController pushViewController:mvc animated:YES];
	[mvc release];
}
@end
