//
//  PromotionController.m
//  WMBT
//
//  Created by link on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PromotionController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "ProductInfoController.h"
#import "MainMenuViewController.h"
#import "PromotEventListTableCell.h"
#import "PromoteEventCellDataObject.h"
#import "PromotionEventInfoController.h"
#import "LoginDataObject.h"
#import "CustomTintExtension.h"
#import "Tools.h"
#import "DownloadImg.h"
@implementation PromotionController
@synthesize SegmentBackGroundView;
@synthesize prmotionTableView;
@synthesize promotionSegment,mainController,imageDownloadsInProgress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        productListArray = [[NSMutableArray arrayWithObjects:nil]retain];	
		SectionDic = [[NSMutableDictionary dictionaryWithObjects:nil forKeys:nil]retain];
        eventArray = [[NSMutableArray arrayWithObjects:nil]retain];
        self.navigationItem.title = AMLocalizedString(@"MainMenu_Promote",nil);
        self.navigationItem.backBarButtonItem.title = AMLocalizedString(@"title_backhome",nil);
        productCellHeight = 65;
        eventCellHeight = 63 ;
        imageDownloadsInProgress = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [prmotionTableView release];
    [promotionSegment release];
    if(productListArray!=nil)
		[productListArray release];
    if(SectionDic!=nil)
		[SectionDic release];
    if (sectionArray != nil) {
        [sectionArray release];
    }
    if (eventArray != nil) {
        [eventArray release];
    }
    if (imageDownloadsInProgress!=nil) {
        [imageDownloadsInProgress release];
    }
    [SegmentBackGroundView release];
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
    [self setUIDefault];
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPrmotionTableView:nil];
    [self setPromotionSegment:nil];
    [self setSegmentBackGroundView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([Tools isPopToRoot])
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [Tools setPopToRoot:NO];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) setUIDefault{
    //self.title = AMLocalizedString(@"account_title", nil);
    self.navigationItem.title = AMLocalizedString(@"promotion_Title", nil);
    [promotionSegment setTitle:AMLocalizedString(@"promotion_Event",nil) forSegmentAtIndex:1];
    [promotionSegment setTitle:AMLocalizedString(@"promotion_ranking",nil) forSegmentAtIndex:0];
    [SegmentBackGroundView setBackgroundColor:[UIColor colorWithRed:175/255.0f green:186/255.0f blue:194/255.0f alpha:1]];
    [promotionSegment setTag:1 forSegmentAtIndex:0];
    [promotionSegment setTag:2 forSegmentAtIndex:1];
    
    [promotionSegment setTintColor: [UIColor colorWithRed:129/255.f green:141/255.f blue:163/255.f alpha:1] forTag:1];
    [promotionSegment setTintColor: [UIColor colorWithRed:192/255.f green:199/255.f blue:205/255.f alpha:1] forTag:2];
    //[promotionSegment setTextColor: [UIColor colorWithRed:69/255.f green:103/255.f blue:126/255.f alpha:1] forTag:2];
    
}
- (IBAction)promotionSegmentChange:(id)sender {
    
    if ([(UISegmentedControl*)sender selectedSegmentIndex]==1) {
        if ([eventArray count]==0) {
            [self loadEventData];
        }
        [promotionSegment setTintColor: [UIColor colorWithRed:129/255.f green:141/255.f blue:163/255.f alpha:1] forTag:2];
        [promotionSegment setTintColor: [UIColor colorWithRed:192/255.f green:199/255.f blue:205/255.f alpha:1] forTag:1];
        //[promotionSegment setTextColor: [UIColor colorWithRed:69/255.f green:103/255.f blue:126/255.f alpha:1] forTag:1];
    }else
    {
        if ([productListArray count]==0) {
            [self loadProductData];
        }
        [promotionSegment setTintColor: [UIColor colorWithRed:129/255.f green:141/255.f blue:163/255.f alpha:1] forTag:1];
        [promotionSegment setTintColor: [UIColor colorWithRed:192/255.f green:199/255.f blue:205/255.f alpha:1] forTag:2];
        //[promotionSegment setTextColor: [UIColor colorWithRed:69/255.f green:103/255.f blue:126/255.f alpha:1] forTag:2];
    }
    
    [prmotionTableView reloadData];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	if ([promotionSegment selectedSegmentIndex]==1) {
        return [eventArray count];
    }else{
        return [productListArray count];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([promotionSegment selectedSegmentIndex]==1) {
        return [self getEventCell:tableView andIndexPath:indexPath];
    }else{
        return [self getFcProductListViewCell:tableView andIndexPath:indexPath];
    }
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([promotionSegment selectedSegmentIndex]==1) {
        PromotionEventInfoController *eventInfoController = [[PromotionEventInfoController alloc] initWithNibName:@"PromotionEventInfoController" bundle:nil];
         
        PromoteEventCellDataObject *cellDo = (PromoteEventCellDataObject*)[eventArray objectAtIndex:indexPath.row];
        eventInfoController.eventId = cellDo.eventId;
        [eventInfoController loadData];
        [((MainMenuViewController*)mainController).mainNavigation pushViewController:eventInfoController animated:YES];
        [eventInfoController release];
        
    }else{
        ProductInfoController *productInfoController = [[ProductInfoController alloc] initWithNibName:@"ProductInfoController" bundle:nil];
        ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray objectAtIndex:indexPath.row];
        productInfoController.mainController = mainController;
        productInfoController.sID = cellDO.productId;
    //NSLog(@"didSelectRowAtIndexPath section:%d row:%d name:%@",indexPath.section,indexPath.row, cellDO.productName);
        [((MainMenuViewController*)mainController).mainNavigation pushViewController:productInfoController animated:YES];
        [productInfoController release];
    }
}

