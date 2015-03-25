//
//  SubCatelogController.m
//  WMBT
//
//  Created by link on 2011/2/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubCatelogController.h"
#import "FcProductListViewController.h"
#import "MainMenuViewController.h"
#import "QueryPattern.h"
#import "Configure.h"
@implementation SubCatelogController

@synthesize catelogIndexPath, mainController,mainSelectedKey,mainSelectedName;

#pragma mark -
#pragma mark View lifecycle
- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		sCategoryDic=[[NSMutableDictionary alloc]init];
	}
	return self;
}
- (void)loadData{
	self.title = mainSelectedName;
	QueryPattern *mCategoryQuery=[QueryPattern new];
	[mCategoryQuery prepareDic:searchSCategory(mainSelectedKey)];
	for(int i=0;i<[mCategoryQuery getNumberForKey:@"id"];i++){
		NSString *key=[mCategoryQuery getValue:@"id" withIndex:i];
		NSString *value=[mCategoryQuery getValue:@"name" withIndex:i];
		[sCategoryDic setValue:value forKey:key];
	}
	[mCategoryQuery release];
}
/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [[[theShows objectAtIndex:catelogIndexPath.row] valueForKey:@"Characters"] count];
	return [[sCategoryDic allKeys]count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"SubCatelog";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:MyIdentifier] autorelease];
	}
	//TVAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSString *mainKey=[[sCategoryDic allKeys] objectAtIndex:indexPath.row];
	cell.textLabel.text =  (NSString*)[sCategoryDic valueForKey:mainKey];
	//cell.textLabel.text =  [[[theShows objectAtIndex:catelogIndexPath.row] valueForKey:@"Characters"] objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
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
	FcProductListViewController *productListController = [[FcProductListViewController alloc] initWithNibName:@"FcProductListViewController" bundle:nil];
	productListController.mainController = mainController;
	NSString *mainKey=[[sCategoryDic allKeys] objectAtIndex:indexPath.row];
	productListController.mainSelectedKey = mainKey;
	productListController.mainSelectedName = (NSString*)[sCategoryDic valueForKey:mainKey];
	[productListController loadBrandData:mainKey];
	[((MainMenuViewController*)mainController).mainNavigation pushViewController:productListController animated:YES];
	[productListController release];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return 52;
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
}


- (void)dealloc {
	if(mainSelectedName!=nil)
		[mainSelectedName release];
	if(mainSelectedKey!=nil)
		[mainSelectedKey release];
	if(sCategoryDic!=nil)
		[sCategoryDic release];
	
    [super dealloc];
}


@end

