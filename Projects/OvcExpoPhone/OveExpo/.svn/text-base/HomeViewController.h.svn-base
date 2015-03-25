//
//  HomeViewController.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountLoginViewController.h"
#import "OveMeetingListCtrl.h"
#import "ExhibitorListViewController.h"
#import "ExhibitorAddBookingListViewController.h"
#import "BusinessCardHome.h"
#import "PersonalEventListViewController.h"
#import "ExhibitorEventViewController.h"
#import "AboutUsViewCtrl.h"
@interface HomeViewController : UIViewController{
    IBOutlet UIImageView *topBarViewController;
    NSMutableArray *_buttons;
    AccountLoginViewController *loginView;
    OveMeetingListCtrl *meetingCtrl;
    BusinessCardHome *myBusinessCardCtrl;
    ExhibitorListViewController *companyListView;
    ExhibitorAddBookingListViewController *bookingListView;
    ExhibitorEventViewController *exhibitorEvent;
    AboutUsViewCtrl *aboutUs;
}
@property(nonatomic,retain)UIImageView *topBarViewController;
-(void)checkLogin;
@end
