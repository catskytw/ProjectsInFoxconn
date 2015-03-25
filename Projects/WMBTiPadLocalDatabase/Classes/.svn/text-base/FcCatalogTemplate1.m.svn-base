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
#import "QueryPattern.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "FcTabBarItem.h"
#import "Tools.h"
#import "NinePatch.h"
#import "PopoverContentTemplate1.h"
#import "NSStringSupport.h"
#import "SignInObject.h"
@interface FcCatalogTemplate1 (PrivateMethods)
-(void)loadScrollViewWithPage:(int)page;
-(void)scrollViewDidScroll:(UIScrollView *)sender;
//-(void)loadBrandScrollView:(NSString*)sKey;
-(UIButton*)customBrandButton:(NSString*)brandString;
-(void)loadFilterCondition;
-(void)tuneFilterBtnLayout;
-(void)showCategoryPopover;
-(UIView*)lineView;
-(void)changeSortBtnColor:(NSInteger)index;
@end

@implementation FcCatalogTemplate1
@synthesize compareLabel;
@synthesize contentView,brandScrollView;
@synthesize categoryLabel,titleLabel,filterLabel;
@synthesize categorySearchBtn,sortBtnLeft,sortBtnMiddle,sortBtnRight;
@synthesize titleBackgroundView,brandBackgroundView,middleBackgroundView;
@synthesize filterButton1,filterButton2,filterButton3,resetBtn;
@synthesize pageControl;
@synthesize compareSwitch;
@synthesize compareBackView;
@synthesize sCategoryKey;
#pragma mark Developer Override

//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//multi-language
	[titleLabel setText:AMLocalizedString(@"ProductCatalog",nil)];
	[sortBtnLeft setTitle:AMLocalizedString(@"CatalogLeftSearchBtnString",nil) forState:UIControlStateNormal];
	[sortBtnMiddle setTitle:AMLocalizedString(@"CatalogMiddleSearchBtnString",nil) forState:UIControlStateNormal];
	[sortBtnRight setTitle:AMLocalizedString(@"CatalogRightSearchBtnString",nil) forState:UIControlStateNormal];
	[categorySearchBtn setTitle:AMLocalizedString(@"ProductSearch",nil) forState:UIControlStateNormal];
	//resize
	//theme suit
	[brandBackgroundView setImage:[UIImage imageNamed:@"product_diary_brand_search.png"]];
	[titleBackgroundView setImage:[UIImage imageNamed:@"content_ui_title_bar.png"]];

	CGSize fontSize=[Tools estimateStringSize:AMLocalizedString(@"ProductSearch",nil) withFontSize:13.0 withMaxSize:CGSizeMake(300, 33)];
	CGSize actualSize=CGSizeMake(fontSize.width+20, 33);
	[categorySearchBtn setBackgroundImage:
								 [TUNinePatchCache imageOfSize:actualSize forNinePatchNamed:@"button_normal"]
								 forState:UIControlStateNormal];
	[categorySearchBtn setBackgroundImage:
	 [TUNinePatchCache imageOfSize:actualSize forNinePatchNamed:@"button_active"]
								 forState:UIControlStateHighlighted];
	[categorySearchBtn setFrame:CGRectMake(768-10-actualSize.width, categorySearchBtn.frame.origin.y, actualSize.width, actualSize.height)];
	//[categorySearchBtn setBackgroundImage:[UIImage imageNamed:@"product_diary_set_search.png"] forState:UIControlStateNormal];
	//[categorySearchBtn setBackgroundImage:[UIImage imageNamed:@"product_diary_set_search_i.png"] forState:UIControlStateHighlighted];
	
	pageControl.imageNormal=[UIImage imageNamed:@"content_ui_page_off.png"];
	pageControl.imageCurrent=[UIImage imageNamed:@"content_ui_page_on.png"];
    [categoryLabel setText:DefaultSubCatelogString];
    [filterLabel setText:AMLocalizedString(@"filter", nil)];    
    [filterButton1 setTitle:AMLocalizedString(@"filter1", nil) forState:UIControlStateNormal];
    [filterButton2 setTitle:AMLocalizedString(@"filter2", nil) forState:UIControlStateNormal];
    [filterButton3 setTitle:AMLocalizedString(@"filter3", nil) forState:UIControlStateNormal];
    [self tuneFilterBtnLayout];
    
    [comparePanel.view setFrame:CGRectMake(0, 0, 768, 600)];
    [self.compareBackView addSubview:comparePanel.view];
    [self.compareBackView setFrame:CGRectMake(0, 1024, compareBackView.frame.size.width, compareBackView.frame.size.height)];
    
    CGSize leftBtnSize=[Tools estimateStringSize:sortBtnLeft.titleLabel.text withFontSize:17.0f];
    CGSize middleBtnSize=[Tools estimateStringSize:sortBtnMiddle.titleLabel.text withFontSize:17.0f];
    CGSize rightBtnSize=[Tools estimateStringSize:sortBtnRight.titleLabel.text withFontSize:17.0f];
    
    [sortBtnLeft setFrame:CGRectMake(sortBtnLeft.frame.origin.x, sortBtnLeft.frame.origin.y, leftBtnSize.width, leftBtnSize.height)];
    [sortBtnMiddle setFrame:CGRectMake(sortBtnLeft.frame.origin.x+leftBtnSize.width+21,sortBtnMiddle.frame.origin.y, middleBtnSize.width,middleBtnSize.height)];
    [sortBtnRight setFrame:CGRectMake(sortBtnMiddle.frame.origin.x+middleBtnSize.width+21, sortBtnRight.frame.origin.y, rightBtnSize.width, rightBtnSize.height)];
    
    compareLabel.text =AMLocalizedString(@"Catelog_Compare", nil);
    //貼兩條線
    UIView *firstLine=[self lineView];
    [firstLine setFrame:CGRectMake(sortBtnMiddle.frame.origin.x-11, sortBtnMiddle.frame.origin.y, 1, 20)];
    [self.view addSubview:firstLine];
    
    firstLine=[self lineView];
    [firstLine setFrame:CGRectMake(sortBtnRight.frame.origin.x-11, sortBtnMiddle.frame.origin.y, 1, 20)];
    [self.view addSubview:firstLine];
    
    [self changeSortBtnColor:0];
}

