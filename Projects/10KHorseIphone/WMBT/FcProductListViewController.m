//
//  FcProductListViewController.m
//  FcProductList
//
//  Created by link on 2011/2/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FcProductListViewController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "ProductListCellDataObject.h"
#import "LocalizationSystem.h"
#import "ProductInfoController.h"
#import "MainMenuViewController.h"
#import "UITuneLayout.h"
#import "LoginDataObject.h"
#import "Tools.h"
#import "DownloadImg.h"
@implementation FcProductListViewController
@synthesize productList,mainSelectedKey,mainSelectedName,mainController,productListArray,imageDownloadsInProgress;//,filterSegment;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        productListArray = [[NSMutableArray arrayWithObjects:nil]retain];
		self.imageDownloadsInProgress = [[NSMutableDictionary alloc]init];	
		stringType =@"1";
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([Tools isPopToRoot])
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [Tools setPopToRoot:NO];
    }
}
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	cellHeight = 0;
	
	[UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
}
-(void)loadProductData:(NSString*)sKey andType:(NSString*)sType andBrand:(NSString*)brandId{
	
    //NSLog(@"loadProductData searchProductList %@",searchProductList(sKey,sType,((LoginDataObject*)[LoginDataObject sharedInstance]).sessionId,brandId));
    
	QueryPattern *mProductQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[mProductQuery prepareDic:searchProductList(sKey,sType,((LoginDataObject*)[LoginDataObject sharedInstance]).sessionId,[NSNull null])];
    @try {
        if([Tools checkQureyResponse:[mProductQuery getValue:@"response" withIndex:0]])
        {
            for(int i=0;i<[mProductQuery getNumberForKey:@"id"];i++){
                ProductListCellDataObject *cellDO = [ProductListCellDataObject new];
                cellDO.productId=[mProductQuery getValue:@"id" withIndex:i];
                cellDO.productName=[mProductQuery getValue:@"name" withIndex:i];
                cellDO.brand = [mProductQuery getValue:@"brand" withIndex:i];
                cellDO.price = [mProductQuery getValue:@"retailPrice" withIndex:i];
                cellDO.imgUrl = [mProductQuery getValue:@"image46" withIndex:i];
                cellDO.score = [mProductQuery getValue:@"score" withIndex:i];
                //DownloadImg *dl = [DownloadImg new];
                cellDO.dlImg.imgURLString = picUrl(cellDO.imgUrl);
                [productListArray addObject:cellDO];
                [cellDO release];
            }
        }
    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
        [mProductQuery release];
    }
    	
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
 
    [super viewDidLoad];
	NSLog(@"viewDidLoad");
	productList.delegate=self;
	productList.dataSource = self;
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    //[filterSegment release];
    //filterSegment = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {

	if(mainSelectedKey!=nil)
		[mainSelectedKey release];
	if(productListArray!=nil)
		[productListArray release];
    if (imageDownloadsInProgress!=nil) {
        [imageDownloadsInProgress release];
    }
    //[filterSegment release];
    [super dealloc];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return [productListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self getFcProductListViewCell:tableView andIndexPath:indexPath];	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	[self getFcProductListViewCell:tableView andIndexPath:indexPath];
	return cellHeight;
}
-(void) setCellInfo:(FcProductTableCell*)cell andIndexPath:(NSIndexPath *)indexPath{

    ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray objectAtIndex:indexPath.row];
	[cell setInfoDO:cellDO andController:self];
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
    [cell.imgProduct setImage:[UIImage imageNamed:@"no_photo46.png"]];
    [self setCellInfo:cell andIndexPath:indexPath];
    // Only load cached images; defer new downloads until scrolling ends
    //tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
    //if (imgDowmloader != nil)
    {
        //FcProductTableCell *cellDl = (FcProductTableCell*) [productList cellForRowAtIndexPath:indexPath];
        ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray objectAtIndex:indexPath.row];
        tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
        if (!imgDowmloader.bLoaded)
        {
            if (productList.dragging == NO && productList.decelerating == NO)
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
    }
	return cell;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return index;
}
//call the next view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//NSLog(@"didSelectRowAtIndexPath indexPath :%d",indexPath.row);
    ProductInfoController *productInfoController = [[ProductInfoController alloc] initWithNibName:@"ProductInfoController" bundle:nil];
    ProductListCellDataObject *cellDO = (ProductListCellDataObject*)[productListArray  objectAtIndex:indexPath.row];
	productInfoController.mainController = mainController;
	productInfoController.sID = cellDO.productId;
	[((MainMenuViewController*)mainController).mainNavigation  pushViewController:productInfoController animated:YES];
    [productInfoController release];

}


-(void) loadBrandData:(NSString*)key andSort:(int)sortKey{
    self.title = mainSelectedName;    
		[self loadProductData:mainSelectedKey andType:stringType andBrand:key];

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
    if ([productListArray count] > 0)
    {
        NSArray *visiblePaths = [productList indexPathsForVisibleRows];
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
        FcProductTableCell *cell = (FcProductTableCell*) [productList cellForRowAtIndexPath:imgDowmloader.indexPathInTableView];
        
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
