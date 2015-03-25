//
//  MoveController.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MoveController.h"
#import "FeatureCtrlCollections.h"
#import "Edge.h"
#import "Vars.h"
/**
 負責將做完shortest path返回之ArrayList<Edge>做切割
 使之可以形成世界框移動之點位陣列
 */
@implementation MoveController
-(NSMutableArray*)caculateMovePoints:(NSMutableArray*)edgeArray{
	//起始
	BOOL isFetchStartPoint=YES;
	NSMutableArray *resultArray=[NSMutableArray arrayWithObjects:nil];
	MapDataCtrl *routeDataCtrl=[FeatureCtrlCollections current].routeDataCtrl;
	MapDataCtrl *pointDataCtrl=[FeatureCtrlCollections current].pointDataCtrl;
	NSArray *examArray;
	for(Edge *eachEdge in edgeArray){
		NSInteger startValue=[eachEdge.startPoint intValue];
		NSInteger endValue=[eachEdge.endPoint intValue];
		NSInteger edgeValue=[eachEdge.edgeName intValue];
		MapFeature *startPoint=(MapFeature*)[pointDataCtrl getFeatureObject:startValue withFeatureType:FeatureTypePoint];
		MapFeature *endPoint=(MapFeature*)[pointDataCtrl getFeatureObject:endValue withFeatureType:FeatureTypePoint];
		MapFeature *route=(MapFeature*)[routeDataCtrl getFeatureObject:edgeValue withFeatureType:FeatureTypeLine];
		
		CGPoint startPointLocation=[[startPoint.points objectAtIndex:0]CGPointValue];
		//僅取一次,將起始點放入回傳之陣列中
		if(isFetchStartPoint){
			isFetchStartPoint=NO;
			
			FeatureCoordination *startSearchingPoint=[[[FeatureCoordination alloc]initWithXY:startPointLocation.x withY:startPointLocation.y]autorelease];
			startSearchingPoint.featureId=startPoint.featureId;
			[resultArray addObject:startSearchingPoint];
		}
		CGPoint routeStartPoint=[[route.points objectAtIndex:0]CGPointValue];
		//判斷是否需要反轉
		if(!(startPointLocation.x==routeStartPoint.x && startPointLocation.y==routeStartPoint.y))
			examArray=[[route.points reverseObjectEnumerator] allObjects];
		else
			examArray=route.points;

		NSString *pointsString=@"";
		for(int i=0;i<[examArray count]-1;i++){
			CGPoint examStartPoint=[[examArray objectAtIndex:i]CGPointValue];
			CGPoint examEndPoint=[[examArray objectAtIndex:i+1]CGPointValue];
			pointsString=[pointsString stringByAppendingFormat:@"start[x:%i,y:%i],end[x:%i,y:%i]",examStartPoint.x,examStartPoint.y,examEndPoint.x,examEndPoint.y];

			FeatureCoordination *splitStartPoint=[[[FeatureCoordination alloc]initWithXY:examStartPoint.x withY:examStartPoint.y]autorelease];
			splitStartPoint.featureId=-1;
			FeatureCoordination *splitEndPoint=[[[FeatureCoordination alloc]initWithXY:examEndPoint.x withY:examEndPoint.y]autorelease];
			//是否最後一組
			splitEndPoint.featureId=(i==([examArray count]-2))?endPoint.featureId:-1;
			[resultArray addObjectsFromArray:[self caculateExtendXYWithStartpoint:splitStartPoint withEndPoint:splitEndPoint]];
		}
	}
	return resultArray;
}
/**
 將每段直線段切分,得知每斷點之xy
 */
-(NSMutableArray*)caculateExtendXYWithStartpoint:(FeatureCoordination*)startPoint withEndPoint:(FeatureCoordination*)endPoint{
	NSMutableArray *splitPoint=[NSMutableArray arrayWithObjects:nil];
	//在折線上的距離
	const int distance=10;
	//計算邊長
	double mLength=sqrt(pow((startPoint.x-endPoint.x),2)+pow( (startPoint.y-endPoint.y),2));
	int count=ceil(mLength/distance);
	//計算每個間隔
	double eachX=(endPoint.x-startPoint.x)*distance/mLength;
	double eachY=(endPoint.y-startPoint.y)*distance/mLength;
	
	if(count>1){ 
		//startPoint本身不加
		for(int i=1;i<count;i++){
			FeatureCoordination *thisFeaturePoint;
			if(i!=count-1){
				thisFeaturePoint=[[[FeatureCoordination alloc]initWithXY:round(startPoint.x+i*eachX) withY:round(startPoint.y+i*eachY)]autorelease];
				thisFeaturePoint.featureId=-1;
			}else
				thisFeaturePoint=endPoint;
			[splitPoint addObject:thisFeaturePoint];
		}
	}
	return splitPoint;
}
@end
