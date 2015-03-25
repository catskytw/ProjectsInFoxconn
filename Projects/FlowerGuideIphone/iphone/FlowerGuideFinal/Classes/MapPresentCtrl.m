//
//  MapPresentCtrl.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPresentCtrl.h"
#import "Vars.h"
#import "FeatureCache.h"
@implementation MapPresentCtrl
@synthesize idxCtrl;
/** 
 1.decie transform
 2.get all idx by worldrect
 3.get all feature
 4.transform their points to 2D/3D coordination.
 5.return the feature array
 */
-(id)initWithMapDataCtrl:(MapDataCtrl*)thisDataCtrl withMapIdxCtrl:(MapIdxCtrl*)thisIdxCtrl withWorldRect:(CGRect)thisWorldRect withMonitorWidth:(NSInteger)thisWidth withMonitorHeight:(NSInteger)thisHeight is3D:(BOOL)is3D{
	if((self=[super init])){
		dataCtrl=thisDataCtrl;
		idxCtrl=thisIdxCtrl;
		width=thisWidth;
		height=thisHeight;
		worldRect=thisWorldRect;
		flag3D=is3D;
		t=[[Transformer alloc]initWithWorldRect:worldRect withMonitorWidth:width withMonitorHeight:height];
		[t makeWorldToDevMatrix:worldRect];
	}
	return self;
}

-(void)dealloc{
	[t release];
	[super dealloc];
}
-(NSMutableArray*)getAllFeatureAfterTransform:(NSInteger)featureType{
	NSMutableArray *allFeatures=[NSMutableArray arrayWithObjects:nil];

	CGPoint worldLeftUp=worldRect.origin;
	CGPoint worldRightBottom=CGPointMake(worldRect.origin.x+worldRect.size.width,worldRect.origin.y+worldRect.size.height);
	NSMutableDictionary *dic=[idxCtrl getAllFeatureIdWithPoint1:worldLeftUp withPoint2:worldRightBottom];
	for(FeatureIdxObject *thisFeatureIdx in [dic allValues]){
		MapFeature *thisFeature=nil;
		if(thisFeature==nil)
			thisFeature=[dataCtrl getFeatureObject:thisFeatureIdx.featureId withFeatureType:featureType];
		
		if(thisFeature!=nil && thisFeature.style==featureType){
			//NSMutableDictionary *cacheDic;
			//[cacheDic setObject:thisFeature forKey:[NSString stringWithFormat:@"%i", thisFeature.featureId]];
			[self transFormFeature:thisFeature];
			[allFeatures addObject:thisFeature];
		}
	}
	return allFeatures;
}

-(void)transFormFeature:(MapFeature*)inputFeature{
	[inputFeature.drawingArray removeAllObjects];
	switch (inputFeature.style) {
		case FeatureTypePoint:
			inputFeature.drawingArray=(flag3D)?
			[t transformPointsTo3D:inputFeature.points]:
			[t transformPointsToDev:inputFeature.points];
			break;
		case FeatureTypeLine:
			inputFeature.drawingArray=(flag3D)?
			[t transformPointsTo3D:[t getClippedPointsForLines:inputFeature.points withRect:worldRect]]:
			[t transformPointsToDev:[t getClippedPointsForLines:inputFeature.points withRect:worldRect]];
			break;
		case FeatureTypeRegion:
			inputFeature.drawingArray=(flag3D)?
			[t transformPointsTo3D:[t getClippedPointsForPolygon:inputFeature.points withRect:worldRect]]:
			[t transformPointsToDev:[t getClippedPointsForPolygon:inputFeature.points withRect:worldRect]];
			break;
	}
}
@end
