//
//  CatalogTemplate.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/20.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FcPromotionTemplate1 : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UIScrollView *contentView;
	IBOutlet UIImageView *titleBackgroundView;
	IBOutlet UIImageView *upBackgroundView;
	IBOutlet UIImageView *middleBackgroundView;
	IBOutlet UIButton *leftBtn;
	IBOutlet UIButton *middleBtn;
	IBOutlet UIButton *rightBtn;
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *upSectionLabel;
	IBOutlet UILabel *middleSectionLabel;
	IBOutlet UITableView *upTableView;
	
@private
	UIPageControl *pageControl;
	
	int pageNumber;
	int numOfDataEntry;
	int productNumInPage;
	NSMutableArray *pageViews;
	BOOL pageControlUsed;
	
}
@property(nonatomic,retain) UIScrollView *contentView;
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UIButton *leftBtn,*middleBtn,*rightBtn;
@property(nonatomic,retain) UIImageView *titleBackgroundView,*middleBackgroundView,*upBackgroundView;
@property(nonatomic,retain) UILabel *upSectionLabel,*middleSectionLabel;
-(void)loadProductData;

-(void)EnvelopSuit;
-(IBAction)leftBtnAction:(id)sender;
-(IBAction)middleBtnAction:(id)sender;
-(IBAction)rightBtnAction:(id)sender;

@end
