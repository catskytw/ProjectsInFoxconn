//
//  MainCatelogController.m
//  WMBT
//
//  Created by link on 2011/2/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainCatelogController.h"
#import "MainMenuViewController.h"
#import "SubCatelogController.h"
#import "QueryPattern.h"
#import "Configure.h"
@implementation MainCatelogController
@synthesize mainController;

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		mCategoryDic=[[NSMutableDictionary alloc]init];
		sCategoryDic=[[NSMutableDictionary alloc]init];
		[self loadAllCategory];
		self.title = AMLocalizedString(@"MainMenu_Catelog",nil);
	}
	return self;
}
-(void)loadAllCategory{
	QueryPattern *mCategoryQuery=[QueryPattern new];
	[mCategoryQuery prepareDic:searchMCategory()];
	NSInteger totalMCategory=[mCategoryQuery getNumberForKey:@"id"];
	//load all main category.
	for(int i=0;i<totalMCategory;i++){
		NSString *key=[mCategoryQuery getValue:@"id" withIndex:i];
		NSString *value=[mCategoryQuery getValue:@"name" withIndex:i];
		[mCategoryDic setValue:value forKey:key];
		[sCategoryDic setValue:[NSNull null] forKey:key];
	}
	for(NSString *sKey in [mCategoryDic allKeys]){
		[mCategoryQuery prepareDic:searchSCategory(sKey)];
		NSMutableDictionary *sDic=[[NSMutableDictionary alloc]init];
		for(int i=0;i<[mCategoryQuery getNumberForKey:@"id"];i++){
			NSString *key=[mCategoryQuery getValue:@"id" withIndex:i];
			NSString *value=[mCategoryQuery getValue:@"name" withIndex:i];
			[sDic setValue:value forKey:key];
		}
		[sCategoryDic setValue:sDic forKey:sKey];
        [sKey release];
        [sDic release];
	}
	
	[mCategoryQuery release];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return <#number of sections#>;
}*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [[mCategoryDic allKeys]count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"Catelog";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:MyIdentifier] autorelease];
	}
	//TVAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *mainKey=[[mCategoryDic allKeys] objectAtIndex:indexPath.row];
	cell.textLabel.text =  (NSString*)[mCategoryDic valueForKey:mainKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return 52;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	SubCatelogController *subCatelogController = [[SubCatelogController alloc] initWithStyle:UITableViewStylePlain];
	subCatelogController.mainController = mainController;
	subCatelogController.catelogIndexPath = indexPath;
	NSString *mainKey=[[mCategoryDic allKeys] objectAtIndex:indexPath.row];
	subCatelogController.mainSelectedKey = mainKey;
	subCatelogController.mainSelectedName = (NSString*)[mCategoryDic valueForKey:mainKey];
	[subCatelogController loadData];
	[((MainMenuViewController*)mainController).mainNavigation pushViewController:subCatelogController animated:YES];
	[subCatelogController release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[mCategoryDic release];
	[sCategoryDic release];
}


- (void)dealloc {
    [super dealloc];
}


@end

