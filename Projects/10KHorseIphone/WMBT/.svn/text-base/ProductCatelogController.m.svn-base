//
//  ProductCatelogController.m
//  WMBT
//
//  Created by link on 2011/6/4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ProductCatelogController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "UITuneLayout.h"
#import "MainMenuViewController.h"
#import "ProductSubCatelogController.h"

@implementation ProductCatelogController
@synthesize mainController,catelogTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mCategoryDic=[[NSMutableDictionary alloc]init];
        sortArray = [[NSMutableArray alloc]init];
		[self loadAllCategory];
		self.title = AMLocalizedString(@"MainMenu_Catelog",nil);
    }
    return self;
}
-(void)loadAllCategory{
	QueryPattern *mCategoryQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[mCategoryQuery prepareDic:searchMCategory()];
	
    @try {
        NSInteger totalMCategory=[mCategoryQuery getNumberForKey:@"id"];
        //load all main category.
        for(int i=0;i<totalMCategory;i++){
            NSString *key=[mCategoryQuery getValue:@"id" withIndex:i];
            NSString *value=[mCategoryQuery getValue:@"name" withIndex:i];
            [mCategoryDic setValue:value forKey:key];
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
    [catelogTable release];
    [sortArray release];
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
    catelogTable.delegate =self;
    catelogTable.dataSource =self;
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [catelogTable release];
    catelogTable = nil;
    [mCategoryDic release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [sortArray count];
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
	NSString *mainKey=[sortArray objectAtIndex:indexPath.row];
	cell.textLabel.text =  (NSString*)[mCategoryDic valueForKey:mainKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return 52;
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	ProductSubCatelogController *subCatelogController = [[ProductSubCatelogController alloc] init];
	subCatelogController.mainController = mainController;
	subCatelogController.catelogIndexPath = indexPath;
	NSString *mainKey=[sortArray objectAtIndex:indexPath.row];
	subCatelogController.mainSelectedKey = mainKey;
	subCatelogController.mainSelectedName = (NSString*)[mCategoryDic valueForKey:mainKey];
	[subCatelogController loadData];
	[((MainMenuViewController*)mainController).mainNavigation pushViewController:subCatelogController animated:YES];
	[subCatelogController release];
	
}

@end
