//
//  CatalogTemplate.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/20.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcPageController.h"
@interface FcCatalogTemplate1 : UIViewController <UIScrollViewDelegate>{
	IBOutlet UIScrollView *contentView;
	IBOutlet UIImageView *titleBackgroundView;
	IBOutlet UIImageView *brandBackgroundView;
	IBOutlet UIImageView *middleBackgroundView;
	IBOutlet UIButton *categorySearchBtn;
	IBOutlet UILabel *categoryLabel;
	IBOutlet UIScrollView *brandScrollView;
	IBOutlet UIButton *sortBtnLeft;
	IBOutlet UIButton *sortBtnMiddle;
	IBOutlet UIButton *sortBtnRight;
	IBOutlet UILabel *titleLabel;
	
@private
	FcPageController *pageControl;
	
	int pageNumber;
	int numOfDataEntry;
	int productNumInPage;
	NSMutableArray *pageViews;
	BOOL pageControlUsed;
	
}
@property(nonatomic,retain) UIScrollView *contentView,*brandScrollView;
@property(nonatomic,retain) UILabel *categoryLabel,*titleLabel;
@property(nonatomic,retain) UIButton *categorySearchBtn,*sortBtnLeft,*sortBtnMiddle,*sortBtnRight;
@property(nonatomic,retain) UIImageView *titleBackgroundView,*brandBackgroundView,*middleBackgroundView;
-(void)loadProductData;

-(void)EnvelopSuit;
-(IBAction)leftBtnAction:(id)sender;
-(IBAction)middleBtnAction:(id)sender;
-(IBAction)rightBtnAction:(id)sender;
-(IBAction)searchAction:(id)sender;
-(IBAction)brandAction:(id)sender;

@end
