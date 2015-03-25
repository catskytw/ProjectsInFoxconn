//
//  TrainStationObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrainStationObject : NSObject {
	//站點種類,start,normal,end
	NSString  *stationLinePic;
	//選取的行經範圍是否有經過本站點
	NSString *stationPassPic;
	//站名
	NSString *stationName;
	//抵達時間
	NSString *arrivedTime;
	
	NSString *stationId;
}
@property(nonatomic,retain) NSString *stationPassPic;
@property(nonatomic,retain) NSString *stationLinePic; 
@property(nonatomic,retain) NSString *stationName;
@property(nonatomic,retain) NSString *arrivedTime;
@property(nonatomic,retain) NSString *stationId;
-(id)initWithStationName:(NSString*)station withArrivedTime:(NSString*)arriving withStationLine:(NSString*)linePic withStationPass:(NSString*)passPic withStationId:(NSString*)thisStationId;
@end
