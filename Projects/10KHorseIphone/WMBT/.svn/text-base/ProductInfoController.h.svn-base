//
//  ProductInfoController.h
//  WMBT
//
//  Created by link on 2011/4/1.
//  Copyright 2011年 Foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryPattern.h"
#import "ShoppingCartCellDataObject.h"
@interface ProductInfoController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>{
    IBOutlet UIImageView *imgProduct;
	IBOutlet UILabel *lblName;
	IBOutlet UIImageView *imgScore;
	IBOutlet UILabel *lblPrice;
    IBOutlet UILabel *lblBrand;
    IBOutlet UILabel *lblMemberPrice;
    IBOutlet UILabel *lblPriceLable;
    IBOutlet UIButton *btnColor;
    IBOutlet UIImageView *imgCart;
    IBOutlet UIButton *btnCart;
    IBOutlet UIScrollView *contentScrollView;
    IBOutlet UIPageControl *pageController;
    UIView *colorView;
    UIPickerView * picker;
    NSString* sID;
    NSMutableDictionary *colorDic;
    NSMutableArray *colorArray;
    id mainController;
    UIView *colorFrameView;
    ShoppingCartCellDataObject *shoppingCartDao;
    BOOL pageControlUsed;
}
@property (nonatomic, retain) IBOutlet UIView *colorFrameView;
@property(nonatomic,retain) id mainController;
@property(nonatomic,retain) IBOutlet UIImageView *imgProduct;
@property(nonatomic,retain) IBOutlet UILabel *lblName;
@property(nonatomic,retain) IBOutlet UIImageView *imgScore;
@property(nonatomic,retain) IBOutlet UILabel *lblPrice;
@property(nonatomic,retain) IBOutlet UILabel *lblBrand;
@property(nonatomic,retain) IBOutlet UILabel *lblMemberPrice;
@property(nonatomic,retain) IBOutlet UILabel *lblMemberPriceLable;

@property(nonatomic,retain) IBOutlet UIPickerView * picker;
@property(nonatomic,retain) IBOutlet UIView *colorView;
@property(nonatomic,retain) IBOutlet UIButton *btnCart;
@property(nonatomic,retain) IBOutlet UIButton *btnColor;
@property(nonatomic,retain)NSString *sID;
@property(nonatomic,retain)UIScrollView *contentScrollView;
@property(nonatomic,retain)UIPageControl *pageController;
-(void)loadProductData;
-(NSMutableString*) getspecList:(QueryPattern*)qP;
-(void)setScore:(CGFloat)ratingScore;
- (IBAction)togglePicker:(id) button;
- (IBAction)addToShoppingCart:(id)sender;
-(NSString*)contentString:(NSInteger)index withQueryPattern:(QueryPattern*)query;
-(void)constructContentSubView:(QueryPattern*)query;
- (IBAction)changePage:(id)sender;
@end
