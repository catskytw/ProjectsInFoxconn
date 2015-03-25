//
//  BusDescriptionViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusLineDescriptionObject.h"
#import "MyFavoriteBusObject.h"
@interface BusDescriptionViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
	BusLineDescriptionObject *thisBusDescription;
	MyFavoriteBusObject *selectedMyFavoriteBusObject;
	
	IBOutlet UISegmentedControl *leaveModeSeg;
	IBOutlet UILabel *busLineName;
	IBOutlet UILabel *busScheduleString;
	IBOutlet UIImageView *busCategoryImageView;
	IBOutlet UITableView *thisContentTable;
	IBOutlet UIButton *actionButton;
	NSInteger thisQueryType;
	NSString *queryKey;
	BOOL isLeave;
	NSIndexPath *selectedIndexPath;
}
@property(nonatomic,retain)UISegmentedControl *leaveModeSeg;
@property(nonatomic,retain)UILabel *busLineName;
@property(nonatomic,retain)UILabel *busScheduleString;
@property(nonatomic,retain)UIImageView *busCategoryImageView;
@property(nonatomic,retain)UITableView *thisContentTable;
@property(nonatomic,retain)UIButton *actionButton;
-(id)initWithDataObject:(BusLineDescriptionObject*)thisDataObject;
-(void)showRightBarButtonItem:(BOOL)isShow;
-(void)setDescriptionValue;
-(IBAction)changeDeparture:(id)sender;	
-(IBAction)clickActionButton:(id)sender;
@end