-(void)tuneFilterBtnLayout{
    //set filterButton nine-patch
    CGSize maxSize=CGSizeMake(300, 37);
    CGSize filter1Size=[Tools estimateStringSize:filterButton1.titleLabel.text withFontSize:17.0f withMaxSize:maxSize];
    CGSize filter2Size=[Tools estimateStringSize:filterButton2.titleLabel.text withFontSize:17.0f withMaxSize:maxSize];
    CGSize filter3Size=[Tools estimateStringSize:filterButton3.titleLabel.text withFontSize:17.0f withMaxSize:maxSize];

    NSInteger filterSpace=20;
    [filterButton1 setBackgroundImage:
     [TUNinePatchCache imageOfSize:CGSizeMake(filter1Size.width+filterSpace, 37) forNinePatchNamed:@"dropmenu_left"] forState:UIControlStateNormal];
	[filterButton1 setBackgroundImage:
	 [TUNinePatchCache imageOfSize:CGSizeMake(filter1Size.width+filterSpace, 37) forNinePatchNamed:@"dropmenu_left"]forState:UIControlStateHighlighted];
    [filterButton2 setBackgroundImage:
     [TUNinePatchCache imageOfSize:CGSizeMake(filter2Size.width+filterSpace, 37) forNinePatchNamed:@"dropmenu_mid"] forState:UIControlStateNormal];
	[filterButton2 setBackgroundImage:
	 [TUNinePatchCache imageOfSize:CGSizeMake(filter2Size.width+filterSpace, 37) forNinePatchNamed:@"dropmenu_mid"]forState:UIControlStateHighlighted];
    [filterButton3 setBackgroundImage:
     [TUNinePatchCache imageOfSize:CGSizeMake(filter3Size.width+filterSpace, 37) forNinePatchNamed:@"dropmenu_right"] forState:UIControlStateNormal];
	[filterButton3 setBackgroundImage:
	 [TUNinePatchCache imageOfSize:CGSizeMake(filter3Size.width+filterSpace, 37) forNinePatchNamed:@"dropmenu_right"]forState:UIControlStateHighlighted];
    //最末端x position是680
    //要往前推算
    [filterButton3 setFrame:CGRectMake(680-(filter3Size.width+filterSpace), filterButton1.frame.origin.y, filter3Size.width+filterSpace, 37)];
    [filterButton2 setFrame:CGRectMake(filterButton3.frame.origin.x-(filter2Size.width+filterSpace), filterButton1.frame.origin.y, filter2Size.width+filterSpace, 37)];
    [filterButton1 setFrame:CGRectMake(filterButton2.frame.origin.x-(filter1Size.width+filterSpace), filterButton1.frame.origin.y, filter1Size.width+filterSpace, 37)];
    [filterLabel setFrame:CGRectMake(filterButton1.frame.origin.x-(filterLabel.frame.size.width+filterSpace), filterLabel.frame.origin.y, filterLabel.frame.size.width, filterLabel.frame.size.height)];
    //[resetBtn setFrame:CGRectMake(filterButton3.frame.origin.x+filterButton3.frame.size.width+filterSpace, resetBtn.frame.origin.y, resetBtn.frame.size.width, resetBtn.frame.size.height)];
}
-(void)shiftViewPosition:(NSNotification*)notification{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75f];
    [UIView setAnimationDelegate:self];
    if(isCompareFullShow){
        [self.compareBackView setFrame:CGRectMake(0, 355, compareBackView.frame.size.width, compareBackView.frame.size.height)];
    }else{
        [self.compareBackView setFrame:CGRectMake(0, 747, compareBackView.frame.size.width, compareBackView.frame.size.height)];
    }
    [UIView commitAnimations];
    isCompareFullShow=!isCompareFullShow;
}
-(void)dismissPopoverAction:(NSNotification*)notification{
    if(sCategoryKey!=nil)
        [_categoryPopover dismissPopoverAnimated:YES];
}
// use notification to reload data
-(void)reloadProductData:(NSNotification*)notification{
	NSDictionary *dataDic=(NSDictionary*)notification.userInfo;
	NSString *sKey=(NSString*)[dataDic valueForKey:@"subCategoryKey"];
    sCategoryKey=sKey;
	NSString *mainName=(NSString*)[dataDic valueForKey:@"mainName"];
	NSString *subName=(NSString*)[dataDic valueForKey:@"subName"];
	
	[queryAttributeDic setValue:sKey forKey:@"productTypeId"];
	[queryAttributeDic setValue:[NSNull null] forKey:@"productBrandId"];
    [queryAttributeDic setValue:[NSNull null] forKey:@"productColorId"];
    [queryAttributeDic setValue:[NSNull null] forKey:@"productPriceId"];
	[queryAttributeDic setValue:DefaultSortType forKey:@"sortType"];
	[categoryLabel setText:[NSString stringWithFormat:@"%@ > %@",mainName,subName]];
    [self loadFilterCondition];
	[self loadProductData];
	//[self loadBrandScrollView:sKey];
}

