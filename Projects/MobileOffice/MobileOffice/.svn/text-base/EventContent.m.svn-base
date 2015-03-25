//
//  EventContent.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "EventContent.h"
#import "NSFormatterExtend.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "Tools.h"
#import "EventEditViewController.h"
#import "CalendarDAO.h"
#import "FcDrawing.h"
#import "ProjectTool.h"
@interface EventContent(PrivateMethod)
-(void)constructTitlePages;
-(void)constructEventContent:(NSString*)i_eventId;
- (IBAction)changePage:(id)sender;
@end
@implementation EventContent
@synthesize location,note,startTime,endTime,editBtn,parentView,parentPopView,pageControl,titleScrollView;
-(id)initWithEventsId:(NSArray*)eventsId{
    if((self=[super init])){
        _eventsId=[[NSArray arrayWithArray:eventsId] retain];
        _eventId=[[NSString stringWithString:(NSString*)[_eventsId objectAtIndex:0]]retain];
        pageControlUsed=YES;
    }
    return self;
}
-(void)dealloc{
    [thisEvent release];
    [_eventsId release];
    [_eventId release];
    [super dealloc];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [editBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:editBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [editBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:editBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
    UIImageView *lineImage=[[[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:ccs(330, 3) forNinePatchNamed:@"popup_line"]] autorelease];
    lineImage.center=ccp(165, 41);
    [self.view addSubview:lineImage];

    [self constructTitlePages];
    [self constructEventContent:_eventId];
}
-(void)constructEventContent:(NSString*)i_eventId{
    EKEvent *_event=[[CalendarDAO share]fetchEvent:i_eventId];
    thisEvent=[_event retain];
    [location setText:[ProjectTool getLocationFromEvent:thisEvent]];
    NSString *comment=[NSString stringWithFormat:@"%@%@",AMLocalizedString(@"comment", nil),thisEvent.notes];
    [note setText:comment];
    
    NSString *formatString1=[NSString stringWithFormat:@"yyyy%@MM%@dd%@ aHH:mm",AMLocalizedString(@"year", nil),AMLocalizedString(@"month", nil),AMLocalizedString(@"day", nil)];
    NSDateFormatter *formatter1=[NSDateFormatter getFormatterByFormateString:formatString1];
    
    [startTime setText:[formatter1 stringFromDate:_event.startDate]];
    [endTime setText:[formatter1 stringFromDate:_event.endDate]];
}
-(void)constructTitlePages{
    if([_eventsId count]>1){ //有多個
        [titleScrollView setFrame:CGRectMake(titleScrollView.frame.origin.x, titleScrollView.frame.origin.y, titleScrollView.frame.size.width,15)];
        titleScrollView.scrollEnabled=YES;
        pageControl.hidden=NO;
        pageControl.numberOfPages=[_eventsId count];
        pageControl.currentPage=0;
    }else{
        [titleScrollView setFrame:CGRectMake(titleScrollView.frame.origin.x, titleScrollView.frame.origin.y, titleScrollView.frame.size.width,30)];
        titleScrollView.scrollEnabled=NO;
        pageControl.hidden=YES;
    }
    NSInteger count=0;
    CGRect rect=titleScrollView.frame;
    for(NSString *eventId in _eventsId){
        EKEvent *event=[[CalendarDAO share] fetchEvent:eventId];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:rect];
        [titleLabel setText:event.title];
        [titleLabel setFont:[UIFont fontWithName:DefaultFontName size:15.0f]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setTextAlignment:UITextAlignmentCenter];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFrame:CGRectMake(count*titleLabel.frame.size.width, 0, titleLabel.frame.size.width, titleLabel.frame.size.height)];
        [titleScrollView addSubview:titleLabel];
        count++;
    }
    [titleScrollView setContentSize:ccs(count*titleScrollView.frame.size.width, titleScrollView.frame.size.height)];
}
-(IBAction)editAction:(id)sender{
    EKEvent *_tmpEvent=[[CalendarDAO share] fetchEvent:_eventId];
    EventEditViewController *eventEdit=[[EventEditViewController alloc] initWithEvent:_tmpEvent];
    [parentPopView dismissPopoverAnimated:YES];
    [parentView addSubview:eventEdit.view];
}

#pragma mark - DelegateMethod
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (pageControlUsed){
        [self changePage:nil];
        return;
    }
    CGFloat pageWidth = titleScrollView.frame.size.width;
    int page = floor((titleScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate==YES)
        pageControlUsed=YES;
    else
        [self changePage:nil];
}

- (IBAction)changePage:(id)sender{
    [titleScrollView scrollRectToVisible:CGRectMake(titleScrollView.frame.size.width*pageControl.currentPage, 0, titleScrollView.frame.size.width, titleScrollView.frame.size.height) animated:YES];
    
    [_eventId release];
    _eventId=nil;
    
    NSString *_eventString=[_eventsId objectAtIndex:pageControl.currentPage];
    _eventId=[[NSString stringWithString:_eventString] retain];
    [self constructEventContent:_eventString];
}
@end
