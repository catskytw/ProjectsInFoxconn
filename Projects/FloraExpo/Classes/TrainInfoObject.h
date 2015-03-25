//
//  TrainInfoObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrainInfoObject : NSObject {
	NSString *categoryPic;
	NSString *trainName;
	NSString *trainSchedule;
	NSString *note;
	
	NSString *monPic;
	NSString *tuePic;
	NSString *wedPic;
	NSString *thuPic;
	NSString *friPic;
	NSString *satPic;
	NSString *sunPic;
	
	/*
	 thisObject.monPic=@"trafficui_ic_weekinfo_valid_1.png";
	 thisObject.tuePic=@"trafficui_ic_weekinfo_valid_2.png";
	 thisObject.wedPic=@"trafficui_ic_weekinfo_valid_3.png";
	 thisObject.thuPic=@"trafficui_ic_weekinfo_valid_4.png";
	 thisObject.friPic=@"trafficui_ic_weekinfo_valid_5.png";
	 thisObject.satPic=@"trafficui_ic_weekinfo_valid_6.png";
	 thisObject.sunPic=@"trafficui_ic_weekinfo_null_0.png";
	 */
	NSMutableArray *trainStationArray;
}
@property(nonatomic,retain) NSString *categoryPic;
@property(nonatomic,retain) NSString *trainSchedule;
@property(nonatomic,retain) NSString *trainName;
@property(nonatomic,retain) NSString *note;
@property(nonatomic,retain) NSString *monPic;
@property(nonatomic,retain) NSString *tuePic;
@property(nonatomic,retain) NSString *wedPic;
@property(nonatomic,retain) NSString *thuPic;
@property(nonatomic,retain) NSString *friPic;
@property(nonatomic,retain) NSString *satPic;
@property(nonatomic,retain) NSString *sunPic;
@property(nonatomic,retain) NSMutableArray *trainStationArray;
@end