//用sub-category key來讀取product list
-(void)loadProductData{
	NSString *sKey=(NSString*)[queryAttributeDic valueForKey:@"productTypeId"];
	NSString *typeString=[NSString stringWithFormat:@"%d",[[queryAttributeDic valueForKey:@"sortType"]intValue]];
	NSString *brandId=(NSString*)[queryAttributeDic valueForKey:@"productBrandId"];
    NSString *colorId=(NSString*)[queryAttributeDic valueForKey:@"productColorId"];
    NSString *priceId=(NSString*)[queryAttributeDic valueForKey:@"productPriceId"];
	[queryPattern prepareDic:searchProductList(sKey,typeString,brandId,colorId,priceId)];
    
	//共有幾筆data
	numOfDataEntry=[queryPattern getNumberForKey:@"id"];
#ifdef TEST_MODE
	numOfDataEntry=35;
#endif
	pageNumber=ceil((CGFloat)numOfDataEntry/productNumInPage);	//共有幾頁
    
	[pageViews removeAllObjects];
	for(int i=0;i<pageNumber;i++){
		[pageViews addObject:[NSNull null]];
	}
	//pageControl.currentPage=0;
	pageControl.numberOfPages=pageNumber;
	for(UIView *subViewInScrollView in contentView.subviews){
		[subViewInScrollView removeFromSuperview];
	}
    contentView.contentSize = CGSizeMake(contentView.frame.size.width * pageNumber, contentView.frame.size.height);
    [self changePage:nil];
    [pageControl updateCurrentPageDisplay];
}

