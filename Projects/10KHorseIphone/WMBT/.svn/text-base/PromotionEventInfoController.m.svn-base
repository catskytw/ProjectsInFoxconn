//
//  PromotionEventInfoController.m
//  WMBT
//
//  Created by link on 2011/6/6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PromotionEventInfoController.h"
#import "QueryPattern.h"
#import "Configure.h"
#import "UITuneLayout.h"
#import "LocalizationSystem.h"
@implementation PromotionEventInfoController
@synthesize contentTextView;
@synthesize eventId;
@synthesize durationLabel;
@synthesize titleLabel;
@synthesize placeLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = AMLocalizedString(@"PromotionInfo_title", nil);
    }
    return self;
}

- (void)dealloc
{
    [durationLabel release];
    [titleLabel release];
    [placeLabel release];
    [contentTextView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UITuneLayout setNaviTitle:self];
    [UITuneLayout setBackground:self.view];
    titleLabel.textColor= [UIColor colorWithRed:134/255.f green:84/255.f blue:34/255.f alpha:1];
    placeLabel.text = place;
    titleLabel.text= title;
    durationLabel.text = duration;
    contentTextView.text = content;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDurationLabel:nil];
    [self setTitleLabel:nil];
    [self setPlaceLabel:nil];
    [self setContentTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)loadData{
	
	QueryPattern *promotionQuery=[[QueryPattern alloc]initWithStartNotificationName:SHOW_ACTIVITY_INDICATOR withEndNotification:CLOSE_ACTIVITY_INDICATOR];
	[promotionQuery prepareDic:searchPromotionDetailInfo(eventId)];
    @try {
            if([promotionQuery getNumberUnderNode:@"promotionEventInfo" withKey:@"id" withDepth:0]>0){
                place = [promotionQuery getValueUnderNode:@"promotionEventInfo" withKey:@"place" withIndex:0];
                title= [promotionQuery getValueUnderNode:@"promotionEventInfo" withKey:@"title" withIndex:0];
                content = [promotionQuery getValueUnderNode:@"promotionEventInfo" withKey:@"content" withIndex:0];
                duration = [promotionQuery getValueUnderNode:@"promotionEventInfo" withKey:@"eventDate" withIndex:0];
            }
    }
    @catch (NSException * e) {
        NPLogException(e);
    }
    @finally {
         [promotionQuery release];
    }
    
}

@end
