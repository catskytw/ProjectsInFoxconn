//
//  MapDataCtrl.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapRegion.h"
#import "MapFeature.h"
#import "MapPoint.h"
#import "MapLine.h"
#import "Coordination.h"
#import "Queue.h"
@interface MapDataCtrl : NSObject {
	NSString *path;
	int featureCount;
	NSData *totalData;
}
@property(nonatomic)int featureCount;
-(id)initWithFileName:(NSString*)thisFileName;
/**
 取得feature物件
 */
-(MapFeature*)getFeatureObject:(NSInteger)indexInData withFeatureType:(NSInteger)featureType;
/**
 取得第n筆feature
 */
-(NSData*)getFeatureData:(NSInteger)indexInData;
/**
 取得該feature之name
 */
-(NSString*)getFeatureName:(NSData*)featureNSData withStartPosition:(NSInteger)startPosition withLength:(NSInteger)length;
/**
 取得point點位
 */
-(NSMutableArray*)getPoints:(NSInteger)startPosition withFeatureData:(NSData*)featureData withPointNum:(NSInteger)pointNum;
/**
 取得addInfo
 */
-(NSString*)getAddInfo:(NSData*)featureData withPosition:(NSInteger)startPosition withLength:(NSInteger)length;

@end
