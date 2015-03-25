//
//  DirectionArrowCaculator.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DirectionArrowCaculator.h"
#import "Coordination.h"
#import "MapDataCtrl.h"
#import "FeatureCtrlCollections.h"
#import "Vars.h"
@implementation DirectionArrowCaculator
@synthesize directionArrowPoint;
-(id)initWithRadius:(float)radius{
	if((self=[super init])){
		categoryAngle=8;
		//以45度的情況來判斷
		sinValue=sin(M_PI/4);
		cosValue=cos(M_PI/4);
		
		directionArrowPoint=[NSMutableArray arrayWithObjects:
							 [[[Coordination alloc]initWithXY:round(radius*0) withY:-round(radius*1)]autorelease],
							 [[[Coordination alloc]initWithXY:round(radius*sinValue) withY:-round(radius*cosValue)]autorelease],
							 [[[Coordination alloc]initWithXY:round(radius*1) withY:round(radius*0)]autorelease],
							 [[[Coordination alloc]initWithXY:round(radius*sinValue) withY:round(radius*cosValue)]autorelease],
							 [[[Coordination alloc]initWithXY:round(radius*0) withY:round(radius*1)]autorelease],
							 [[[Coordination alloc]initWithXY:-round(radius*cosValue) withY:round(radius*sinValue)]autorelease],
							 [[[Coordination alloc]initWithXY:-round(radius*1) withY:round(radius*0)]autorelease],
							 [[[Coordination alloc]initWithXY:-round(radius*sinValue) withY:-round(radius*cosValue)]autorelease],
							 nil
							 ];
	}
	return self;
}


-(NSDictionary*)searchFeaturePointInArea:(CGRect)searchingRect withStandingPoint:(CGPoint)basePoint{
	//儲存分屬各不同角度之feature點
	NSMutableDictionary *allFeatureArray=[[NSMutableDictionary alloc]init];
	for(int i=0;i<categoryAngle;i++){
		[allFeatureArray setValue:[NSMutableArray arrayWithObjects:nil] forKey:[NSString stringWithFormat:@"%i",i]];
	}
	MapDataCtrl *pointData=[FeatureCtrlCollections current].pointDataCtrl;
	//總共有幾個feature
	int totalPointFeature=pointData.featureCount;
	for(int i=0;i<totalPointFeature;i++){
		MapFeature *thisFeature=[pointData getFeatureObject:i withFeatureType:FeatureTypePoint];
		MapPoint *thisFeaturePointStyle=(MapPoint*)thisFeature.styleObject;
		Coordination *featurePoint=(Coordination*)[thisFeature.drawingArray objectAtIndex:0];
		if(thisFeaturePointStyle.bmpId>0 && thisFeaturePointStyle.bmpId<4  && CGRectContainsPoint(searchingRect, CGPointMake(featurePoint.x,featurePoint.y))){
			double thisFeatureAngle=[self caculateAngle:basePoint withPurposePoint:CGPointMake(featurePoint.x,featurePoint.y)];
			//正北方是345~15度,因此需校正
			int key=(thisFeatureAngle<22.5f)?0:ceil((thisFeatureAngle-22.5f)/45);
			key=(key==8)?0:key;
			NSMutableArray *purposeArray=[allFeatureArray valueForKey:[NSString stringWithFormat:@"%i",key]];
			[purposeArray addObject:thisFeature];
		}
	}
	return [allFeatureArray autorelease];
}

/**
 取得基準點與比較點,與正北方之夾角
 */
-(double)caculateAngle:(CGPoint)basePoint withPurposePoint:(CGPoint)purposePoint{
	double edgeC=sqrt(pow(basePoint.x-purposePoint.x,2)+pow(basePoint.y-purposePoint.y,2));
	double thisSinValue=labs(purposePoint.x-basePoint.x)/edgeC;
	double angle=asin(thisSinValue)*180/M_PI;
	if(purposePoint.x>=basePoint.x && purposePoint.y>=basePoint.y)
		angle=180-angle;
	else if(purposePoint.x<basePoint.x && purposePoint.y<basePoint.y)
		angle=360-angle;
	else if(purposePoint.x<basePoint.x && purposePoint.y>=basePoint.y)
		angle=180+angle;
	return angle;
}
@end