-(void) setCellInfo:(FcProductTableCell*)cell andIndexPath:(NSIndexPath *)indexPath{
    
	ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray objectAtIndex:indexPath.row];
    // NSLog(@"setCellInfo section:%d row:%d name:%@", indexPath.section, indexPath.row, cellDO.productName);
	[cell setInfoDO:cellDO andController:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	if ([promotionSegment selectedSegmentIndex]==1) {
        return eventCellHeight;
    }else{
        [self getFcProductListViewCell:tableView andIndexPath:indexPath];
        return productCellHeight;
    }
}
-(UITableViewCell *)getFcProductListViewCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
	FcProductTableCell *cell = (FcProductTableCell*)[tableView dequeueReusableCellWithIdentifier:@"FcProductTableCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FcProductListTableCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
    productCellHeight = cell.frame.size.height;
    [cell.imgProduct setImage:[UIImage imageNamed:@"no_photo46.png"]];
    [self setCellInfo:cell andIndexPath:indexPath];
    if (indexPath.row <3) {
        [cell showNo1:indexPath.row+1];
    }
    ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray objectAtIndex:indexPath.row];
    tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (!imgDowmloader.bLoaded)
    {
        if (prmotionTableView.dragging == NO && prmotionTableView.decelerating == NO)
        {
            [self startImgDownload:cellDO.dlImg forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        [cell.imgProduct setImage:[UIImage imageNamed:@"no_photo46.png"]];                
    }
    else
    {
        cell.imgProduct.image = cellDO.dlImg.img;
    }
    //NSLog(@"getFcProductListViewCell section:%d row:%d name:%@", indexPath.section, indexPath.row, cell.lblName.text);
	return cell;
}
-(UITableViewCell *)getEventCell:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    PromotEventListTableCell *cell = (PromotEventListTableCell*)[tableView dequeueReusableCellWithIdentifier:@"PromotEventListTableCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PromotEventListTableCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
	}
    eventCellHeight = cell.frame.size.height;
    PromoteEventCellDataObject *cellDO = (PromoteEventCellDataObject*)[eventArray objectAtIndex:indexPath.row];
    [cell setInfoDO:cellDO];
    return cell;

}
-(void)loadEventData{
    
    QueryPattern *eventQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[eventQuery prepareDic:searchPromoteList()];
    @try {
        for(int i=0;i<[eventQuery getNumberUnderNode:@"promotionEventList" withKey:@"id" ];i++) {
            PromoteEventCellDataObject *cellDO = [PromoteEventCellDataObject new];
            cellDO.title=[eventQuery getValue:@"title" withIndex:i];
            cellDO.content=[eventQuery getValue:@"content" withIndex:i];
            cellDO.duration =[eventQuery getValue:@"eventDate" withIndex:i];
            cellDO.eventId =[eventQuery getValue:@"id" withIndex:i];
            [eventArray addObject:cellDO];
            [cellDO release];
        }

    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
         [eventQuery release];
    }
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
        cellDO.dlImg.imgURLString = picUrl(cellDO.imgUrl);
		[productArray addObject:cellDO];
        //NSLog(@"%d productData id:%@ name:%@",i,cellDO.productId, cellDO.productName);
		[cellDO release];
	}
	[productListArray addObject:productArray];
	[productArray release];
}
-(void)loadProductData{
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
	QueryPattern *promotionQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[promotionQuery prepareDic:searchPromotionProductList(((LoginDataObject*)[LoginDataObject sharedInstance]).sessionId)];
    @try {
        if([Tools checkQureyResponse:[promotionQuery getValue:@"response" withIndex:0]])
        {
            if ([promotionQuery getNumberUnderNode:@"productList" withKey:@"id" withDepth:0]>0) {
                
                for(int i=0;i<[promotionQuery getNumberUnderNode:@"productList" withKey:@"id" ];i++){
                    ProductListCellDataObject *cellDO = [ProductListCellDataObject new];
                    cellDO.productId=[promotionQuery getValueUnderNode:@"productList" withKey:@"id" withIndex:i];
                    cellDO.productName=[promotionQuery getValueUnderNode:@"productList" withKey:@"name" withIndex:i];
                    cellDO.brand = [promotionQuery getValueUnderNode:@"productList" withKey:@"brand" withIndex:i];
                    cellDO.price = [promotionQuery getValueUnderNode:@"productList" withKey:@"retailPrice" withIndex:i];
                    cellDO.imgUrl = [promotionQuery getValueUnderNode:@"productList" withKey:@"image46" withIndex:i];
                    cellDO.score = [promotionQuery getValueUnderNode:@"productList" withKey:@"score" withIndex:i];
                    cellDO.dlImg.imgURLString = picUrl(cellDO.imgUrl);
                    [productListArray addObject:cellDO];
                    
                    [cellDO release];
                }
            }
        }
    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [promotionQuery release];
    }
    	
    
}
#pragma mark -
#pragma mark Table cell image support

