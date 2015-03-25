//
//  TrainHSListObject.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//提供顯示台鐵與高鐵班次列表之物件

@interface TrainHSListObject : NSObject {
	//
	NSString *trainId;
	NSString *categoryPicName;
	NSString *trainName;
	NSString *briefString;
	NSString *durationString;
}
@property(nonatomic,retain)NSString *trainId;
@property(nonatomic,retain)NSString *categoryPicName;
@property(nonatomic,retain)NSString *trainName;
@property(nonatomic,retain)NSString *briefString;
@property(nonatomic,retain)NSString *durationString;
-(id)initWithTrainName:(NSString*)thisTrainName withCategoryPicName:(NSString*)picName withBrief:(NSString*)brief withDuration:(NSString*)duration;

@end
