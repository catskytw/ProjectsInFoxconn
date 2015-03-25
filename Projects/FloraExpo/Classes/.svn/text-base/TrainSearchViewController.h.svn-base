//
//  TrainSearchViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrainSearchViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate>{
	IBOutlet UITextField *startStation;
	IBOutlet UITextField *endStation;
	IBOutlet UITextField *dateTextField;
	IBOutlet UITextField *timeTextField;
	IBOutlet UITextField *timeRangeField;
	IBOutlet UISegmentedControl *trainStyle;
	IBOutlet UISegmentedControl *departureStyle;

	NSDateFormatter *formatter;
	NSInteger timeRange;
	BOOL isDeparture;
	NSInteger carCategory;
}
@property(nonatomic,retain)UITextField *startStation;
@property(nonatomic,retain)UITextField *endStation;
@property(nonatomic,retain)UITextField *dateTextField;
@property(nonatomic,retain)UITextField *timeTextField;
@property(nonatomic,retain)UITextField *timeRangeField;
@property(nonatomic,retain)UISegmentedControl *trainStyle;
@property(nonatomic,retain)UISegmentedControl *departureStyle;
-(IBAction)pickStation:(id)sender;
-(IBAction)pickDateTime:(id)sender;
-(IBAction)addTimeRange:(id)sender;
-(IBAction)reduceTimeRange:(id)sender;

-(IBAction)changeCarCategory:(id)sender;
-(IBAction)changeDeparture:(id)sender;
-(void)updateTimeRange;
@end