- (void)startImgDownload:(DownloadImg *)downlaodImg forIndexPath:(NSIndexPath *)indexPath
{
    tableViewImageDownload *imgDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (imgDownloader == nil) 
    {
        imgDownloader = [[tableViewImageDownload alloc] init];
        imgDownloader.downloadImg = downlaodImg;
        imgDownloader.indexPathInTableView = indexPath;
        imgDownloader.delegate = self;
        [imageDownloadsInProgress setObject:imgDownloader forKey:indexPath];
        [imgDownloader startDownload];
        [imgDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([productListArray count] > 0 && [promotionSegment selectedSegmentIndex]==0)
    {
        NSArray *visiblePaths = [prmotionTableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray objectAtIndex:indexPath.row];
            
            if (!cellDO.dlImg.img) // avoid the app icon download if the app already has an icon
            {
                [self startImgDownload:cellDO.dlImg forIndexPath:indexPath];
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)imageDidLoad:(NSIndexPath *)indexPath
{
    tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (imgDowmloader != nil)
    {
        FcProductTableCell *cell = (FcProductTableCell*) [prmotionTableView cellForRowAtIndexPath:imgDowmloader.indexPathInTableView];
        
        // Display the newly loaded image
        cell.imgProduct.image = imgDowmloader.downloadImg.img;
        //cell.bLoaded = YES;
    }
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


@end
