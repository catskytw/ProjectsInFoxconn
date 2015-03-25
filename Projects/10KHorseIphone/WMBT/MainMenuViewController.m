
//
//  MainMenuViewController.m
//  WMBT
//
//  Created by link on 2011/2/25.
//  Copyright 2011 foxconn. All rights reserved.
//


#import "menuIconView.h"

#import "LocalizationSystem.h"
#import "ProductCatelogController.h"
#import "PromotionController.h"
#import "UITuneLayout.h"
#import "LoginDataObject.h"
#import "AccountController.h"
@implementation MainMenuViewController
@synthesize scrollView,mainController, mainNavigation;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
//請依需求定義文字資訊與圖片資源名兩個陣列必須同樣大小
- (void)viewDidLoad {
	[super viewDidLoad];
	//LocalizationSetLanguage(@"zh-Hant-TW");
    self.navigationItem.title = AMLocalizedString(@"title_backhome",nil);
    mainNavigation = self.navigationController;
	scrollView.minimumZoomScale = 0.25;
	scrollView.maximumZoomScale = 2;
	scrollView.bounces = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.showsVerticalScrollIndicator = YES;
	[self.navigationController setNavigationBarHidden:YES];

	//請定義文字資料
	
	if (menuArray ==nil) {
		menuArray = [[NSArray arrayWithObjects: AMLocalizedString(@"MainMenu_Catelog",nil), AMLocalizedString(@"MainMenu_Promote",nil),AMLocalizedString(@"MainMenu_Member",nil),nil]retain];
	}
	if (menuPathArray ==nil) {
		//請填入圖片資料
		menuPathArray = [[NSArray arrayWithObjects: @"indexui_btn_e.png", @"indexui_btn_f.png",@"indexui_btn_c.png",nil]retain];
	}
	//self.view = scrollView;
	[self setUpMenusWithString:menuArray andPathArray: menuPathArray];

    
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:scrollView];
}
//set Navigation bar title font 
-(void) setNaviTitle: (id)controller{
    CGRect frame = CGRectMake(0,0, 400, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor= [UIColor lightGrayColor];
    UIViewController *ctrl = (UIViewController*)controller;
    ctrl.navigationItem.titleView = label;
    label.text= ctrl.title;
}
// customize the tab bar background
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void) setUpMenusWithString:(NSArray*)MenuArray andPathArray:(NSArray*)pathArray{
	int count = 0;
	for (NSString *menuShow in MenuArray){
		menuIconView *iconView =(menuIconView *)[[[NSBundle mainBundle] loadNibNamed:@"menuIconView" owner:self options:nil] objectAtIndex:0];
		iconView.frame = CGRectMake(
									menuIconMarginX+(menuIconWidth+menuIconBetweenX)*(count%menuIconCntLine),
									menuIconMarginY+(menuIconHeight+menuIconTextFont+menuIconBetweenY+menuIconTextBetweenY)*(count/menuIconCntLine),
									menuIconWidth,menuIconHeight+menuIconTextFont+menuIconBetweenY);
		
		
		[iconView addImage:[pathArray objectAtIndex:count] andLabelTxt:menuShow  andController:self];
		[scrollView addSubview:iconView];
		count++;
	}	
}
#pragma mark -
#pragma mark PrivateMethod
//write your own method here.

//請填入每個選項點擊後，執行的功能
-(void) menuAction:(NSString*) menuName{
	if ([menuName isEqualToString:[menuArray objectAtIndex:0]]) {
		ProductCatelogController *mainCatelog=[[ProductCatelogController alloc] init] ;
		mainCatelog.mainController = self;
		[self.navigationController pushViewController:mainCatelog animated:YES];
        [self.navigationController setNavigationBarHidden:NO];
        [mainCatelog release];
		
	}	
    if ([menuName isEqualToString:[menuArray objectAtIndex:1]]) {
        PromotionController *mainPromotion=[PromotionController new] ;
		mainPromotion.mainController = self;
        [mainPromotion loadProductData];
		[self.navigationController pushViewController:mainPromotion animated:YES];
        [self.navigationController setNavigationBarHidden:NO];
        [mainPromotion release];
	}	
    if ([menuName isEqualToString:[menuArray objectAtIndex:2]]) {
  
            AccountController *accountInfoController = [[AccountController alloc] init] ;
            [self.navigationController pushViewController:accountInfoController animated:YES];
            [accountInfoController release];
            [self.navigationController setNavigationBarHidden:NO];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	if(menuArray!=nil)
		[menuArray release];
	if(menuPathArray!=nil)
		[menuPathArray release];
}

@end
