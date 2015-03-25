//
//  Transformer.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "Transformer.h"
#import "MiscTool.h"

#define FIX_Y_VALUE 0x001
@implementation Transformer
@synthesize sscx;
@synthesize sscy;

-(id)initWithWorldRect:(CGRect)worldRect withMonitorWidth:(NSInteger)width withMonitorHeight:(NSInteger)height{
	if((self=[super init])){
		m_cView3DPara=[[View3DPara alloc]init];
		sscx=width;
		sscy=height;
		[self set3DPara:CGPointMake(0,0) withPt2:CGPointMake(-150,sscy)];
		[self makeWorldToDevMatrix:worldRect];
	}
	return self;
}
-(void)makeWorldToDevMatrix:(CGRect)worldRect{
	double worldOriginX=0.0f;
	double worldOriginY=0.0f;
	double xRate=sscx/worldRect.size.width;
	double yRate=sscy/worldRect.size.height;
	worldToDevMatrix=CGAffineTransformMake(xRate, 0, 0, yRate, (worldOriginX-worldRect.origin.x)*xRate, (worldOriginY-worldRect.origin.y)*yRate);
}
-(void)dealloc{
	[m_cView3DPara release];
	[super dealloc];
}

/*
 josh clip line method
 */
-(NSMutableArray*)getClippedPointsForLines:(NSMutableArray*)pts withRect:(CGRect)r{
	BOOL isLine=YES;
	CGPoint leftUp=CGPointMake(r.origin.x, r.origin.y+r.size.height);
	CGPoint rightUp=CGPointMake(r.origin.x+r.size.width ,r.origin.y+r.size.height);
	CGPoint leftButtom=CGPointMake(r.origin.x,r.origin.y);
	CGPoint rightButtom=CGPointMake(r.origin.x+r.size.width,r.origin.y);
	
	CGPoint headerPoint=[[pts objectAtIndex:0]CGPointValue];
	CGPoint headerPoint2=[[pts objectAtIndex:1]CGPointValue];
	
	NSMutableArray *pts1=[self checkByAnEdgePoints:pts withPoint1:leftUp withPoint2:leftButtom isInside:YES withCheckType:isLine];
	if(pts1==nil || [pts1 count]<2) return nil;
	if(headerPoint2.x==([[pts1 objectAtIndex:0]CGPointValue]).x && headerPoint2.y==([[pts1 objectAtIndex:0]CGPointValue]).y)
		[pts1 insertObject:[NSValue valueWithCGPoint: headerPoint] atIndex:0];

	headerPoint=[[pts1 objectAtIndex:0]CGPointValue];
	headerPoint2=[[pts1 objectAtIndex:1]CGPointValue];
	NSMutableArray *pts2=[self checkByAnEdgePoints:pts1 withPoint1:rightUp withPoint2:rightButtom isInside:NO withCheckType:isLine];
	if(pts2==nil || [pts2 count]<2) return nil;
	if(headerPoint2.x==([[pts2 objectAtIndex:0]CGPointValue]).x && headerPoint2.y==([[pts2 objectAtIndex:0]CGPointValue]).y)
		[pts2 insertObject:[NSValue valueWithCGPoint: headerPoint] atIndex:0];

	NSMutableArray *pts3=[self checkByAnEdgePoints:pts2 withPoint1:leftUp withPoint2:rightUp isInside:NO withCheckType:isLine];
	if(pts3==nil || [pts3 count]<2) return nil;
	if(headerPoint2.x==([[pts3 objectAtIndex:0]CGPointValue]).x && headerPoint2.y==([[pts3 objectAtIndex:0]CGPointValue]).y)
		[pts3 insertObject:[NSValue valueWithCGPoint: headerPoint] atIndex:0];
	
	headerPoint=[[pts3 objectAtIndex:0]CGPointValue];
	headerPoint2=[[pts3 objectAtIndex:1]CGPointValue];
	
	NSMutableArray *pts4=[self checkByAnEdgePoints:pts3 withPoint1:leftButtom withPoint2:rightButtom isInside:YES withCheckType:isLine];
	if(pts4==nil || [pts4 count]==0) return nil;
	if(headerPoint2.x==([[pts4 objectAtIndex:0]CGPointValue]).x && headerPoint2.y==([[pts4 objectAtIndex:0]CGPointValue]).y)
		[pts4 insertObject:[NSValue valueWithCGPoint: headerPoint] atIndex:0];
	
	return [pts4 count]<2 ? nil:pts4;
	
}

