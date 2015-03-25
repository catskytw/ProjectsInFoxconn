//
//  CatalogTemplate.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/20.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcPromotionTemplate1.h"
#import "FcPromotionListCell1.h"
#import "PopWindows1.h"
#import "Configure.h"
#import "LocalizationSystem.h"
#import "FcTabBarItem.h"
#import "QueryPattern.h"
#import "FCProductButtonView1.h"
#import "FcProductDetailView1.h"
#import "FcCatalogTemplate1.h"
#import "SignInObject.h"
#import "LoginView.h"
#import "FcPopWindows.h"
#import "FcProductListView1.h"
@interface FcPromotionTemplate1 (PrivateMethods)
-(void)constructLowPriceProduct;
-(void)constructHotProduct;
-(void)successLogin:(NSNotification*)notification;
-(void)failureLogin:(NSNotification*)notification;
-(void)showPromotionProductList;
@end

@implementation FcPromotionTemplate1
@synthesize contentView;
@synthesize titleLabel,upSectionLabel,middleSectionLabel;
@synthesize leftBtn,middleBtn,rightBtn;
@synthesize titleBackgroundView,middleBackgroundView;
@synthesize hotTitle,hotProductName,hotProductPrice,hotProductBtn;

#pragma mark Developer Override

//give all pictures suiting this template here.
//1.choose your image file carefully.
//2.add them into your project; manage them by folders.
//3.setting each component in template which is needed a suit(picture).
-(void)EnvelopSuit{
	//multi-language
	[titleLabel setText:AMLocalizedString(@"PromotionArea",nil)];
	[middleBackgroundView setImage:[UIImage imageNamed:@"content_ui_limits.png"]];
	[leftBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button.png"] forState:UIControlStateNormal];
	[leftBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button_i.png"] forState:UIControlStateHighlighted];
	[middleBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button.png"] forState:UIControlStateNormal];
	[middleBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button_i.png"] forState:UIControlStateHighlighted];
	[rightBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button.png"] forState:UIControlStateNormal];
	[rightBtn setBackgroundImage:[UIImage imageNamed:@"content_ui_button_i.png"] forState:UIControlStateHighlighted];

	//resize
	//theme suit
	[titleBackgroundView setImage:[UIImage imageNamed:@"content_ui_title_bar.png"]];
	[upSectionLabel setText:AMLocalizedString(@"PromotionAction",nil)];
	[middleSectionLabel setText:AMLocalizedString(@"SpecialPriceArea",nil)];
	[leftBtn setTitle:AMLocalizedString(@"CatalogLeftSearchBtnString",nil) forState:UIControlStateNormal];
	[middleBtn setTitle:AMLocalizedString(@"CatalogMiddleSearchBtnString",nil) forState:UIControlStateNormal];
	[rightBtn setTitle:AMLocalizedString(@"CatalogRightSearchBtnString",nil) forState:UIControlStateNormal];
    
    [hotTitle setText:AMLocalizedString(@"hot", nil)];
}
// use notification to reload data
-(void)reloadProductData:(NSNotification*)notification{
	//fill your query parameter from dataDic.
	[self loadProductData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LASTVIEWPAGETYPE=TabBarIndex_Promote;
}
//用sub-category key來讀取product list
-(void)loadProductData{
	//此處填入你讀取資料之程序
	//共有幾筆data
    if(promoteQueryPattern==nil)
        promoteQueryPattern=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    if(specialPriceQueryPattern==nil)
        specialPriceQueryPattern=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
    if(hotPattern==nil)
        hotPattern=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
	[promoteQueryPattern prepareDic:searchPromoteList()];
	[specialPriceQueryPattern prepareDic:searchPromotionProductList()];
    [hotPattern prepareDic:searchHotProduct()];
    //[self constructLowPriceProduct];
    [self constructHotProduct];
    [upTableView reloadData];
}
-(void)successLogin:(NSNotification*)notification{
    [self loadProductData];
    [firstPopWindow.view removeFromSuperview];
    [firstPopWindow release];
    firstPopWindow=nil;
}
-(void)failureLogin:(NSNotification*)notification{
    
}
#pragma mark -

#pragma mark LiftCycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(successLogin:) name:SuccessLogin object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(failureLogin:) name:FailureLogin object:nil];
    
    specialPriceQueryPattern=nil;
    promoteQueryPattern=nil;
    hotPattern=nil;
    
	FcTabBarItem *thisBarItem=[[FcTabBarItem alloc]initWithTitle:AMLocalizedString(@"PromotionArea",nil) image:[UIImage imageNamed:@"content_ui_underbar_sales.png"] tag:1];
	thisBarItem.customStdImage=[UIImage imageNamed:@"content_ui_underbar_sales.png"];
	thisBarItem.customHighlightedImage=[UIImage imageNamed:@"content_ui_underbar_sales_i.png"];
    self.tabBarItem=thisBarItem;
	self.tabBarController.selectedIndex=1;
	
	[thisBarItem release];
	
	upTableView.delegate=self;
	upTableView.dataSource=self;

	/*
	 IMPORTANT!! For Foxconn developers:
	 We suppose your products' data are ready and envelop them into allProductData.
	 */
	[self EnvelopSuit];
    [self loadProductData];
    [self showPromotionProductList];
}
- (void)viewDidUnload {
	//解除notification註冊
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:SuccessLogin object:nil];
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:FailureLogin object:nil];
    
	[promoteQueryPattern release];
	[specialPriceQueryPattern release];
    [hotPattern release];
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -

#pragma mark PrivateMethods
-(void)constructHotProduct{                
    NSString *picFileName=[hotPattern getValue:@"image250" withIndex:0];
    [hotPattern getImageData:picUrl(picFileName) withUIComponent:hotProductBtn withNotificationName:nil];
    [hotProductBtn.titleLabel setText:[hotPattern getValue:@"id" withIndex:0]];
    [hotProductBtn.titleLabel setTextColor:[UIColor clearColor]];
    [hotProductName setText:[hotPattern getValue:@"name" withIndex:0]];
    [hotProductPrice setText:[Tools formatMoneyString:[hotPattern getValue:@"retailPrice" withIndex:0]]];
}
-(void)constructLowPriceProduct{
    int startY=0;
    int categoryHeight=235;
    NSInteger totalCategory=[specialPriceQueryPattern getNumberUnderNode:@"productTypeList" withKey:@"id" withDepth:1];
    //加入標籤
    for (int i=0; i<totalCategory; i++) {
        NSDictionary *subDic=[NSDictionary dictionaryWithObject:[specialPriceQueryPattern getObjectUnderNode:@"productList" withIndex:i] forKey:@"whatever"];
        QueryPattern *subQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
        [subQuery prepareDicWithDictionary:subDic];
        NSInteger allProductsUnderThisCategory=[subQuery getNumberForKey:@"id"];
        //該類別下要有產品回傳,才需要顯示於畫面上
        if(allProductsUnderThisCategory>0){
            NSInteger actualProductsNum=(allProductsUnderThisCategory>5)?5:allProductsUnderThisCategory;
            UILabel *categoryLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, startY, 300, 18)];
            NSString *labelString=[specialPriceQueryPattern getValueUnderNode:@"productTypeList" withKey:@"name" withIndex:i withDepth:1];
            [categoryLabel setText:labelString];
            [categoryLabel setTextColor:[UIColor blackColor]];
            [categoryLabel setBackgroundColor:[UIColor clearColor]];
            [contentView addSubview:categoryLabel];
            [categoryLabel release];
            
            for(int j=0;j<actualProductsNum;j++){
                int xSpace=143;
                UILabel *numLabel=[[UILabel alloc]initWithFrame:CGRectMake(xSpace*j, startY+29, 80, 11)];
                [numLabel setTextColor:[UIColor blackColor]];
                [numLabel setFont:[UIFont fontWithName:DefaultFontName size:11.0f]];
                [numLabel setText:[NSString stringWithFormat:@"NO.%i",j+1]];
                [numLabel setBackgroundColor:[UIColor clearColor]];
                [contentView addSubview:numLabel];
                
                FcProductButtonView1 *thisProduct=[FcProductButtonView1 new];
                [thisProduct.view setFrame:CGRectMake(xSpace*j, startY+44, 128, 178)];
                [contentView addSubview:thisProduct.view];
                [subQuery valueBinding:thisProduct.actionButton.titleLabel withKey:@"id" withIndexArray:j];
                [subQuery valueBinding:thisProduct.name withKey:@"name" withIndexArray:j];
                [subQuery valueBinding:thisProduct.brand withKey:@"brand" withIndexArray:j];
                [thisProduct.price setText:[Tools formatMoneyString:[subQuery getValue:@"retailPrice" withIndex:j]]];
                NSString *picFileName=[subQuery getValue:@"image110" withIndex:j];
                [subQuery uiValueBinding:thisProduct.picture withValue:picUrl(picFileName)];
                [thisProduct.actionButton addTarget:self action:@selector(buttonSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
                
                //[thisProduct release];
                [thisProduct tuneLayout];
                [numLabel release];
            }
            startY+=categoryHeight;
            [contentView setContentSize:CGSizeMake(contentView.frame.size.width, startY)];
        }
        [subQuery release];
    }
}
-(IBAction)buttonSelectedAction:(id)sender{
    FcProductDetailView1 *selectedProduct=[[FcProductDetailView1 alloc]init];
	[self.view addSubview:selectedProduct.view];
    
	UIButton *btn=(UIButton*)sender;
    [selectedProduct loadProductInfo:btn.titleLabel.text];
    [selectedProduct tuneLayout];
}

-(void)showPromotionProductList{
    NSInteger maxNum=([specialPriceQueryPattern getNumberUnderNode:@"productList" withKey:@"id"]>35)?35:[specialPriceQueryPattern getNumberUnderNode:@"productList" withKey:@"id"];
    promotionList=[[FcProductListView1 alloc] initWithProductNumber:maxNum withStartIndex:0 isCompareMode:NO withDataSource:specialPriceQueryPattern];
    [contentView addSubview:promotionList.view];
    NSLog(@"width:%f",promotionList.view.frame.size.width);
    [contentView setContentSize:promotionList.view.frame.size];
}
#pragma mark -
#pragma mark DelegateMethod

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [promoteQueryPattern getNumberUnderNode:@"promotionEventList" withKey:@"id"];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FcPromotionListCell1";
    FcPromotionListCell1 *cell =(FcPromotionListCell1*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"FcPromotionListCell1" owner:nil options:nil];
		for(id currentObject in  nib){
			if([currentObject isKindOfClass:[FcPromotionListCell1 class]]){
				cell=(FcPromotionListCell1*)currentObject;
				cell.key=[promoteQueryPattern getValueUnderNode:@"promotionEventList" withKey:@"id" withIndex:[indexPath row]];
				[cell.titleLabel setText:[promoteQueryPattern getValueUnderNode:@"promotionEventList" withKey:@"title" withIndex:[indexPath row]]];
				[cell.subLabelLeft setText:[promoteQueryPattern getValueUnderNode:@"promotionEventList" withKey:@"eventDate" withIndex:[indexPath row]]];
					
				[cell.descriptionLabel setText:[promoteQueryPattern getValueUnderNode:@"promotionEventList" withKey:@"content" withIndex:[indexPath row]]];
				[cell.subLabelRight setText:[NSString stringWithFormat:@"%@:%@",AMLocalizedString(@"place",nil),[promoteQueryPattern getValueUnderNode:@"promotionEventList" withKey:@"place" withIndex:[indexPath row]]]];
                cell.detailLabel.text =AMLocalizedString(@"PromotionDetailLable", nil);
				break;
			}
		}
    }    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	FcPromotionListCell1 *selectedCell=(FcPromotionListCell1*)[tableView cellForRowAtIndexPath:indexPath];
	PopWindows1 *popWindows=[[PopWindows1 alloc]initWithKey:selectedCell.key];
	[self.view addSubview:popWindows.view];
	//release by himself.
}

#pragma mark -
@end
int LASTVIEWPAGETYPE;