//
//  MapPresentCtrl.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapDataCtrl.h"
#import "MapIdxCtrl.h"
#import "Transformer.h"
@interface MapPresentCtrl : NSObject {
	MapDataCtrl *dataCtrl;
	MapIdxCtrl *idxCtrl;
	Transformer *t;
	CGRect worldRect;
	NSInteger width;
	NSInteger height;
	BOOL flag3D;
}
@property(nonatomic,assign)MapIdxCtrl *idxCtrl;
-(id)initWithMapDataCtrl:(MapDataCtrl*)thisDataCtrl withMapIdxCtrl:(MapIdxCtrl*)thisIdxCtrl withWorldRect:(CGRect)thisWorldRect withMonitorWidth:(NSInteger)thisWidth withMonitorHeight:(NSInteger)thisHeight is3D:(BOOL)is3D;
-(NSMutableArray*)getAllFeatureAfterTransform:(NSInteger)featureType;
-(void)transFormFeature:(MapFeature*)inputFeature;

@end
