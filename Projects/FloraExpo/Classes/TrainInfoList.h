//
//  TrainInfoList.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainInfoObject.h"

@interface TrainInfoList : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView *stationsTableView;
	IBOutlet UIImageView *categoryImageView;
	IBOutlet UILabel *trainName;
	IBOutlet UILabel *trainSchedule;
	IBOutlet UIImageView *monView;
	IBOutlet UIImageView *tueView;
	IBOutlet UIImageView *wedView;
	IBOutlet UIImageView *thuView;
	IBOutlet UIImageView *friView;
	IBOutlet UIImageView *satView;
	IBOutlet UIImageView *sunView;
	IBOutlet UILabel *trainNote;
	TrainInfoObject *thisDataObject;
	//車種字串
	NSString *trainNumberKind;
	
	NSInteger thisQueryType;
}
@property(nonatomic,retain) UITableView *stationsTableView;
@property(nonatomic,retain)UILabel *trainName;
@property(nonatomic,retain)UILabel *trainSchedule;
@property(nonatomic,retain)UIImageView *monView;
@property(nonatomic,retain)UIImageView *tueView;
@property(nonatomic,retain)UIImageView *wedView;
@property(nonatomic,retain)UIImageView *thuView;
@property(nonatomic,retain)UIImageView *friView;
@property(nonatomic,retain)UIImageView *satView;
@property(nonatomic,retain)UIImageView *sunView;
@property(nonatomic,retain)UIImageView *categoryImageView;
@property(nonatomic,retain)NSString *trainNumberKind;
@property(nonatomic,retain)UILabel *trainNote;
-(id)initWithQueryType:(NSInteger)queryType withKey:(NSString*)key withStartStationId:(NSString*)startStationId withDestStationId:(NSString*)destStationId;
@end
