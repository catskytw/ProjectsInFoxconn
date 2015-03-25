//
//  PersonalEventInfoViewController.h
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
#import "LocationInfoObject.h"
@interface PersonalEventInfoViewController : FcViewController {
    UIScrollView *scrollView;
    UILabel *locationLabel;
    UILabel *statusLabel;
    UILabel *remarkLabel;
    UILabel *titleLabel;
    UIImageView *seperateImg;
    UILabel *startTimeLabel;
    UILabel *endTimeLabel;
    NSString *eventId;
    //UIButton *backButton;
    //UIButton *editButton;
    
    LocationInfoObject *thisLocation;
}

@property (nonatomic, retain) IBOutlet UILabel *startTimeLabel;
@property (nonatomic, retain) NSString *eventId;
@property (nonatomic, retain) IBOutlet UILabel *endTimeLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UILabel *locationLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UILabel *remarkLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *seperateImg;
-(void) setUIDefault;
-(void) initData;
//-(void)addEditButton;
//-(void)addBackButton;
@end
