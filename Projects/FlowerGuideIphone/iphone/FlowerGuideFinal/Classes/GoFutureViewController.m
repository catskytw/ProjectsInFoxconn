//
//  GoFutureViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoFutureViewController.h"
#import "TransListObject.h"
#import "GoFutureModel.h"
#import "Vars.h"
#import "AboutFutureMainPageCell.h"
#import "CommonContentDescriptionView.h"
#import "LocalizationSystem.h"
#import "ToolsFunction.h"
@implementation GoFutureViewController

-(id)init{
	if((self=[super init])){
		dataArray=[[GoFutureModel getTransportationTypeList]retain];
	}
	return self;
}

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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[titleLabel setText:AMLocalizedString(@"trafficMode",nil)];
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
	[dataArray release];
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return CellHeightStyleMedium;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowIndex=[indexPath row];
	//模版與AboutFutureMainPageCell一樣,借用
	AboutFutureMainPageCell *thisCell=(AboutFutureMainPageCell*)[tableView dequeueReusableCellWithIdentifier:@"AboutFutureMainPageCell"];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"AboutFutureMainPageCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[AboutFutureMainPageCell class]]){
				thisCell=(AboutFutureMainPageCell*)currentObject;
				break;
			}
		}
		[thisCell setBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green.png"]]autorelease]];
		[thisCell setSelectedBackgroundView:[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"contentui_btn_menu_green_i.png"]]autorelease]];
	}
	int indicator=rowIndex%2;
	TransListObject *tmpObject=(TransListObject*)[dataArray objectAtIndex:rowIndex];
	[thisCell.contentLabel setText:tmpObject.transName];
	[thisCell.contentImageView setImage:(indicator==0)?[UIImage imageNamed:@"contentui_icon_menu_blue.png"]:[UIImage imageNamed:@"contentui_icon_menu_orange.png"]];
	return thisCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if([ToolsFunction hasConnected]){
		int row=[indexPath row];
		TransListObject *selected=(TransListObject*)[dataArray objectAtIndex:row];
		NSString *key=[NSString stringWithString:selected.transId];
		ContentObject *dataObject=(ContentObject*)[GoFutureModel getTransportationInfo:key];
		CommonContentDescriptionView *nextController=[[CommonContentDescriptionView alloc]initWithDataObject:dataObject];
		[self.navigationController pushViewController:nextController animated:YES];
		[nextController release];
	}
}

@end
