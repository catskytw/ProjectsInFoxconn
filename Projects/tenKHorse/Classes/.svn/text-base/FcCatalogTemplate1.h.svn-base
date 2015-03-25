//
//  CatalogTemplate.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/20.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryPattern.h"
#import "FcPageController.h"
#import "PopoverContentTemplate1.h"
#import "CompareView.h"
extern int LASTVIEWPAGETYPE;
@interface FcCatalogTemplate1 : UIViewController <UIScrollViewDelegate,PopoverContentTemplate1Delegate>{
    @public
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
	IBOutlet UILabel *filterLabel;
    IBOutlet UIButton *filterButton1,*filterButton2,*filterButton3,*resetBtn;
    IBOutlet FcPageController *pageControl;
    IBOutlet UISwitch *compareSwitch;
    NSString *sCategoryKey; //決定本次查詢使用什麼sub key
@private
    IBOutlet UIView *compareBackView;
    BOOL isCompareFullShow;
    CompareView *comparePanel;
    
	QueryPattern *queryPattern;
	NSMutableDictionary *queryAttributeDic;
	
	int pageNumber;
	int numOfDataEntry;
	int productNumInPage;
	NSMutableArray *pageViews;
	BOOL pageControlUsed;
	NSInteger brandXPosition;
	
    NSString *brandString,*colorString,*priceString;
    
    UIPopoverController *_filterPopover;
    UIPopoverController *_categoryPopover;
    NSMutableDictionary *brandDic,*colorDic,*priceDic;
    
    IBOutlet UILabel *compareLabel;
}
@property (nonatomic, retain) UILabel *compareLabel;

@property(nonatomic,retain) UIScrollView *contentView,*brandScrollView;
@property(nonatomic,retain) UILabel *categoryLabel,*titleLabel,*filterLabel;
@property(nonatomic,retain) UIButton *categorySearchBtn,*sortBtnLeft,*sortBtnMiddle,*sortBtnRight;
@property(nonatomic,retain) UIImageView *titleBackgroundView,*brandBackgroundView,*middleBackgroundView;
@property(nonatomic,retain) UIButton *filterButton1,*filterButton2,*filterButton3, *resetBtn;
@property(nonatomic,retain) FcPageController *pageControl;
@property(nonatomic,retain) UISwitch *compareSwitch;
@property(nonatomic,retain)UIView *compareBackView;
@property(nonatomic,retain)NSString *sCategoryKey;
-(void)loadProductData;

-(void)EnvelopSuit;
-(IBAction)leftBtnAction:(id)sender;
-(IBAction)middleBtnAction:(id)sender;
-(IBAction)rightBtnAction:(id)sender;
-(IBAction)searchAction:(id)sender;
- (IBAction)changePage:(id)sender;
//-(IBAction)brandAction:(id)sender;


-(IBAction)brandAction:(id)sender;
-(IBAction)priceAction:(id)sender;
-(IBAction)colorAction:(id)sender;
-(IBAction)resetAction:(id)sender;
-(IBAction)switchValueChanged;
@end
