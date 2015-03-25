//
//  ExhibitroInfoViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitorBookingViewController.h"
#import "ExhibitorAddToPSViewController.h"
#import "FcViewController.h"
#import "LocationInfoObject.h"
@interface ExhibitorInfoViewController : FcViewController <UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate>{
    UIImageView *imgIcon;
    UIImageView *seperateImg;
    UILabel *nameLable;
    UIButton *addScheduleBtn;
    UIButton *downloadBtn;
    UIButton *bookingBtn;
    UIButton *websiteBtn;
    UIScrollView *contentScroll;
    UILabel *productLocationLabel;
    UILabel *placeLabel;
    UILabel *websiteLabel;
    UILabel *infoLabel;
    UIButton *backButton;
    UIButton *editButton;
    NSString *exhibitorId;
    NSString *exhibitorName;
    NSString *location;
    NSString *iconUrl;
    NSString *website;
    NSString *downloadUrl;
    UIImageView *btnBgImg;
    ExhibitorBookingViewController *bookingView;
    ExhibitorAddToPSViewController *psView;
    UIButton *pathGuideBtn;
    
    LocationInfoObject *thisLocation;
}

@property (nonatomic, retain) IBOutlet UIButton *pathGuideBtn;
@property (nonatomic, retain) IBOutlet UIImageView *btnBgImg;
@property (nonatomic, retain) NSString *exhibitorId;
@property (nonatomic, retain) NSString *iconUrl;
@property (nonatomic, retain) NSString *exhibitorName;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) IBOutlet UILabel *placeLabel;
@property (nonatomic, retain) IBOutlet UILabel *websiteLabel;
@property (nonatomic, retain) IBOutlet UILabel *infoLabel;
@property (nonatomic, retain) IBOutlet UILabel *productLocationLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *contentScroll;
@property (nonatomic, retain) IBOutlet UIImageView *seperateImg;
@property (nonatomic, retain) IBOutlet UILabel *nameLable;
@property (nonatomic, retain) IBOutlet UIButton *addScheduleBtn;
@property (nonatomic, retain) IBOutlet UIButton *downloadBtn;
@property (nonatomic, retain) IBOutlet UIButton *bookingBtn;
@property (nonatomic, retain) IBOutlet UIButton *websiteBtn;
@property (nonatomic, retain) IBOutlet UIImageView *imgIcon;
- (IBAction)toWebSite:(id)sender;
- (IBAction)booking:(id)sender;
- (IBAction)download:(id)sender;
- (IBAction)addToSchedule:(id)sender;
- (IBAction)pathGuide:(id)sender;
//-(void)removeNaviBtn;
-(void) setUIDefault;
-(void) initData;
//-(void)addEditButton;
//-(void)addBackButton;
@end
