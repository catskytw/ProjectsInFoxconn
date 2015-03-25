//
//  Transformer.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Coordination.h"
#import "Queue.h"
#import "View3DPara.h"
@interface Transformer : NSObject {
	View3DPara *m_cView3DPara;
	CGAffineTransform worldToDevMatrix;
	int sscx;
	int sscy;
}
@property(nonatomic)int sscx;
@property(nonatomic)int sscy;
-(id)initWithWorldRect:(CGRect)worldRect withMonitorWidth:(NSInteger)width withMonitorHeight:(NSInteger)height;
-(void)makeWorldToDevMatrix:(CGRect)worldRect;
/**
 裁切點位是點有超出rect的範圍
 @param:原feature之所有點位
 @param:裁切範圍
 */
-(NSMutableArray*)getClippedPointsForPolygon:(NSMutableArray*)pts withRect:(CGRect)r;
-(NSMutableArray*)getClippedPointsForLines:(NSMutableArray*)pts withRect:(CGRect)r;

/**
 判斷是否與邊的關係
 */
-(NSMutableArray*)checkByAnEdgePoints:(NSMutableArray*)pts withPoint1:(CGPoint)eg1 withPoint2:(CGPoint)eg2 isInside:(BOOL)clippedInside withCheckType:(BOOL)isLine;
-(NSInteger)checkByAnEdge:(CGPoint)pt1 withPt2:(CGPoint)pt2 withEdgePt1:(CGPoint)edgePt1 withEdgePt2:(CGPoint)edgePt2 isInside:(BOOL)clippedInside;
/**
 純粹判斷大小值
 */
-(NSInteger)checkerSub:(NSInteger)p1 withP2:(NSInteger)p2 withChecker:(NSInteger)checker isCheckInside:(BOOL)checkingSide;

-(NSValue*)findIntersectionPoint:(CGPoint)pt1 withPoint2:(CGPoint)pt2 isXAxis:(BOOL)isXAxis withValue:(NSInteger)value;

/**
 轉換所有點位,由world至3D
 */
-(NSMutableArray*)transformPointsTo3D:(NSMutableArray*)pts;
/**
 轉換所有點位,由world至Dev
 */
-(NSMutableArray*)transformPointsToDev:(NSMutableArray*)pts;
/**
 設定3D參數
 */
-(void)set3DPara:(CGPoint)cPt1 withPt2:(CGPoint)cPt2;

/**
 3D座標轉成2D座標
 */
//-(Coordination*)xy3DToDev:(Coordination*)pt;
/**
 2D座標轉成世界座標
 */
//-(Coordination*)xyDevToWorld:(Coordination*)pt;
/**
 3D座標轉成世界座標
 */
//-(Coordination*)xy3DToWorld:(Coordination*)pt;

@end
