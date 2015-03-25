//
//  ProductDetailView1.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcPageController.h"
@interface FcProductDetailView1 : UIViewController<UIScrollViewDelegate>{
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *brand;
	IBOutlet UILabel *productName;
	IBOutlet UILabel *upperPrice;
	IBOutlet UILabel *lowerPrice;
	
	IBOutlet UILabel *priceStringUpperLabel;
	IBOutlet UILabel *priceStringLowerLabel;
	IBOutlet UILabel *ratingStringLabel;
	IBOutlet UILabel *desStringLabel;
	
	IBOutlet UIImageView *titleBackground;
	IBOutlet UIImageView *productPicture;
    IBOutlet UIImageView *backgroundView;
	IBOutlet UIScrollView *productPictureMinList;
	IBOutlet UIScrollView *contentScrollView;
	IBOutlet UIButton *closeBtn;
    IBOutlet UIButton *shoppingBtn;
	IBOutlet UIView *ratingView;
    IBOutlet UIView *colorView;
	IBOutlet UILabel *contentLabel;
    NSInteger startYPosition;
    NSMutableDictionary *colorDic;
    
    NSString *productId;
    NSMutableArray *contentViews;
    IBOutlet FcPageController *pageController;
    BOOL pageControlUsed;
}
@property(nonatomic,retain)UILabel *titleLabel,*brand,*productName,*upperPrice,*lowerPrice;
@property(nonatomic,retain)UILabel *priceStringUpperLacel,*priceStringLowerLabel,*ratingStringLabel,*desStringLabel,*contentLabel;
@property(nonatomic,retain)UIImageView *titleBackground,*productPicture,*backgroundView;
@property(nonatomic,retain)UIScrollView *productPictureMinList;
@property(nonatomic,retain)UIScrollView *contentScrollView;
@property(nonatomic,retain)UIButton *closeBtn,*shoppingBtn;
@property(nonatomic,retain)UIView *ratingView,*colorView;
@property(nonatomic,retain)FcPageController *pageController;
@property(nonatomic,retain)NSString *productId;
-(IBAction)close:(id)sender;
-(void)changePicAction:(id)sender;
-(void)ratingBar:(CGFloat)ratingScore;
-(void)loadProductInfo:(NSString*)sKey;
-(IBAction)shoppingAction:(id)sender;
-(void)tuneLayout;

//-(UITextView*)createContentScrollSubView:(NSInteger)index;
- (IBAction)changePage:(id)sender;
@end