//讀取過濾條件
-(void)loadFilterCondition{
    //清掉過濾條件之資料
    [brandDic removeAllObjects];
    [colorDic removeAllObjects];
    [priceDic removeAllObjects];
    
    [filterButton1 setTitle:AMLocalizedString(@"filter1", nil) forState:UIControlStateNormal];
    [filterButton2 setTitle:AMLocalizedString(@"filter2", nil) forState:UIControlStateNormal];
    [filterButton3 setTitle:AMLocalizedString(@"filter3", nil) forState:UIControlStateNormal];

    NSString *sKey=[queryAttributeDic valueForKey:@"productTypeId"];
    QueryPattern *filterQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    //抓brand filter
    [filterQuery prepareDic:searchBrandFilter(sKey)];
    NSInteger totalNumber=[filterQuery getNumberUnderNode:@"productBrandList" withKey:@"id"];
    for(int i=0;i<totalNumber;i++){
        NSString *key=[filterQuery getValueUnderNode:@"productBrandList"  withKey:@"id" withIndex:i];
        NSString *value=[filterQuery getValueUnderNode:@"productBrandList"  withKey:@"name" withIndex:i];
        [brandDic setValue:value forKey:key];
    }
    //抓color filter
    [filterQuery prepareDic:searchColorFilter(sKey)];
    totalNumber=[filterQuery getNumberUnderNode:@"productColorList" withKey:@"color"];
    for(int i=0;i<totalNumber;i++){
        NSString *key=[filterQuery getValueUnderNode:@"productColorList"  withKey:@"color" withIndex:i];
        NSString *value=[filterQuery getValueUnderNode:@"productColorList"  withKey:@"color" withIndex:i];
        [colorDic setValue:value forKey:key];
    }

    //抓price filter
    [filterQuery prepareDic:searchPriceFilter(sKey)];
    totalNumber=[filterQuery getNumberUnderNode:@"productPriceList" withKey:@"price"];
    for(int i=0;i<totalNumber;i++){
        NSString *key=[filterQuery getValueUnderNode:@"productPriceList"  withKey:@"price" withIndex:i];
        NSString *value=[filterQuery getValueUnderNode:@"productPriceList"  withKey:@"price" withIndex:i];
        [priceDic setValue:value forKey:key];
    }

    //設定為原來字樣
    [filterButton1 setTitle:AMLocalizedString(@"filter1", nil) forState:UIControlStateNormal];
    [filterButton2 setTitle:AMLocalizedString(@"filter2", nil) forState:UIControlStateNormal];
    [filterButton3 setTitle:AMLocalizedString(@"filter3", nil) forState:UIControlStateNormal];
    
    [self tuneFilterBtnLayout];
    [filterQuery release];
}
//SearchBtn action
-(IBAction)searchAction:(id)sender{
    [self showCategoryPopover];
}
-(void)showCategoryPopover{
    CGRect targetRect=categorySearchBtn.frame;
    if (_categoryPopover==nil) {
        FcCategorySelectionView1 *selection=[FcCategorySelectionView1 new];
        _categoryPopover= [[UIPopoverController alloc]initWithContentViewController:selection];
        //各種不同popover之版面大小
        _categoryPopover.popoverContentSize=CGSizeMake(382, 281);
        _categoryPopover.contentViewController=selection;
        [_categoryPopover presentPopoverFromRect:targetRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else if([_categoryPopover isPopoverVisible]==NO)
        [_categoryPopover presentPopoverFromRect:targetRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
//buttons in Brand-scrollview action
/*
-(IBAction)brandAction:(id)sender{
	UIButton *btn=(UIButton*)sender;
	NSString *brandId=(NSString*)[brandDic valueForKey:btn.titleLabel.text];
	[queryAttributeDic setValue:brandId forKey:@"productBrandId"];
	[self loadProductData];
}
*/
//Left button action
-(IBAction)leftBtnAction:(id)sender{
    [self changeSortBtnColor:0];
	[queryAttributeDic setValue:@"3" forKey:@"sortType"];
	[self loadProductData];
}

//Middle button action
-(IBAction)middleBtnAction:(id)sender{
    [self changeSortBtnColor:1];
	[queryAttributeDic setValue:@"2" forKey:@"sortType"];
	[self loadProductData];
}

//right button action
-(IBAction)rightBtnAction:(id)sender{
    [self changeSortBtnColor:2];
	[queryAttributeDic setValue:@"1" forKey:@"sortType"];
	[self loadProductData];
}
#pragma mark -

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LASTVIEWPAGETYPE=TabBarIndex_ProductList;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    comparePanel=nil;
    _categoryPopover=nil;
    isCompareFullShow=YES;
	/*
	 IMPORTANT!! For Foxconn developers:
	 We suppose your products' data are ready and envelop them into allProductData.
	 */
	productNumInPage=20;
    brandDic=[NSMutableDictionary new];
    colorDic=[NSMutableDictionary new];
    priceDic=[NSMutableDictionary new];
    
    comparePanel=[[CompareView alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:comparePanel selector:@selector(addCompareProduct:) name:AddProductCompare object:nil];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadProductData:) name:CatalogTemplateNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissPopoverAction:) name:dismissPopover object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shiftViewPosition:) name:ShiftComparePanel object:nil];
	queryPattern=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
	pageViews=[[NSMutableArray alloc]init];
	queryAttributeDic=[[NSMutableDictionary dictionary]retain];
	
	[queryAttributeDic setValue:sCategoryKey forKey:@"productTypeId"];
	[queryAttributeDic setValue:[NSNull null] forKey:@"productBrandId"];
    [queryAttributeDic setValue:[NSNull null] forKey:@"productColorId"];
    [queryAttributeDic setValue:[NSNull null] forKey:@"productPriceId"];
	[queryAttributeDic setValue:DefaultSortType forKey:@"sortType"];

	[self EnvelopSuit];
	[self loadProductData];
    [self loadFilterCondition];
	//[self loadBrandScrollView:DefaultSubCatalogKey];
	// The product's scrollView setting.
    contentView.pagingEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.scrollsToTop = NO;
    contentView.delegate = self;
}
//loading brand button
/*
-(void)loadBrandScrollView:(NSString*)sKey{
	if(brandDic==nil)
		brandDic=[[NSMutableDictionary dictionary]retain];
	else {
		[brandDic removeAllObjects];
	}

	QueryPattern *brandQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    //TODO load brandFilter
	//[brandQuery prepareDic:searchProductList(sKey,@"1")];
#ifdef TEST_MODE
	NSLog(@"brand count:%i",[brandQuery getNumberForKey:@"id"]);
#endif
	brandXPosition=0;
	for(UIView *subView in brandScrollView.subviews)
		[subView removeFromSuperview];
	for(int i=0;i<[brandQuery getNumberForKey:@"id"];i++){
		[brandDic setValue:[brandQuery getValue:@"id" withIndex:i] forKey:[brandQuery getValue:@"name" withIndex:i]];
		UIButton *thisBtn=[self customBrandButton:[brandQuery getValue:@"name" withIndex:i]];
		[thisBtn addTarget:self action:@selector(brandAction:) forControlEvents:UIControlEventTouchUpInside];
		[brandScrollView addSubview:thisBtn];
	}
	[brandScrollView setContentSize:CGSizeMake(brandXPosition+20, 45)];
	[brandQuery release];
}
 */

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
		int numInThisPage=((numOfDataEntry-startNumber)>productNumInPage)?productNumInPage:(numOfDataEntry-startNumber);
        controller = [[FcProductListView1 alloc]initWithProductNumber:numInThisPage withStartIndex:startNumber isCompareMode:compareSwitch.on  withDataSource:queryPattern];
        [pageViews replaceObjectAtIndex:page withObject:controller];
        [controller autorelease];
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


