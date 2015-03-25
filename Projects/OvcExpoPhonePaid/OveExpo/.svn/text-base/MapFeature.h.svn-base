//
//  MapFeature.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapStyle.h"

@interface MapFeature : NSObject
/*
<NSCopying>
 */
{
	NSInteger featureId;
	NSInteger style;
	MapStyle *styleObject;
	NSString *featureName;
	NSMutableArray *points;
	NSString *addInfo;
	NSMutableArray *drawingArray;
	
	//此值用於內容點排序,其餘MapFeature均用不到
	NSInteger yValue;
}
@property(nonatomic)NSInteger featureId;
@property(nonatomic)NSInteger style,yValue;
@property(nonatomic,retain)MapStyle *styleObject;
@property(nonatomic,retain)NSMutableArray *drawingArray;
@property(nonatomic,retain)NSString *featureName;
@property(nonatomic,retain)NSMutableArray *points;
@property(nonatomic,retain)NSString *addInfo;
@end
