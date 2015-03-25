//
//  PromotionListVewController.m
//  WMBT
//
//  Created by link on 2011/5/26.
//  Copyright 2011年 Foxconn. All rights reserved.
//

#import "PromotionListViewController.h"

#import "QueryPattern.h"
#import "Configure.h"
#import "ProductListCellDataObject.h"
#import "LocalizationSystem.h"
#import "ProductListCellDataObject.h"
#import "ProductInfoController.h"
#import "MainMenuViewController.h"
#import "UITuneLayout.h"
@implementation PromotionListViewController
@synthesize mainController,productListArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        productListArray = [[NSMutableArray arrayWithObjects:nil]retain];	
		SectionDic = [[NSMutableDictionary dictionaryWithObjects:nil forKeys:nil]retain];	
        //self.title = AMLocalizedString(@"MainMenu_Promote",nil);
        self.navigationItem.title = AMLocalizedString(@"MainMenu_Promote",nil);
        self.navigationItem.backBarButtonItem.title = AMLocalizedString(@"title_backhome",nil);
    }
    return self;
}

- (void)dealloc
{
    if(productListArray!=nil)
		[productListArray release];
    if(SectionDic!=nil)
		[SectionDic release];
    if (sectionArray != nil) {
        [sectionArray release];
    }
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
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
	for (int i = 0; i< [productListArray count]; i++) {
		if (section == i) 
			return [[productListArray objectAtIndex:i] count];
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return [self getFcProductListViewCell:tableView andIndexPath:indexPath];	

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    ProductInfoController *productInfoController = [[ProductInfoController alloc] initWithNibName:@"ProductInfoController" bundle:nil];
    ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[[productListArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	productInfoController.mainController = mainController;
	productInfoController.sID = cellDO.productId;
    //NSLog(@"didSelectRowAtIndexPath section:%d row:%d name:%@",indexPath.section,indexPath.row, cellDO.productName);
	[((MainMenuViewController*)mainController).mainNavigation pushViewController:productInfoController animated:YES];
    [productInfoController release];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //NSLog(@"titleForHeaderInSection %d %@",section, [[SectionDic allValues] objectAtIndex:section]);
	return [sectionArray objectAtIndex:section];
}
-(void) setCellInfo:(FcProductTableCell*)cell andIndexPath:(NSIndexPath *)indexPath{
    
	ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[[productListArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
   // NSLog(@"setCellInfo section:%d row:%d name:%@", indexPath.section, indexPath.row, cellDO.productName);
	[cell setInfoDO:cellDO andController:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	
    [self getFcProductListViewCell:tableView andIndexPath:indexPath];
	return cellHeight;
}
-(UITableViewCell *)getFcProductListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
	FcProductTableCell *cell = (FcProductTableCell*)[tableView dequeueReusableCellWithIdentifier:@"FcProductTableCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FcProductListTableCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
    cellHeight = cell.frame.size.height;
    [self setCellInfo:cell andIndexPath:indexPath];
    //NSLog(@"getFcProductListViewCell section:%d row:%d name:%@", indexPath.section, indexPath.row, cell.lblName.text);
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return index;
}
-(void)loadProductData:(QueryPattern*)mProductQuery {
    
	NSMutableArray *productArray = [[NSMutableArray arrayWithObjects:nil]retain];
	for(int i=0;i<[mProductQuery getNumberUnderNode:@"productList" withKey:@"id" ];i++){
		ProductListCellDataObject *cellDO = [ProductListCellDataObject new];
		cellDO.productId=[mProductQuery getValueUnderNode:@"productList" withKey:@"id" withIndex:i];
		cellDO.productName=[mProductQuery getValueUnderNode:@"productList" withKey:@"name" withIndex:i];
		cellDO.brand = [mProductQuery getValueUnderNode:@"productList" withKey:@"brand" withIndex:i];
		cellDO.price = [mProductQuery getValueUnderNode:@"productList" withKey:@"retailPrice" withIndex:i];
		cellDO.imgUrl = [mProductQuery getValueUnderNode:@"productList" withKey:@"image46" withIndex:i];
		cellDO.score = [mProductQuery getValueUnderNode:@"productList" withKey:@"score" withIndex:i];
		[productArray addObject:cellDO];
        //NSLog(@"%d productData id:%@ name:%@",i,cellDO.productId, cellDO.productName);
		[cellDO release];
	}
	[productListArray addObject:productArray];
	[productArray release];
}
-(void)loadData{
	if(SectionDic==nil)
		SectionDic=[[NSMutableDictionary dictionary]retain];
	else {
		[SectionDic removeAllObjects];
	}	
    if (sectionArray ==nil) {
        sectionArray=[[NSMutableArray array]retain];
    }else{
        [sectionArray removeAllObjects];
    }
	if(productListArray==nil)
        productListArray=[[NSMutableArray array]retain];
    else {
        [productListArray removeAllObjects];
    }
	QueryPattern *promotionQuery=[QueryPattern new];
	[promotionQuery prepareDic:searchPromotionProductList()];
	for(int i=0;i<[promotionQuery getNumberUnderNode:@"productTypeList" withKey:@"id" withDepth:0];i++){
		[SectionDic setValue:[promotionQuery getValueUnderNode:@"productTypeList" withKey:@"name" withIndex:i withDepth:0] forKey:[promotionQuery getValueUnderNode:@"productTypeList" withKey:@"id" withIndex:i withDepth:0]];
        [sectionArray addObject:[promotionQuery getValueUnderNode:@"productTypeList" withKey:@"name" withIndex:i withDepth:0]];
       // NSLog(@"productTypeList key:%@ name:%@", [promotionQuery getValueUnderNode:@"productTypeList" withKey:@"name" withIndex:i withDepth:0] ,[promotionQuery getValueUnderNode:@"productTypeList" withKey:@"id" withIndex:i withDepth:0]);
    }
    //NSMutableArray *productArray = [[NSMutableArray arrayWithObjects:nil]retain];
    QueryPattern *productlistQuery=[QueryPattern new];
    id node = [promotionQuery getObjectUnderNode:@"productTypeList" withIndex:0];
    if ([node isKindOfClass:[NSArray class]]){
        for (id dic in node) {
            [productlistQuery prepareDicWithDictionary:dic];
            if([productlistQuery getNumberForKey:@"productList"]>0){
                [self loadProductData:productlistQuery];
            }
           // NSLog(@"getNumberForKey %d",[productlistQuery getNumberForKey:@"productList"]);
        }
    }else{
        [productlistQuery prepareDicWithDictionary:node];
        [self loadProductData:productlistQuery];
    }
    [productlistQuery release];

    //NSLog(@"productTypeList count %d",[promotionQuery getNumberUnderNode:@"productTypeList" withKey:@"id" withDepth:0]);
	
    [promotionQuery release];
}
@end
