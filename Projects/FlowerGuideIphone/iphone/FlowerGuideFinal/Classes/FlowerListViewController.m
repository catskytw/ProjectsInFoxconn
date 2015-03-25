//
//  FlowerListViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerListViewController.h"
#import "AboutFutureModel.h"
#import "NewsCell.h"
#import "FlowerDataObject.h"
#import "FlowerInfoBaseViewController.h"
#import "ToolsFunction.h"
@implementation FlowerListViewController
@synthesize dataObject;
-(id)initWithAreaId:(NSString*)areaId{
	if((self=[super init])){
		dataArray=nil;
		dataObject=[[AboutFutureModel getFlowerListByAreaId:areaId]retain];
	}
	return self;
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"FlowerSearchViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[thisContentTable setFrame:CGRectMake(0, 73, 320, 270)];
	[titleIcon setHidden:YES];
	[subTitleLabel setHidden:YES];
}


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
	[dataObject release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [dataObject.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowIndex=[indexPath row];
	//版型與newscell相同,借用.
	NewsCell *thisCell=(NewsCell*)[tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[NewsCell class]]){
				thisCell=(NewsCell*)currentObject;
				break;
			}
		}
		[thisCell setBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green.png"]]autorelease]];
		[thisCell setSelectedBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green_i.png"]]autorelease]];
	}
	FlowerDataObject *thisDataObject=(FlowerDataObject*)[dataObject.contentArray objectAtIndex:rowIndex];
	[thisCell.date setText:thisDataObject.name];
	[thisCell.subject setText:thisDataObject.desc];
	[thisCell.newsId setText:thisDataObject.flowerId];
	return thisCell;	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if([ToolsFunction hasConnected]){
		int rowIndex=[indexPath row];
		FlowerDataObject *thisDataObject=(FlowerDataObject*)[dataObject.contentArray objectAtIndex:rowIndex];
		FlowerInfoBaseViewController *nextController=[[FlowerInfoBaseViewController alloc]initWithFlowerId:thisDataObject.flowerId];
		[parentNavigationController pushViewController:nextController animated:YES];
		[nextController release];
	}
}
@end
