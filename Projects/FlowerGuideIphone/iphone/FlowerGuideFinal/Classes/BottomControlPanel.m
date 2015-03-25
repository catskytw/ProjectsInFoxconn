//
//  BottomControlPanel.m
//  FlowerGuide
//
//  Created by Liao Change on 9/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BottomControlPanel.h"
#import "BottomTableCell.h"
#import "ExhibitionCellObject.h"
#import "Vars.h"
#import "LocalizationSystem.h"
#import "ToolsFunction.h"
@implementation BottomControlPanel
@synthesize switchBtn,contentTable,isOpen;
-(id)init{
	if((self=[super init])){
		isOpen=NO;
	}
	return self;
}
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	contentTable.separatorColor=[UIColor colorWithRed:(CGFloat)108/255 green:(CGFloat)110/255 blue:(CGFloat)112/255 alpha:1];
	[self.view setFrame:CGRectMake(145, 224+130, 175, 157)];//145,224是完全顯示時之座標,130是該view的高度,224+130是將其隱藏

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)changeValue:(ExhibitionInfoObject*)dataObject{
	exhibitionDataArray=dataObject.neighbor;
	[contentTable reloadData];
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//固定為1個section
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//固定為三筆
    return [exhibitionDataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int rowIndex=[indexPath row];
	NSString *CellIdentifier = @"BottomTableCell";
	BottomTableCell *thisCell=(BottomTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(thisCell==nil){
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"BottomTableCell" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[UITableViewCell class]]){
				thisCell=(BottomTableCell*)currentObject;
				break;
			}
		}
	}
	//資料物件有值
	if([exhibitionDataArray count]>0){
		ExhibitionCellObject *thisDataObject=(ExhibitionCellObject*)[exhibitionDataArray objectAtIndex:rowIndex];
		[thisCell.infoBtn setTitle:[NSString stringWithFormat:@"%i",rowIndex] forState:UIControlStateNormal];
		[thisCell.forwardBtn setTitle:[NSString stringWithFormat:@"%i",rowIndex] forState:UIControlStateNormal];
		[thisCell.descLabel setText:thisDataObject.nPtName];
	}
	[thisCell.infoBtn addTarget:self action:@selector(descriptionAction:) forControlEvents:UIControlEventTouchUpInside];
	[thisCell.forwardBtn addTarget:self action:@selector(forwardAction:) forControlEvents:UIControlEventTouchUpInside];
	return thisCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[switchBtn release];
	[contentTable release];
    [super dealloc];
}

-(IBAction)switchBtn:(id)sender{
	NSInteger yPosition=self.view.frame.origin.y;
	NSInteger newYPosition=(isOpen)?(yPosition+130):(yPosition-130);
	
	[UIView beginAnimations:@"BottomPanelSwitch" context:nil];
	[UIView setAnimationDuration:0.75];
	[self.view setFrame:CGRectMake(self.view.frame.origin.x, newYPosition, self.view.frame.size.width, self.view.frame.size.height)];
	[UIView commitAnimations];
	NSString *switchBtnString=(isOpen)?@"mapui_btn_dpanel_open":@"mapui_btn_dpanel_close";
	[switchBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",switchBtnString]] forState:UIControlStateNormal];
	[switchBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_i.png",switchBtnString]] forState:UIControlStateHighlighted];
	
	isOpen=!isOpen;
}
-(IBAction)forwardAction:(id)sender{
	if([ToolsFunction hasConnected]){
		UIButton *thisButton=(UIButton*)sender;
		ExhibitionCellObject *thisDataObject=(ExhibitionCellObject*)[exhibitionDataArray objectAtIndex:[thisButton.titleLabel.text intValue]];
		destinationString=[NSString stringWithString:thisDataObject.nExhibitPtId];
		NSMutableDictionary *dataDic=[NSMutableDictionary dictionaryWithObject:destinationString forKey:@"destinationId"];
		[[NSNotificationCenter defaultCenter]postNotificationName:MapDrawingNotificationName object:nil userInfo:dataDic];
	}
}
-(IBAction)descriptionAction:(id)sender{
	UIButton *thisButton=(UIButton*)sender;
	ExhibitionCellObject *thisDataObject=(ExhibitionCellObject*)[exhibitionDataArray objectAtIndex:[thisButton.titleLabel.text intValue]];
	destinationString=[NSString stringWithString:thisDataObject.nExhibitPtId];
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:thisDataObject.nPtName message:thisDataObject.nPtDesc delegate:self cancelButtonTitle:nil otherButtonTitles:AMLocalizedString(@"StartToMove",nil),AMLocalizedString(@"Cancel",nil),nil];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	//0表示前往
	if(buttonIndex==0){
		NSMutableDictionary *dataDic=[NSMutableDictionary dictionaryWithObject:destinationString forKey:@"destinationId"];
		[[NSNotificationCenter defaultCenter]postNotificationName:MapDrawingNotificationName object:nil userInfo:dataDic];
	}
	[alertView release];
}


-(void)setButtonEnable{
	for(int i=0;i<3;i++){
		NSIndexPath *index=[NSIndexPath indexPathForRow:i inSection:0];
		BottomTableCell *thisCell=(BottomTableCell*)[contentTable cellForRowAtIndexPath:index];
		[thisCell.forwardBtn setEnabled:YES];
		[thisCell.infoBtn setEnabled:YES];
	}
}

-(void)setButtonDisable{
	for(int i=0;i<3;i++){
		NSIndexPath *index=[NSIndexPath indexPathForRow:i inSection:0];
		BottomTableCell *thisCell=(BottomTableCell*)[contentTable cellForRowAtIndexPath:index];
		[thisCell.forwardBtn setEnabled:NO];
		[thisCell.infoBtn setEnabled:NO];
	}
}
@end

