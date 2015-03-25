//
//  EventContent.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "WEPopoverController.h"
@interface EventContent : UIViewController<UIScrollViewDelegate>{
    NSString *_eventId;
    UIView *parentView;
    WEPopoverController *parentPopView;
    NSArray *_eventsId;
    BOOL pageControlUsed;
    IBOutlet UILabel *location,*note,*startTime,*endTime;
    IBOutlet UIButton *editBtn;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *titleScrollView;
    EKEvent *thisEvent;
}
@property(nonatomic,retain)UILabel *location,*note,*startTime,*endTime;
@property(nonatomic,retain)UIButton *editBtn;
@property(nonatomic,retain)WEPopoverController *parentPopView;
@property(nonatomic,retain)UIView *parentView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)UIScrollView *titleScrollView;
-(id)initWithEventsId:(NSArray*)eventsId;
-(IBAction)editAction:(id)sender;
@end
