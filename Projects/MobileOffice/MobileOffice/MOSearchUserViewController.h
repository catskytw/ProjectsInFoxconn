//
//  MOSearchUserViewController.h
//  MobileOffice
//
//  Created by  on 11/9/8.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOSearchItem.h"
#import "FcTextField.h"
#import "MOSearchType.h"
@protocol MettingScheduleDelegate;

@interface MOSearchUserViewController : UIViewController<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate
>
{
    //For background view
    IBOutlet UIView *backgroundView;
    IBOutlet UIImageView *backgroundView_bk;
    
    //For search view
    IBOutlet UITextField *searchTF;
    IBOutlet UIImageView *searchTF_bk;
    FcTextField *searchTF2;
    IBOutlet UITableView *searchTypeTableView;
    IBOutlet UIImageView *searchTypeTableView_bg;
    IBOutlet UIView *searchView;
    IBOutlet UIScrollView *searchItemsView_scroll;
    IBOutlet UIImageView *searchItemsView_bg;
    IBOutlet UIView *searchItemsView;
    IBOutlet UIPageControl *searchPageCtrl;
    IBOutlet UIScrollView *searchTable_scroll;
    IBOutlet UIImageView *searchTable_scroll_bg;
    UIImageView *searchTableCell_bg;
    int searchTypeIdx;
    //For result view
    IBOutlet UIScrollView *resultItemsView_scroll;
    IBOutlet UIImageView *resultItemsView_bg;
    IBOutlet UIView *resultItemsView;
    IBOutlet UIPageControl *resultPageCtrl;
    
    //For others
    IBOutlet UIButton *resetButton;
    IBOutlet UIButton *closeButton;
    NSMutableDictionary *searchTypes;//Item type is MOSearchType
    //NSMutableDictionary *searchTypeNames;
    NSMutableDictionary *searchItems_selected;
    NSMutableDictionary *searchResultImtes;
    NSMutableDictionary *searchResultImtes_selected;
    NSMutableDictionary *searchResultImtes_Cache;
    NSString *currentType;
    NSString *usingType;
    BOOL pageControlUsed;
    id<MettingScheduleDelegate> delegate;//MettingScheduleDelegate
}
@property(nonatomic,retain) id<MettingScheduleDelegate> delegate; // default is nil. weak reference

-(IBAction)uiReset:(id)sender;
-(IBAction)uiClose:(id)sender;
-(IBAction)uiSearchPageChanged:(id)sender;
-(IBAction)uiResultPageChanged:(id)sender;
- (IBAction)changePage:(id)sender;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - MOLoginDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol MettingScheduleDelegate <NSObject>
/**
 * Sent when a login request is finish.
 * 
 **/
- (void)didAddWorkers:(NSArray *)array;//The element's type is MOSearchResultItem
- (void)didRemoveWorkers:(NSArray *)array;//The element's type is MOSearchResultItem
@end