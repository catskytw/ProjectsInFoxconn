//
//  CatalogTemplate.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/20.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryPattern.h"
#import "FcPopWindows.h"
#import "FcProductListView1.h"
extern int LASTVIEWPAGETYPE;
@interface FcPromotionTemplate1 : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UIScrollView *contentView;
	IBOutlet UIImageView *titleBackgroundView;
	IBOutlet UIImageView *middleBackgroundView;
	IBOutlet UIButton *leftBtn;
	IBOutlet UIButton *middleBtn;
	IBOutlet UIButton *rightBtn;
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *upSectionLabel;
	IBOutlet UILabel *middleSectionLabel;
	IBOutlet UITableView *upTableView;
    
    IBOutlet UILabel *hotTitle;
    IBOutlet UIButton *hotProductBtn;
    IBOutlet UILabel *hotProductName;
    IBOutlet UILabel *hotProductPrice;
	
@private
	UIPageControl *pageControl;
	
	int pageNumber;
	int numOfDataEntry;
	int productNumInPage;
	NSMutableArray *pageViews;
	BOOL pageControlUsed;
	FcPopWindows *firstPopWindow;
    FcProductListView1 *promotionList;
#pragma mark DeveloperDefine
	QueryPattern *promoteQueryPattern;
	QueryPattern *specialPriceQueryPattern;
    QueryPattern *hotPattern;
#pragma mark -
}
@property(nonatomic,retain) UIScrollView *contentView;
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UIButton *leftBtn,*middleBtn,*rightBtn;
@property(nonatomic,retain) UIImageView *titleBackgroundView,*middleBackgroundView;
@property(nonatomic,retain) UILabel *upSectionLabel,*middleSectionLabel;
@property(nonatomic,retain) UILabel *hotTitle,*hotProductName,*hotProductPrice;
@property(nonatomic,retain) UIButton *hotProductBtn;
-(IBAction)buttonSelectedAction:(id)sender;
-(void)loadProductData;
-(void)EnvelopSuit;
@end
