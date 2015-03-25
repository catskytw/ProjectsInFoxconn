//
//  FeatureListViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeatureListViewController.h"
#import "FeatureDataObject.h"
#import "AboutFutureModel.h"
#import "FeatureTableCell.h"
#import "ToolsFunction.h"
#import "Vars.h"
@implementation FeatureListViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
		contentTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 343)];
		thisDataObject=[[AboutFutureModel getExhibitFeature]retain];
	}
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[self tableSetting];
	[titleLabel setText:thisDataObject.title];
	[viewPortView addSubview:contentTable];
	[super viewWillAppear:animated];
	[rightBtn setHidden:NO];
}

-(void)tableSetting{
	contentTable.delegate=self;
	contentTable.dataSource=self;
	[contentTable setBackgroundColor:[UIColor clearColor]];
	contentTable.separatorColor=[UIColor clearColor];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
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
	[contentTable release];
    [super dealloc];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return CellHeightStyleHuge;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return ceil((double)[thisDataObject.contentArray count]/3.0f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowIndex=[indexPath row];
	FeatureTableCell *thisCell=(FeatureTableCell*)[tableView dequeueReusableCellWithIdentifier:@"FeatureTableCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FeatureTableCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[FeatureTableCell class]]){
				thisCell=(FeatureTableCell*)currentObject;
				break;
			}
		}
	}

	for(int i=0;i<3;i++){
		int arrayIndex=rowIndex*3+i;
		//若大於資料物件的最大值,跳出.
		if(arrayIndex>[thisDataObject.contentArray count]-1) break;
		FeatureDataObject *dataObject=(FeatureDataObject*)[thisDataObject.contentArray objectAtIndex:arrayIndex];
		switch (i) {
			case 0:
				[thisCell.title1 setText:dataObject.featureName];
				[thisCell.button1.titleLabel setText:dataObject.featureId];
				[ToolsFunction getImageFromURL:dataObject.featureImageUrlString withTargetButton:thisCell.button1];
				[thisCell.title1 setHidden:NO];
				[thisCell.button1 setHidden:NO];
				break;
			case 1:
				[thisCell.title2 setText:dataObject.featureName];
				[thisCell.button2.titleLabel setText:dataObject.featureId];
				[ToolsFunction getImageFromURL:dataObject.featureImageUrlString withTargetButton:thisCell.button2];
				[thisCell.title2 setHidden:NO];
				[thisCell.button2 setHidden:NO];
				break;
			case 2:
				[thisCell.title3 setText:dataObject.featureName];
				[thisCell.button3.titleLabel setText:dataObject.featureId];
				[ToolsFunction getImageFromURL:dataObject.featureImageUrlString withTargetButton:thisCell.button3];
				[thisCell.title3 setHidden:NO];
				[thisCell.button3 setHidden:NO];
				break;
			default:
				break;
		}
	}
	thisCell.currentNavigationController=self.navigationController;
	return thisCell;
}

@end