-(NSMutableArray*)getClippedPointsForPolygon:(NSMutableArray*)pts withRect:(CGRect)r{
	//polygon, not line
	BOOL isLine=NO;
	CGPoint leftUp=CGPointMake(r.origin.x,r.origin.y+r.size.height);
	CGPoint rightUp=CGPointMake(r.origin.x+r.size.width,r.origin.y+r.size.height);
	CGPoint leftButtom=CGPointMake(r.origin.x,r.origin.y);
	CGPoint rightButtom=CGPointMake(r.origin.x+r.size.width,r.origin.y);
	if([pts count]<=0)
		return nil;
	[pts enqueue:[pts objectAtIndex:0]];
	
	NSMutableArray *pts1=[self checkByAnEdgePoints:pts withPoint1:leftUp withPoint2:leftButtom isInside:YES withCheckType:isLine];
	if(pts1==nil) return nil;
	if(![[pts1 objectAtIndex:0] isEqualToValue:[pts1 objectAtIndex:[pts1 count]-1]]) [pts1 enqueue:[pts1 objectAtIndex:0]];
	
	NSMutableArray *pts2=[self checkByAnEdgePoints:pts1 withPoint1:rightUp withPoint2:rightButtom isInside:NO withCheckType:isLine];
	if(pts2==nil) return nil;
	if(![[pts2 objectAtIndex:0] isEqualToValue:[pts2 objectAtIndex:[pts2 count]-1]]) [pts2 enqueue:[pts2 objectAtIndex:0]];
	
	NSMutableArray *pts3=[self checkByAnEdgePoints:pts2 withPoint1:rightUp withPoint2:leftUp isInside:NO withCheckType:isLine];
	if(pts3==nil) return nil;
	if(![[pts3 objectAtIndex:0] isEqualToValue:[pts3 objectAtIndex:[pts3 count]-1]]) [pts3 enqueue:[pts3 objectAtIndex:0]];

	NSMutableArray *pts4=[self checkByAnEdgePoints:pts3 withPoint1:rightButtom withPoint2:leftButtom isInside:YES withCheckType:isLine];
	return (pts4==nil)?nil:pts4;
}
/**
 判斷補點的準則,line型態稍有不同
 因此帶一個param來判斷是否為line
 */
-(NSMutableArray*)checkByAnEdgePoints:(NSMutableArray*)pts withPoint1:(CGPoint)eg1 withPoint2:(CGPoint)eg2 isInside:(BOOL)clippedInside withCheckType:(BOOL)isLine{
	BOOL isXAxis=eg1.x==eg2.x;
	int v=isXAxis?eg1.x:eg1.y;
	NSMutableArray *newPts=[NSMutableArray arrayWithObjects:nil];
	for(int j=0;j<[pts count]-1;++j){
		NSValue *pt1=[pts objectAtIndex:j];
		NSValue *pt2=[pts objectAtIndex:j+1];
		switch ([self checkByAnEdge:[pt1 CGPointValue] withPt2:[pt2 CGPointValue] withEdgePt1:eg1 withEdgePt2:eg2 isInside:clippedInside]) {
			case 0:
				//if(isLine)
					[newPts addObject:pt1];
				[newPts addObject:pt2];
				break;
			case 1:
				//if(isLine)
					[newPts addObject:pt1];
				[newPts addObject:[self findIntersectionPoint:[pt1 CGPointValue] withPoint2:[pt2 CGPointValue] isXAxis:isXAxis withValue:v]];
				break;
			case 2:
				break;
			case 3:
				[newPts addObject:[self findIntersectionPoint:[pt1 CGPointValue] withPoint2:[pt2 CGPointValue] isXAxis:isXAxis withValue:v]];
				[newPts addObject:pt2];
				break;
			default:
				break;
		}
	}
	return [newPts count]>0?newPts:nil;
}

-(NSInteger)checkByAnEdge:(CGPoint)pt1 withPt2:(CGPoint)pt2 withEdgePt1:(CGPoint)eg1 withEdgePt2:(CGPoint)eg2 isInside:(BOOL)clippedInside{
	return (eg1.x==eg2.x)?[self checkerSub:pt1.x withP2:pt2.x withChecker:eg1.x isCheckInside:clippedInside]:
	[self checkerSub:pt1.y withP2:pt2.y withChecker:eg1.y isCheckInside:clippedInside];

}

