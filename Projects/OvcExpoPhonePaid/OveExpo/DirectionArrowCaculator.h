//
//  DirectionArrowCaculator.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DirectionArrowCaculator : NSObject {
	NSMutableArray *directionArrowPoint;
	double sinValue,cosValue;
	int categoryAngle;
}
@property(nonatomic,retain)NSMutableArray *directionArrowPoint;
-(id)initWithRadius:(float)radius;
-(NSDictionary*)searchFeaturePointInArea:(CGRect)searchingRect withStandingPoint:(CGPoint)basePoint;
-(double)caculateAngle:(CGPoint)basePoint withPurposePoint:(CGPoint)purposePoint;
@end