- (void)viewDidUnload {
	//解除notification註冊 dismissPopover
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CatalogTemplateNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:dismissPopover object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:ShiftComparePanel object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AddProductCompare object:nil];
	[pageViews removeAllObjects];
	[pageViews release];
    if(comparePanel!=nil){
        [comparePanel release];
        comparePanel=nil;
    }
	if(brandDic!=nil){
		[brandDic removeAllObjects];
		[brandDic release];
	}
	[queryAttributeDic release];
	[queryPattern release];
    [comparePanel release];

    [super viewDidUnload];
}

- (void)dealloc {

    [super dealloc];
}

-(void)showPopoverView:(PopoverContentTemplate1*)sourcePopoverContent withRect:(CGRect)targetRect withPopoverType:(NSInteger)type{
    CGSize contentSize;
    switch (type) {
        case 1:
            contentSize=CGSizeMake(180, 160);
            break;
        case 2:
            contentSize=CGSizeMake(200, 160);
            break;
        default:
            contentSize=CGSizeMake(100, 160);
            break;
    }
    if(_filterPopover==nil){
        //TODO release it
        _filterPopover=[[UIPopoverController alloc]initWithContentViewController:sourcePopoverContent];
    }
    _filterPopover.popoverContentSize=contentSize;
    _filterPopover.contentViewController=sourcePopoverContent;
    [_filterPopover presentPopoverFromRect:targetRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
-(IBAction)brandAction:(id)sender{
    //TODO create the dataArray
    UIButton *thisBtn=(UIButton*)sender;
    NSMutableArray *brandDatas=[NSMutableArray arrayWithArray:[brandDic allValues]];
    PopoverContentTemplate1 *thisContent=[[PopoverContentTemplate1 alloc]initWithDataArray:brandDatas];
    thisContent.filterEnum=1;
    thisContent.delegate=self;
    [self showPopoverView:thisContent withRect:((UIButton*)sender).frame  withPopoverType:thisBtn.tag];
    [thisContent autorelease];
}
-(IBAction)priceAction:(id)sender{
    UIButton *thisBtn=(UIButton*)sender;
    NSMutableArray *sortValues=[NSMutableArray arrayWithArray: [[priceDic allValues] sortedArrayUsingSelector:@selector(psuedoNumericCompare:)]];
    PopoverContentTemplate1 *thisContent=[[PopoverContentTemplate1 alloc]initWithDataArray:sortValues];
    thisContent.filterEnum=2;
    thisContent.delegate=self;
    [self showPopoverView:thisContent withRect:((UIButton*)sender).frame  withPopoverType:thisBtn.tag];
    [thisContent autorelease];
}
-(IBAction)colorAction:(id)sender{
    UIButton *thisBtn=(UIButton*)sender;
    NSMutableArray *colorDatas=[NSMutableArray arrayWithArray:[colorDic allValues]];
    PopoverContentTemplate1 *thisContent=[[PopoverContentTemplate1 alloc]initWithDataArray:colorDatas];
    thisContent.delegate=self;
    thisContent.filterEnum=3;
    [self showPopoverView:thisContent withRect:((UIButton*)sender).frame withPopoverType:thisBtn.tag];
    [thisContent autorelease];
}

-(void)priceSelected:(NSString*)price{
    NSArray *keyArray=[priceDic allKeys];
    for(int i=0;i<[keyArray count];i++){
        NSString *value=(NSString*)[priceDic valueForKey:(NSString*)[keyArray objectAtIndex:i]];
        if([value isEqualToString:price]){
            NSString *trimString=(NSString*)[keyArray objectAtIndex:i];
            trimString=[trimString stringByReplacingOccurrencesOfString:@" " withString:@""];
            [queryAttributeDic setValue:trimString forKey:@"productPriceId"];
            [filterButton2 setTitle:value forState:UIControlStateNormal];
            break;
        }
    }
    [self tuneFilterBtnLayout];
    [_filterPopover dismissPopoverAnimated:YES];
    [self loadProductData];
}
-(void)colorSelected:(NSString*)color{
    NSArray *keyArray=[colorDic allKeys];
    for(int i=0;i<[keyArray count];i++){
        NSString *value=(NSString*)[colorDic valueForKey:(NSString*)[keyArray objectAtIndex:i]];
        if([value isEqualToString:color]){
            NSString *encodingStirng=[Tools urlEncoding:(NSString*)[keyArray objectAtIndex:i]];
            NSLog(@"color String:%@",encodingStirng);
            [queryAttributeDic setValue:encodingStirng forKey:@"productColorId"];
            [filterButton3 setTitle:value forState:UIControlStateNormal];
            break;
        }
    }
    [self tuneFilterBtnLayout];
    [_filterPopover dismissPopoverAnimated:YES];
    [self loadProductData];
}
-(void)brandSelected:(NSString*)brand{
    NSArray *keyArray=[brandDic allKeys];
    for(int i=0;i<[keyArray count];i++){
        NSString *value=(NSString*)[brandDic valueForKey:(NSString*)[keyArray objectAtIndex:i]];
        if([value isEqualToString:brand]){
            [queryAttributeDic setValue:(NSString*)[keyArray objectAtIndex:i] forKey:@"productBrandId"];
            [filterButton1 setTitle:value forState:UIControlStateNormal];
            break;
        }
    }
    [self tuneFilterBtnLayout];
    [_filterPopover dismissPopoverAnimated:YES];
    [self loadProductData];
}

-(IBAction)resetAction:(id)sender{
    [filterButton1 setTitle:AMLocalizedString(@"filter1", nil) forState:UIControlStateNormal];
    [filterButton2 setTitle:AMLocalizedString(@"filter2", nil) forState:UIControlStateNormal];
    [filterButton3 setTitle:AMLocalizedString(@"filter3", nil) forState:UIControlStateNormal];
    [self tuneFilterBtnLayout];
    
    [queryAttributeDic setValue:[NSNull null] forKey:@"productBrandId"];
    [queryAttributeDic setValue:[NSNull null] forKey:@"productPriceId"];
    [queryAttributeDic setValue:[NSNull null] forKey:@"productColorId"];
    [self loadProductData];
}

-(IBAction)switchValueChanged{	
    if(compareSwitch.on==YES){
        //compare mode
        productNumInPage=15;
        [self loadProductData];
        [self.compareBackView setFrame:CGRectMake(0, 747, compareBackView.frame.size.width, compareBackView.frame.size.height)];
    }else{
        //normal mode
        productNumInPage=20;
        [self loadProductData];
        [self.compareBackView setFrame:CGRectMake(0, 1024, compareBackView.frame.size.width, compareBackView.frame.size.height)];
    }
}

-(UIView*)lineView{
    UIView *_rView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 10)];
    [_rView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    return [_rView autorelease];
}

-(void)changeSortBtnColor:(NSInteger)index{
    UIColor *defaultColor=[UIColor colorWithRed:(CGFloat)87/256 green:(CGFloat)87/256 blue:(CGFloat)87/256 alpha:1];
    UIColor *orangeColor=DefaultOrangeColor;
    switch (index) {
        case 0:
            [sortBtnLeft setTitleColor:orangeColor forState:UIControlStateNormal];
            [sortBtnMiddle setTitleColor:defaultColor forState:UIControlStateNormal];
            [sortBtnRight setTitleColor:defaultColor forState:UIControlStateNormal];
            break;
        case 1:
            [sortBtnLeft setTitleColor:defaultColor forState:UIControlStateNormal];
            [sortBtnMiddle setTitleColor:orangeColor forState:UIControlStateNormal];
            [sortBtnRight setTitleColor:defaultColor forState:UIControlStateNormal];
            break;
        case 2:
            [sortBtnLeft setTitleColor:defaultColor forState:UIControlStateNormal];
            [sortBtnMiddle setTitleColor:defaultColor forState:UIControlStateNormal];
            [sortBtnRight setTitleColor:orangeColor forState:UIControlStateNormal];
            break;
    }
}
@end
int LASTVIEWPAGETYPE;