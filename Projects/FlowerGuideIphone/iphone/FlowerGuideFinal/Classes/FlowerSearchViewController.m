//
//  FlowerSearchViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerSearchViewController.h"
#import "AboutFutureModel.h"
#import "AboutFutureMainPageCell.h"
#import "AreaListObject.h"
#import "Vars.h"
#import "FlowerListBaseViewController.h"
#import "FlowerSearchResultBaseController.h"
#import "ToolsFunction.h"
@implementation FlowerSearchViewController
@synthesize thisContentTable,thisSearchTextField,searchBtn,subTitleLabel,titleIcon,parentNavigationController,noDataLabel;

-(id)initWithAreaList{
	if((self=[super init])){
		dataArray=[[AboutFutureModel getAreaList:@""]retain];
	}
	return self;
}
- (void)dealloc {
	[dataArray release];
    [super dealloc];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	disableKeyBoardBtn=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
	[disableKeyBoardBtn setBackgroundColor:[UIColor clearColor]];
	[disableKeyBoardBtn setFrame:CGRectMake(0, 0, 320, 480)];
	[disableKeyBoardBtn addTarget:self action:@selector(disableKeyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	[self.view addSubview:disableKeyBoardBtn];
	return YES;
}
-(void)disableKeyBoardAction:(id)sender{
	[thisSearchTextField resignFirstResponder];
	[disableKeyBoardBtn removeFromSuperview];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[disableKeyBoardBtn removeFromSuperview];
	return [textField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	int rowIndex=[indexPath row];
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
	AreaListObject *thisDataObject=(AreaListObject*)[dataArray objectAtIndex:rowIndex];
	[thisCell.contentLabel setText:thisDataObject.name];
	[thisCell.contentImageView setImage:(indicator==0)?[UIImage imageNamed:@"contentui_icon_menu_blue.png"]:[UIImage imageNamed:@"contentui_icon_menu_orange.png"]];
	[thisCell.textLabel setText:thisDataObject.areaId];
	return thisCell;	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return CellHeightStyleMedium;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if([ToolsFunction hasConnected]==YES){
		int rowIndex=[indexPath row];
		AreaListObject *selectedDataObject=(AreaListObject*)[dataArray objectAtIndex:rowIndex];
		//TODO nextViewController
		FlowerListBaseViewController *nextViewController=[[FlowerListBaseViewController alloc]initWithAreaId:selectedDataObject.areaId];
		[parentNavigationController pushViewController:nextViewController animated:YES];
		[nextViewController release];
	}
}

-(IBAction)searchFlowerAction:(id)sender{
	FlowerSearchResultBaseController *nextViewController=[[FlowerSearchResultBaseController alloc]initWithFlowerName:thisSearchTextField.text];
	[parentNavigationController pushViewController:nextViewController animated:NO];
	[nextViewController release];
}
@end
