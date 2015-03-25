//
//  OveMeetingDetailCtrl.h
//  OveExpo
//
//  Created by  on 11/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"
#import "FcViewController.h"
//*** 會議明細
@interface OveMeetingDetailCtrl2 : FcViewController
{
    //*** Title
    IBOutlet UILabel *title_1;
    IBOutlet UILabel *title_2;
    IBOutlet UITextView *title_view;
    
    //*** Meeting detail feature
    IBOutlet UIView *top_sub_view;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *timeLabel2;
    IBOutlet UILabel *speakerLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *scaleLabel;
    IBOutlet UIImageView *separateLine;
    
    //*** content view
    IBOutlet UITextView *content_view;
    IBOutlet UILabel *contentLabel;
    IBOutlet UILabel *organizerLabel;
    IBOutlet UILabel *sponsorLabel;
    
    
    //*** buttons view
    IBOutlet UIView *buttons_view;
    IBOutlet UIImageView *buttons_view_bg;
    IBOutlet UIImageView *buttons_view_spliter;
    IBOutlet UIButton *joinBt;
    
    //*** Others
    IBOutlet UIScrollView *baseScroll;
    NSString *meetingId;
    Meeting *meeting;
    UIButton *editButton;
    UIButton *backButton;
    BOOL isJoined;
    NSString *joinName;
    NSString *joinMeeting_res;
}

@property BOOL isJoined;
@property (nonatomic, retain) NSString *joinName;
- (id)initWithMeetingId:(NSString *) meetingId;
-(IBAction)ui_joinMeeting:(id)sender;

@end
