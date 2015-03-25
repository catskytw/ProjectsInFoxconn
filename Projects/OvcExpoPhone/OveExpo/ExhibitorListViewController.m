//
//  CompanyListViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorListViewController.h"
#import "ExhibitorListDataObject.h"
#import "ExhibitorListTableViewCell.h"
#import "LoginDataObject.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#define cellHeight 45
@implementation ExhibitorListViewController
@synthesize searchBgImg;
@synthesize tableview;
@synthesize imageDownloadsInProgress;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageDownloadsInProgress = [[NSMutableDictionary alloc]init];
    }
    return self;
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
    [self initDataArray];
    [self setUIDefault];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setSearchBgImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:searchField.textfild]) {
        [searchField setHighlight:YES];
    }
}
-(BOOL) textFieldShouldReturn:(UITextField*)textField
{
    if ([textField isEqual:searchField.textfild]) {
        [searchField setHighlight:NO];
        [self filter];
        
        [tableview reloadData];
    }
    [searchField.textfild resignFirstResponder];
    return NO;
}
-(void)filter{

    [filteredArray removeAllObjects];
    
    for (ExhibitorListDataObject *dao in dataArray) {
        //NSLog(@"dao name%@", dao.name);
        if ([searchField.textfild.text length]==0) { //空白全部搜尋
            [filteredArray addObject:dao];
        }else {
            NSRange textRange;
            textRange =[[dao.name lowercaseString] rangeOfString:[searchField.textfild.text lowercaseString]];
        
            if(textRange.location != NSNotFound || searchField.textfild.text.length ==0) {
            [filteredArray addObject:dao];
            }
        }
    }

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void) setUIDefault{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.title = AMLocalizedString(@"exhibitors_list",nil);
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];

    [searchBgImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 60) forNinePatchNamed:@"bg_black"]];
    
    if(!searchField)
        searchField = [FcSearchField new];
    searchField.view.frame = ccRectShift(searchField.view.frame, CGPointMake(25, 13));
    searchField.textfild.placeholder = AMLocalizedString(@"exhibitor_input",nil);
   [searchField.textfild setValue:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:searchField.view];
    [searchField settextfildDelegate:self];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =NO;
    [self initDataArray];
    [tableview reloadData];
}
-(void)initDataArray{
    if(!dataArray)
        dataArray = [NSMutableArray new];
    else
        [dataArray removeAllObjects];
    
    if(!filteredArray)
        filteredArray = [NSMutableArray new];
    else
        [filteredArray removeAllObjects];
    
    [imageDownloadsInProgress removeAllObjects];
#ifndef  TESTDATA
    QueryPattern *Query=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
    LoginDataObject *loginDO = [LoginDataObject sharedInstance];
	[Query prepareDic:getExhibitorList(loginDO.sessionId)];
    @try {
        if (([[Query getValue:@"response" withIndex:0]isEqualToString:@"0"])) {
            int number = [Query getNumberUnderNode:@"exhibitorList" withKey:@"id"];
            for (int i=0; i< number  ; i++) {
                ExhibitorListDataObject *dao =[ExhibitorListDataObject new];
                dao.name = [Query getValue:@"name" withIndex:i ];
                dao.exhibitorId = [Query getValue:@"id" withIndex:i ];
                dao.iconName = [Query getValue:@"logo" withIndex:i ];
                dao.dlImg.imgURLString = picUrl([Query getValue:@"logo" withIndex:i ]);
                [dataArray addObject:dao];
                [filteredArray addObject:dao];
                [dao release];
            }
        }else{
            
        }
        
    }
    @catch (NSException * e) {
        //NPLogException(e);
    }
    @finally {
        [Query release];
        
    }

#else
    NSArray *companyName = [[NSArray alloc]initWithObjects:@"台灣積體電路製造股份有限公司", @"聯華電子股份有限公司",@"中國鋼鐵股份有限公司",@"兆豐金融控股股份有限公司", @"中華開發金融控股股份有限公司", @"中華電信股份有限公司", @"中華映管股份有限公司", @"國泰金融控股股份有限公司",nil];

    for (NSString* name in companyName) {
        ExhibitorListDataObject *dao = [ExhibitorListDataObject new];
        dao.name = name;
        dao.iconName = @"ic_aboutus.png";
        [dataArray addObject:dao];
        [filteredArray addObject:dao];
        [dao release];
    }
#endif
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [filteredArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExhibitorListTableViewCell *cell = (ExhibitorListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ExhibitorListTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ExhibitorListTableViewCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
	}
    //cellHeight = cell.frame.size.height;
    [cell setUIDefault];
    [cell setDO:[filteredArray objectAtIndex:indexPath.row]];
    ExhibitorListDataObject *cellDo = [filteredArray objectAtIndex:indexPath.row];
    tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (!imgDowmloader.bLoaded)
    {
        if (tableview.dragging == NO && tableview.decelerating == NO)
        {
            [self startImgDownload:cellDo.dlImg forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        [cell.iconImg setImage:[UIImage imageNamed:@"img_logo_default.png"]];                
    }
    else
    {
        cell.iconImg.image = imgDowmloader.downloadImg.img;
    }
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here. Create and push another view controller.	
    ExhibitorListDataObject *dao= [filteredArray objectAtIndex:indexPath.row];
    infoView = [ExhibitorInfoViewController new];
    infoView.exhibitorId = dao.exhibitorId;
    infoView.iconUrl = dao.iconName;
    infoView.exhibitorName = dao.name;
    [infoView setBackItem:AMLocalizedString(@"back",nil)];
    [infoView setRightItem:AMLocalizedString(@"pathguide",nil)];
    [self.navigationController pushViewController:infoView animated:YES];
}
-(void)leftItemAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [tableview release];
    if (searchField) {
        [searchField release];
    }
    //[pslistViewController release];
    if (filteredArray) {
        [filteredArray release];
    }
    if (dataArray) {
        [dataArray release];
    }
    if(infoView){
        [infoView release];
    }
    [searchBgImg release];
    [super dealloc];
}

#pragma mark -
#pragma mark Image loading 
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
    if ([filteredArray count] > 0)
    {
        NSArray *visiblePaths = [tableview indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            ExhibitorListDataObject *cellDO = [filteredArray  objectAtIndex:indexPath.row];
            tableViewImageDownload *imgDowmloader = [imageDownloadsInProgress objectForKey:indexPath];
            if (!imgDowmloader.bLoaded){
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
        ExhibitorListTableViewCell *cell = (ExhibitorListTableViewCell*) [tableview cellForRowAtIndexPath:imgDowmloader.indexPathInTableView];
        
        // Display the newly loaded image
        cell.iconImg.image = imgDowmloader.downloadImg.img;
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
