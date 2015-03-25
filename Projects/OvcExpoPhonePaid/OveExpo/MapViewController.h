//
//  MapViewController.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureCtrlCollections.h"
#import "MapDrawer.h"
#import "CompanySummaryPopup.h"
#import "FcViewController.h"
#import "MapDAO.h"
#import "PlaceConfirmPopWindow.h"
#import "FcPickerController.h"
@interface MapViewController : FcViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,FcPickerDelegate>{
    IBOutlet UIImageView *mapImageView;
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIButton *_mapPlusBtn;
    IBOutlet UIButton *_mapMinBtn;
    IBOutlet UILabel *_scaleLabel;
    IBOutlet UIView *_contentView;
    IBOutlet UIImageView *_openIndicator;
    IBOutlet UITableView *_schedulesTable;
    IBOutlet UILabel *_recentSchedule;
    FeatureCtrlCollections *featureCtrl;
	MapDrawer *thisMapDrawer;
    
    CADisplayLink *displayLink;
    
    NSMutableArray *allBtns;
    //var in class
    CompanySummaryPopup *pop;
    PlaceConfirmPopWindow *placePop;
    UIButton *bigBtn;
    CGRect eagleMapWorldRect;
    NSInteger viewPortViewWidth;
    NSInteger viewPortViewHeight;
    double scaleRate;
    BOOL isScheduleOpen;
    
    NSInteger nowPosition;
    NSInteger targetPosition;
    NSMutableArray *shortestPathArray;
    NSString *_routeTxt;
    //data in Map
    MapDAO *mapDao;
    FcPickerController *fcPicker;
    NSMutableArray *pointsInLocation;
    NSArray *_schedules;
    NSArray *exhibitorList;
    UIImageView *targetView;
    UIImageView *nowView;
    
    NSInteger pickerSelectedIndex;
}
@property(retain,nonatomic)IBOutlet UIImageView *mapImageView;
@property(retain,nonatomic)IBOutlet UIScrollView *_scrollView;
@property(retain,nonatomic)IBOutlet UIButton *_mapPlusBtn,*_mapMinBtn;
@property(retain,nonatomic)IBOutlet UILabel *_scaleLabel,*_recentSchedule;
@property(retain,nonatomic)IBOutlet UIView *_contentView;
@property(retain,nonatomic)IBOutlet UIImageView *_openIndicator;
@property(retain,nonatomic)IBOutlet UITableView *_schedulesTable;
@property(nonatomic)NSInteger nowPosition,targetPosition;
@property(nonatomic,retain)NSString *_routeTxt;
+(MapViewController*)current;
+(void)releaseSingleton;
-(IBAction)mapPlusAction:(id)sender;
-(IBAction)mapMinAction:(id)sender;
-(IBAction)slideSchedule:(id)sender;
-(void)drawMap;
-(void)caculateShortestPath:(NSInteger)startPoint withEndPoint:(NSInteger)endPoint;
-(void)showExhibitorInfo:(NSString*)locationId isFacility:(BOOL)isFacility;
-(void)settingFloor:(NSInteger)floorType;
-(void)cleanShortestPathItem;
@end
