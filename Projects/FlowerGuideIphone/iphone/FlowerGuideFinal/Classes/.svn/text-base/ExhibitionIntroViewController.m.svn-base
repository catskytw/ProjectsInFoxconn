//
//  ExhibitionIntroViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExhibitionIntroViewController.h"
#import "Vars.h"
#import "AboutFutureMainPageCell.h"
#import "AreaListObject.h"
#import "AboutFutureModel.h"
#import "LocalizationSystem.h"
#import "ExhibitionMapViewController.h"
#import "AreaInfoObject.h"
#import "CommonContentDescriptionView.h"
#import "GoFutureModel.h"
#import "ToolsFunction.h"
@implementation ExhibitionIntroViewController

-(id)initwithAreaKey:(NSString*)areaKey{
	if((self=[super init])){
		areaDataArray=[[AboutFutureModel getAreaList:areaKey]retain];
	}
	return self;
}
- (void)dealloc {
	[areaDataArray release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[titleLabel setText:AMLocalizedString(@"ExhibitIntro",nil)];
	[rightUpBtn setTitle:AMLocalizedString(@"IconInfo",nil) forState:UIControlStateNormal];
	[rightUpBtn setTitle:AMLocalizedString(@"IconInfo",nil) forState:UIControlStateHighlighted];
	[rightUpBtn setHidden:NO];
	[rightBtn setHidden:NO];
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"BaseViewController" bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
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

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
	return [areaDataArray count];
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
	AreaListObject *thisDataObject=(AreaListObject*)[areaDataArray objectAtIndex:rowIndex];
	[thisCell.contentLabel setText:thisDataObject.name];
	[thisCell.contentImageView setImage:(indicator==0)?[UIImage imageNamed:@"contentui_icon_menu_blue.png"]:[UIImage imageNamed:@"contentui_icon_menu_orange.png"]];
	[thisCell.textLabel setText:thisDataObject.areaId];
	return thisCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return CellHeightStyleMedium;
}
-(IBAction)rightUpBtnAction:(id)sender{
	ExhibitionMapViewController *nextViewController=[ExhibitionMapViewController new];
	//將data array指向地圖的資料指標
	nextViewController.exhibitionDataArray=areaDataArray;
	[self.navigationController pushViewController:nextViewController animated:YES];
	[nextViewController release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if([ToolsFunction hasConnected]){
		int rowIndex=[indexPath row];
		AreaListObject *thisDataObject=(AreaListObject*)[areaDataArray objectAtIndex:rowIndex];
		
		AreaInfoObject *nextViewDataObject=[GoFutureModel getAreaInfo:thisDataObject.areaId];
		ContentObject *inputDataObject=[ContentObject new];
		
		inputDataObject.picUrl=(nextViewDataObject.picURL==nil)?nil:[NSString stringWithString:nextViewDataObject.picURL];
		inputDataObject.title=[NSString stringWithString:nextViewDataObject.title];
		inputDataObject.contentArray=[NSArray arrayWithArray:nextViewDataObject.descList];
		
		CommonContentDescriptionView *nextController=[[CommonContentDescriptionView alloc]initWithDataObject:inputDataObject];
		[self.navigationController pushViewController:nextController animated:YES];
		[nextController release];
		[inputDataObject release];
	}
}
@end
