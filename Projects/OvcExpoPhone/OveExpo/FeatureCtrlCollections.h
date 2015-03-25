//
//  FeatureCtrlCollections.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapDataCtrl.h"
#import "MapIdxCtrl.h"

@interface FeatureCtrlCollections : NSObject {
    NSInteger whichFloor;
	MapIdxCtrl *regionIdxCtrl;
	MapDataCtrl *regionDataCtrl;
	MapIdxCtrl *pointIdxCtrl;
	MapDataCtrl *pointDataCtrl;
	MapIdxCtrl *routeIdxCtrl;
	MapDataCtrl *routeDataCtrl;
    MapIdxCtrl *locationIdxCtrl;
    MapDataCtrl *locationDataCtrl;
}
@property(nonatomic,retain)MapIdxCtrl *regionIdxCtrl;
@property(nonatomic,retain)MapDataCtrl *regionDataCtrl;
@property(nonatomic,retain)MapIdxCtrl *pointIdxCtrl;
@property(nonatomic,retain)MapDataCtrl *pointDataCtrl;
@property(nonatomic,retain)MapIdxCtrl *routeIdxCtrl;
@property(nonatomic,retain)MapDataCtrl *routeDataCtrl;
@property(nonatomic,retain)MapIdxCtrl *locationIdxCtrl;
@property(nonatomic,retain)MapDataCtrl *locationDataCtrl;
@property(nonatomic)NSInteger whichFloor;
/**
 singleton
 */
+(FeatureCtrlCollections*)current;
/**
 load different map data.
 */
-(void)loadMapData:(NSInteger)MapDataType;
@end