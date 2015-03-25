//
//  FcProductTableCell.h
//  FcProductList
//
//  Created by link on 2011/2/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListCellDataObject.h"
#define OnSellFontSize 16
#define PriceFontSize 16
#define NameFontSize 16

@interface FcProductTableCell : UITableViewCell {
	IBOutlet UIImageView *imgProduct;
	IBOutlet UILabel *lblName;
	IBOutlet UIImageView *imgScore;
	IBOutlet UILabel *lblprice;
	id productListController;
    IBOutlet UIImageView *No1Img;
    BOOL bLoaded;
}
@property (nonatomic, retain)  UIImageView *No1Img;
@property(nonatomic,retain) UIImageView *imgProduct;
@property(nonatomic,retain) UILabel *lblName;
@property(nonatomic,retain) UIImageView *imgScore;
@property(nonatomic,retain) UILabel *lblprice;
@property(nonatomic,retain) id productListController;
@property(nonatomic) BOOL bLoaded;
- (void)setInfo:(NSString*) urlImgProduct andNameTxt:(NSString*) strName andPriceTxt:(NSString*) strPrice
	andScore:(NSString*) urlScore andController:(id) viewController;

- (void)setInfoDO:(ProductListCellDataObject*) dao andController:(id) viewController;
-(void) showNo1:(int)number;

@end
