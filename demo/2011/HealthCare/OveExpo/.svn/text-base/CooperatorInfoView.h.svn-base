//
//  ExhibitroInfoViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface CooperatorInfoView : FcViewController{
    IBOutlet UIImageView *seperateImg;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIButton *pathGuideBtn;
    IBOutlet UIButton *websiteBtn;
    IBOutlet UIScrollView *contentScroll;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *infoLabel;
    IBOutlet UIImageView *btnBgImg;
    
    NSString *website;
    NSString *cooperatorId;
}

@property (nonatomic, retain) IBOutlet UIButton *pathGuideBtn;
@property (nonatomic, retain) IBOutlet UIImageView *btnBgImg;

@property (nonatomic, retain) IBOutlet UILabel *phoneLabel,*addressLabel,*emailLabel,*infoLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *contentScroll;
@property (nonatomic, retain) IBOutlet UIImageView *seperateImg;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIButton *websiteBtn;
@property (nonatomic, retain) NSString *cooperatorId;
-(IBAction)goWebSite:(id)sender;
-(IBAction)googleRoute:(id)sender;
-(void) setUIDefault;
-(void) initData;
@end
