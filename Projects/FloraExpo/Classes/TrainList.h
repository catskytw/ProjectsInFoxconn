//
//  TrainList.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrainList : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	NSMutableDictionary *contentDic;
	NSArray *contentObjectArray;
	
	IBOutlet UILabel *mainViewName;
	IBOutlet UILabel *mainViewDescription;
	
	NSInteger queryType;
	NSString *startId;
	NSString *destId;
	NSInteger durationHr;
	long dateTicks;
}
@property(nonatomic,retain)UILabel *mainViewName;
@property(nonatomic,retain)UILabel *mainViewDescription;
-(id)initWithDataDictionary:(NSDictionary*)datadic withType:(NSInteger)pageType withStartStationId:(NSString*)startStationId withDestStationId:(NSString*)destStationId;
@end
