//
//  BuyPopView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/24.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyPopView : UIViewController<UITextFieldDelegate> {
    @public
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *shoppingLabel;
    IBOutlet UILabel *shoppingPostLabel;
    IBOutlet UITextField *num;
    IBOutlet UIWebView *contentView;
    @private
    NSString *productName;
    NSString *productId;
    NSInteger productPrice;
    UIView *parentview;
    IBOutlet UILabel *quantityLabel;
}
@property (nonatomic, retain) UILabel *quantityLabel;
@property(nonatomic,retain)UITextField *num;
@property(nonatomic,retain)UILabel *nameLabel,*shoppingLabel,*shoppingPostLabel;
@property(nonatomic,retain)UIWebView *contentView;
-(id)initWithProductId:(NSString*)pId withProductName:(NSString*)pName withProductPrice:(NSInteger)pPrice withParentView:(UIView*)parentUIView;

-(IBAction)cancelBuy:(id)sender;
@end
