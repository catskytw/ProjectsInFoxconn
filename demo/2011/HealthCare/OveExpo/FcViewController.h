//
//  FcViewController.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FcViewController : UIViewController
-(void)setRightItemWithPic:(NSString*)normalPic withHighlightPic:(NSString*)highLightPic;
-(void)setBackItem:(NSString*)btnTitle;
-(void)setRightItem:(NSString*)btnTitle;
-(void)setRightItem2:(NSString*)btnTitle;
-(void)setLeftItem:(NSString*)btnTitle;
-(void)goBack:(id)sender;
-(void)rightItemAction:(id)sender;
-(void)leftItemAction:(id)sender;

-(void) setUIDefault;
-(void)settingBtnStyle:(UIButton*)_targetBtn;
@end
