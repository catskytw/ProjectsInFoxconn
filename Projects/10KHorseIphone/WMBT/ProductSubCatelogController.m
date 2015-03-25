//
//  ProductSubCatelogController.m
//  WMBT
//
//  Created by link on 2011/6/4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ProductSubCatelogController.h"
#import "FcProductListViewController.h"
#import "MainMenuViewController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "UITuneLayout.h"

@implementation ProductSubCatelogController
@synthesize catelogIndexPath, mainController,mainSelectedKey,mainSelectedName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sCategoryDic=[[NSMutableDictionary alloc]init];
        sortArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)loadData{
	self.title = mainSelectedName;
	QueryPattern *mCategoryQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[mCategoryQuery prepareDic:searchSCategory(mainSelectedKey)];
    @try {
        for(int i=0;i<[mCategoryQuery getNumberForKey:@"id"];i++){
            NSString *key=[mCategoryQuery getValue:@"id" withIndex:i];
            NSString *value=[mCategoryQuery getValue:@"name" withIndex:i];
            [sCategoryDic setValue:value forKey:key];
            [sortArray addObject:key];
        }
    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [mCategoryQuery release];
    }
	
	
}
- (void)dealloc
{
    [subCatelogTable release];
    [sortArray release];
    if(mainSelectedName!=nil)
		[mainSelectedName release];
	if(mainSelectedKey!=nil)
		[mainSelectedKey release];
	if(sCategoryDic!=nil)
		[sCategoryDic release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    subCatelogTable.delegate =self;
    subCatelogTable.dataSource =self;
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [subCatelogTable release];
    subCatelogTable = nil;
    if (sCategoryDic) {
        [sCategoryDic release];
        sCategoryDic =nil;
    }
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [sortArray count];
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

	NSString *mainKey=[sortArray objectAtIndex:indexPath.row];
	cell.textLabel.text =  (NSString*)[sCategoryDic valueForKey:mainKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	FcProductListViewController *productListController = [[FcProductListViewController alloc] initWithNibName:@"FcProductListViewController" bundle:nil];
	productListController.mainController = mainController;
	NSString *mainKey=[sortArray objectAtIndex:indexPath.row];
	productListController.mainSelectedKey = mainKey;
	productListController.mainSelectedName = (NSString*)[sCategoryDic valueForKey:mainKey];
	[productListController loadBrandData:mainKey andSort:0];
	[((MainMenuViewController*)mainController).mainNavigation pushViewController:productListController animated:YES];
	[productListController release];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return 52;
}

@end