-(NSInteger)checkerSub:(NSInteger)p1 withP2:(NSInteger)p2 withChecker:(NSInteger)checker isCheckInside:(BOOL)checkingSide{
	if(p1>=checker && p2>=checker) return checkingSide?0:2;
	else if(p1<checker && p2>=checker) return checkingSide?3:1;
	else if(p1<checker && p2<checker) return checkingSide?2:0;
	else return checkingSide?1:3;
}

-(NSValue*)findIntersectionPoint:(CGPoint)pt1 withPoint2:(CGPoint)pt2 isXAxis:(BOOL)isXAxis withValue:(NSInteger)value{
	CGPoint resultPoint;
	if(isXAxis)
		resultPoint=CGPointMake(value,round((value-pt1.x)/(float)(pt2.x-pt1.x)*(pt2.y-pt1.y)+pt1.y));
	else
		resultPoint=CGPointMake(round(pt2.x-((pt2.y-value)/(float)(pt2.y-pt1.y)*(pt2.x-pt1.x))),value);
	return [NSValue valueWithCGPoint: resultPoint];
}

-(void)set3DPara:(CGPoint)cPt1 withPt2:(CGPoint)cPt2{
	m_cView3DPara.e=cPt1.x;
	m_cView3DPara.f=cPt1.y;
	m_cView3DPara.a=(sscx-2*m_cView3DPara.e)/sscx;
	m_cView3DPara.v=(2*(cPt2.x-cPt1.x)/(sscx*(sscx-2*cPt2.x)));
	m_cView3DPara.b=m_cView3DPara.v*cPt2.x+(cPt2.x-cPt1.x)/sscy;
	m_cView3DPara.d=m_cView3DPara.v*cPt2.y+(cPt2.y-cPt1.y)/sscy;
}
/**
 沒有反轉的dev座標
 */
-(CGPoint)xyWorldToDev:(CGPoint)pt isIphoneYAxis:(BOOL)isIphoneYAxis{
	CGPoint tmpPoint=CGPointApplyAffineTransform(pt,worldToDevMatrix);
	return CGPointMake(tmpPoint.x,(isIphoneYAxis)?sscy-tmpPoint.y:tmpPoint.y);
}
-(CGPoint)xyDevTo3D:(CGPoint)cPt{
	float x=0.0f,y=0.0f;
	float divide=1+m_cView3DPara.v*cPt.y;
	float reDivide=1.0f/divide;
	x=(m_cView3DPara.a*cPt.x+m_cView3DPara.b*cPt.y+m_cView3DPara.e)*reDivide;//  /divide;
	/**
	 FIX_Y_VALUE僅限於在世界框的高與viewPort高度相同時,方可使用
	 */
#ifdef FIX_Y_VALUE
	y=sscy-(m_cView3DPara.d*cPt.y+m_cView3DPara.f)*reDivide;   // /divide;
#else
	y=sscy-cPt.y*reDivide;
#endif
	return CGPointMake(x,y);
}
-(CGPoint)transformWorldTo3D:(CGPoint)pt{
	return [self xyDevTo3D:[self xyWorldToDev:pt isIphoneYAxis:NO]];
}

-(NSMutableArray*)transformPointsTo3D:(NSMutableArray*)pts{
	NSMutableArray *returnArray=[NSMutableArray arrayWithCapacity:[pts count]];
	for(NSValue *originPoint in pts){
		CGPoint transformPoint=[self transformWorldTo3D:[originPoint CGPointValue]];
		[returnArray enqueue:[NSValue valueWithCGPoint:transformPoint]];
	}
	return returnArray;
}
-(NSMutableArray*)transformPointsToDev:(NSMutableArray*)pts{
	NSMutableArray *returnArray=[NSMutableArray arrayWithCapacity:[pts count]];
	for(NSValue *originPoint in pts){
		CGPoint transformPoint=[self xyWorldToDev:[originPoint CGPointValue] isIphoneYAxis:YES];
		[returnArray enqueue:[NSValue valueWithCGPoint:transformPoint]];
	}
	return returnArray;
}

@end
