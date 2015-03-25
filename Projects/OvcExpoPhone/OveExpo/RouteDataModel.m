//
//  DataModel.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RouteDataModel.h"


@implementation RouteDataModel
+(NSMutableArray*)getAllData:(NSString*)routeFileName{
	NSMutableArray *returnData=[NSMutableArray arrayWithObjects:nil];
	NSString *path = routeFileName;
	NSString *fileContents=[NSString stringWithContentsOfFile:path];
	NSArray *lines=[fileContents componentsSeparatedByString:@"\n"];
	for(NSString *line in lines){
		NSArray *comp=[line componentsSeparatedByString:@","];
		if([comp count]<4)
			continue;
		Edge *newEdge=[[Edge alloc]initWithStartpoint:[comp objectAtIndex:0] withEndpoint:[comp objectAtIndex:1] withCost:[(NSString*)[comp objectAtIndex:2] intValue] withEdgename:(NSString*)[comp objectAtIndex:3]];
		[returnData enqueue:newEdge];
		[newEdge release];
	}
	return returnData;
}
+(NSMutableArray*)constructLink:(Edge*)goalEdge{
	NSMutableArray *link=[NSMutableArray arrayWithObjects:nil];
	Edge *linkEdge=goalEdge;
	while(linkEdge!=nil){
		[link enqueue:linkEdge];
		linkEdge=linkEdge.parent;
	}
	NSMutableArray *resultArray=(NSMutableArray*)[[link reverseObjectEnumerator]allObjects];
	return [RouteDataModel removeDuplicationEdge: resultArray];
}
+(NSMutableArray*)removeDuplicationEdge:(NSMutableArray*)edgeArray{
	[edgeArray retain];
	NSMutableArray *deleteArray=[NSMutableArray arrayWithObjects:nil];
	for(int i=0;i<[edgeArray count];i++){
		Edge *thisEdge=(Edge*)[edgeArray objectAtIndex:i];
		for(int j=i+1;j<[edgeArray count];j++){
			Edge *compareEdge=(Edge*)[edgeArray objectAtIndex:j];
			if([thisEdge.edgeName isEqualToString:compareEdge.edgeName]){
				[deleteArray addObject:thisEdge];
				[deleteArray addObject:compareEdge];
			}
		}
	}
	[edgeArray removeObjectsInArray:deleteArray];
	
	//?æ–°è¨ˆç?f,h??	
    int totalLength=0;
	for(int i=0;i<[edgeArray count];i++){
		Edge *thisEdge=(Edge*)[edgeArray objectAtIndex:i];
		totalLength+=thisEdge.hValue;
	}
	for(int i=0;i<[edgeArray count];i++){
		Edge *thisEdge=(Edge*)[edgeArray objectAtIndex:i];
		if(i==0)
			thisEdge.fValue=totalLength;
		else{
			Edge *preEdge=(Edge*)[edgeArray objectAtIndex:i];
			thisEdge.fValue=preEdge.fValue-preEdge.hValue;
		}
	}
	return [edgeArray autorelease];
}
+(void)printGoalEdge:(NSMutableArray*)linkEdges{
	if([linkEdges count]==0){
		NSLog(@"No shortest path!");
	}
	for(Edge *eachEdge in linkEdges){
		NSLog(@"startpoint:%@, endpoint:%@, edgename:%@",eachEdge.startPoint,eachEdge.endPoint,eachEdge.edgeName);
	}
}
@end
