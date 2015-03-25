//
//  ProductDetailView1.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FcProductDetailView1 : UIViewController {
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
	IBOutlet UIScrollView *productPictureMinList;
	IBOutlet UITextView *content;
	IBOutlet UIButton *closeBtn;
	IBOutlet UIView *ratingView;
}
@property(nonatomic,retain)UILabel *titleLabel,*brand,*productName,*upperPrice,*lowerPrice;
@property(nonatomic,retain)UILabel *priceStringUpperLacel,*priceStringLowerLabel,*ratingStringLabel,*desStringLabel;
@property(nonatomic,retain)UIImageView *titleBackground,*productPicture;
@property(nonatomic,retain)UIScrollView *productPictureMinList;
@property(nonatomic,retain)UITextView *content;
@property(nonatomic,retain)UIButton *closeBtn;
@property(nonatomic,retain)UIView *ratingView;
-(IBAction)close:(id)sender;
@end
