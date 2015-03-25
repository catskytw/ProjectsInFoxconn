//
//  CompanyListViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "CooperatorCategoryList.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Tool.h"
#import "CooperatorCategoryListCell.h"
#import "CooperatorDummyDao.h"
#import "CommonDataObject.h"
#import "CooperatorsList.h"

#define cellHeight 45
@interface CooperatorCategoryList(PrivateMethod)
-(void)fetchData;
@end
@implementation CooperatorCategoryList
@synthesize searchBgImg;
@synthesize dataTable;

#pragma mark - View lifecycle
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = (nibNameOrNil==nil)?[super initWithNibName:@"ServiceIntroViewController" bundle:nibBundleOrNil]:[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isShowSearchBar=NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [self initDataArray];
    [super viewDidLoad];
    [searchField settextfildDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =NO;
    [self fetchData];
    [dataTable reloadData];
}

- (void)dealloc {
    [Tool nilRelease:searchBgImg];
    [Tool nilRelease:searchField];
    [Tool nilRelease:filteredArray];
    [Tool nilRelease:dataArray];
    [super dealloc];
}
#pragma -
#pragma mark - DelegateMethod
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog("numberOfRowsInSection: %i",[[mCategoryDic allKeys]count]);
    return [filteredArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CooperatorCategoryListCell *cell = (CooperatorCategoryListCell*)[tableView dequeueReusableCellWithIdentifier:@"CooperatorCategoryListCell"];
    if (cell == nil){
        // Load the top-level objects from the custom cell XIB.      
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CooperatorCategoryListCell" owner:nil options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    CommonDataObject *thisObj=[filteredArray objectAtIndex:[indexPath row]];
    [cell.contentLabel setText:thisObj.objName];
    [cell setUIDefault];
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CooperatorsList *nextList=[CooperatorsList new];
    [nextList setBackItem:AMLocalizedString(@"back", nil)];
    CommonDataObject *thisObj=[filteredArray objectAtIndex:[indexPath row]];
    nextList.categoryUUID=thisObj.objId;
    nextList.title=thisObj.objName;
    [self.navigationController pushViewController:nextList animated:YES];
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
        
        [dataTable reloadData];
    }
    [searchField.textfild resignFirstResponder];
    return NO;
}
#pragma -
#pragma mark - ActionMethod
#pragma -
#pragma mark - Layout
-(void) setUIDefault{
    [super setUIDefault];
    [searchBgImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(320, 60) forNinePatchNamed:@"bg_black"]];
    
    if(!searchField)
        searchField = [FcSearchField new];
    searchField.view.frame = ccRectShift(searchField.view.frame, CGPointMake(22, 13));
    searchField.textfild.placeholder = AMLocalizedString(@"Search",nil);
    [searchField.textfild setValue:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    if(isShowSearchBar)
        [self.view addSubview:searchField.view];
}
#pragma -
#pragma mark - DataControl
-(void)fetchData{
    [dataArray removeAllObjects];
    CooperatorDataAdaptor *m_dao=[CooperatorDummyDao new];
    [dataArray addObjectsFromArray:[m_dao categoryData]];
    [m_dao release];
    
    [self filter];
}
-(void)initDataArray{
    dataArray=[NSMutableArray new];
    filteredArray=[NSMutableArray new];
}
-(void)filter{
    [filteredArray removeAllObjects];
    if ([searchField.textfild.text length]==0) { //空白全部搜尋
        [filteredArray addObjectsFromArray:dataArray];
        return;
    }
    for (CommonDataObject *m_dao in dataArray) {
        NSRange m_textRange;
        m_textRange =[[m_dao.objName lowercaseString] rangeOfString:[searchField.textfild.text lowercaseString]];
        
        if(m_textRange.location != NSNotFound || searchField.textfild.text.length ==0) {
            [filteredArray addObject:m_dao];
        }
    }
}
#pragma -
@end
