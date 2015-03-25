//
//  CatalogTemplate.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/20.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcCatalogTemplate1.h"
#import "FcProductListView1.h"
#import "FcCategorySelectionView1.h"
@interface FcCatalogTemplate1 (PrivateMethods)
-(void)loadScrollViewWithPage:(int)page;
-(void)scrollViewDidScroll:(UIScrollView *)sender;
-(void)loadBrandScrollView:(NSString*)sKey;
@end

@implementation FcCatalogTemplate1
@synthesize contentView,brandScrollView;
@synthesize categoryLabel,titleLabel;
@synthesize categorySearchBtn,sortBtnLeft,sortBtnMiddle,sortBtnRight;
@synthesize titleBackgroundView,brandBackgroundView,middleBackgroundView;


#pragma mark Developer Override

//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//multi-language
	[titleLabel setText:AMLocalizedString(<#填入此處字串#>,nil)];
	[sortBtnLeft setTitle:AMLocalizedString(<#填入此處字串#>,nil) forState:UIControlStateNormal];
	[sortBtnMiddle setTitle:AMLocalizedString(<#填入此處字串#>,nil) forState:UIControlStateNormal];
	[sortBtnRight setTitle:AMLocalizedString(<#填入此處字串#>,nil) forState:UIControlStateNormal];
	[categorySearchBtn setTitle:AMLocalizedString(<#填入此處字串#>,nil) forState:UIControlStateNormal];
	//resize
	//theme suit
	[brandBackgroundView setImage:[UIImage imageNamed:<#填入圖片名稱#>]];
	[titleBackgroundView setImage:[UIImage imageNamed:<#填入圖片名稱#>]];
	[middleBackgroundView setImage:[UIImage imageNamed:<#填入圖片名稱#>]];
	[sortBtnLeft setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[sortBtnMiddle setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[sortBtnRight setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[sortBtnLeft setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];
	[sortBtnMiddle setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];
	[sortBtnRight setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];
	[categorySearchBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateNormal];
	[categorySearchBtn setBackgroundImage:[UIImage imageNamed:<#填入圖片名稱#>] forState:UIControlStateHighlighted];
	
	pageControl.imageNormal=[UIImage imageNamed:<#填入圖片名稱#>];
	pageControl.imageCurrent=[UIImage imageNamed:<#填入圖片名稱#>];
	
	FcTabBarItem *thisBarItem=self.tarBarItem;
	thisBarItem.customStdImage=[UIImage imageNamed:<#填入圖片名稱#>];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:<#填入圖片名稱#>];
}
// use notification to reload data
-(void)reloadProductData:(NSNotification*)notification{
	NSDictionary *dataDic=(NSDictionary*)notification.userInfo;
	//fill your query parameter from dataDic.
	[self loadProductData];
	[self loadBrandScrollView:sKey];
}

//用sub-category key來讀取product list
-(void)loadProductData{
	//此處填入你讀取資料之程序
	//共有幾筆data
	numOfDataEntry=<#填入數字,代表土共有幾筆資料#>;
#ifdef TEST_MODE
	numOfDataEntry=35;
#endif
	pageNumber=ceil((CGFloat)numOfDataEntry/productNumInPage);	//共有幾頁
	[pageViews removeAllObjects];
	for(int i=0;i<pageNumber;i++){
		[pageViews addObject:[NSNull null]];
	}
	pageControl.currentPage=0;
	pageControl.numberOfPages=pageNumber;
	for(UIView *subViewInScrollView in contentView.subviews){
		[subViewInScrollView removeFromSuperview];
	}
	[self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}
//SearchBtn action
-(IBAction)searchAction:(id)sender{
	FcCategorySelectionView1 *selection=[FcCategorySelectionView1 new];
	[self.view addSubview:selection.view];
}

//buttons in Brand-scrollview action
-(IBAction)brandAction:(id)sender{
	UIButton *btn=(UIButton*)sender;
	//change your query parameter here.
	[self loadProductData];
}

//Left button action
-(IBAction)leftBtnAction:(id)sender{
	UIButton *btn=(UIButton*)sender;
	//change your query parameter here.
	[self loadProductData];
}

//Middle button action
-(IBAction)middleBtnAction:(id)sender{
	UIButton *btn=(UIButton*)sender;
	//change your query parameter here.
	[self loadProductData];
}

//right button action
-(IBAction)rightBtnAction:(id)sender{
	UIButton *btn=(UIButton*)sender;
	//change your query parameter here.
	[self loadProductData];
}
#pragma mark -

#pragma mark LiftCycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	/*
	 IMPORTANT!! For Foxconn developers:
	 We suppose your products' data are ready and envelop them into allProductData.
	 */
	productNumInPage=20;
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadProductData:) name:CatalogTemplateNotification object:nil];
	queryPattern=[QueryPattern new];
	pageViews=[[NSMutableArray alloc]init];
	queryAttributeDic=[[NSMutableDictionary dictionary]retain];
	

	FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:AMLocalizedString(@"ProductCatalog",nil) image:nil tag:0];
	self.tabBarItem=thisBarItem;
	[thisBarItem release];
	[self.tabBarController setSelectedIndex:0];
	
	[self EnvelopSuit];
	[self loadProductData];
	[self loadBrandScrollView:DefaultSubCatalogKey];
	// The product's scrollView setting.
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.frame.size.width * pageNumber, contentView.frame.size.height);
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.scrollsToTop = NO;
    contentView.delegate = self;
}
- (void)viewDidUnload {
	//解除notification註冊
	[[NSNotification description]removeObserver:self forKeyPath:CatalogTemplateNotification];
	[pageViews removeAllObjects];
	[pageViews release];
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -

#pragma mark PrivateMethods
//loading brand button
-(void)loadBrandScrollView:(NSString*)sKey{

}
- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= pageNumber)
        return;
    
    // replace the placeholder if necessary
    FcProductListView1 *controller = [pageViews objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
		int startNumber=productNumInPage*page;
		int numInThisPage=((numOfDataEntry-startNumber)>20)?20:(numOfDataEntry-startNumber);
        controller = [[FcProductListView1 alloc]initWithProductNumber:numInThisPage withStartIndex:startNumber withQueryPattern:queryPattern];
        [pageViews replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = contentView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [contentView addSubview:controller.view];
	}
}
#pragma mark -
#pragma mark DelegateMethod
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = contentView.frame.size.width;
    int page = floor((contentView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = contentView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [contentView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}
#pragma mark -
@end
