//
//  AStar.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AStar.h"


@implementation AStar
@synthesize allEdges;
@synthesize startPoint;
@synthesize endPoint;
@synthesize leafEdges;
@synthesize closeEdges;
@synthesize goalEdge;
-(id)initWithStartpoint:(NSString*)thisStartpoint withEndpoint:(NSString*)thisEndpoint withRouteFileName:(NSString*)inputFileName{
	if((self=[super init])){
		startPoint=[NSString stringWithFormat:@"%@",thisStartpoint];
		endPoint=[NSString stringWithFormat:@"%@",thisEndpoint];
		leafEdges=[NSMutableArray arrayWithObjects:nil];
		closeEdges=[NSMutableArray arrayWithObjects:nil];
        fileName=[[NSString stringWithFormat:@"%@",inputFileName] retain];
		[self initialLeafEdges];
	}
	return self;
}
-(void)dealloc{
    [fileName release];
    [super dealloc];
}
-(void)initialLeafEdges{
	allEdges=[RouteDataModel getAllData:fileName];
	for(Edge *eachEdge in allEdges){
		if([eachEdge.startPoint compare:startPoint]==NSOrderedSame){
			eachEdge.fValue=eachEdge.hValue;
			[leafEdges enqueue:eachEdge];
		}
	}
}
-(NSMutableArray*)runAstar{
	while([leafEdges count]!=0){
		Edge *thisExamEdge=[self selectHStar];
		if([thisExamEdge.endPoint compare:endPoint]==NSOrderedSame){
			goalEdge=thisExamEdge;
			break;
		}
		[self expand:thisExamEdge];
	}
	return [RouteDataModel constructLink:goalEdge];
}

-(void)expand:(Edge*)n{
	[leafEdges removeObject:n];
	[closeEdges enqueue:n];
	for(Edge *eachEdge in allEdges){
		if([eachEdge.startPoint compare:n.endPoint]==NSOrderedSame){
			eachEdge.fValue=n.fValue+eachEdge.hValue;
			if([self dominaceRule:eachEdge])
				eachEdge.parent=n;
		}
	}
}

-(BOOL)dominaceRule:(Edge*)n{
	Edge *inputEdge=n;
	if(![self hasPass:inputEdge]){
		for(int i=0;i<[leafEdges count];i++){
			Edge *eachEdge=[leafEdges objectAtIndex:i];
			if([eachEdge.endPoint compare:n.endPoint]==NSOrderedSame){
				[leafEdges removeObject:eachEdge];
				inputEdge=(eachEdge.fValue>n.fValue)?n:eachEdge;
			}
		}
		[leafEdges enqueue:inputEdge];
		return YES;
	}
	return NO;
}

-(Edge*)selectHStar{
	Edge *selectEdge=nil;
	for(Edge *eachEdge in leafEdges){
		if(selectEdge==nil)
			selectEdge=eachEdge;
		else
			selectEdge=(selectEdge.fValue>eachEdge.fValue)?eachEdge:selectEdge;
	}
	return selectEdge;
}

-(BOOL)hasPass:(Edge*)n{
	for(Edge *eachEdge in closeEdges){
		if([eachEdge.startPoint compare:n.startPoint]==NSOrderedSame &&
		   [eachEdge.endPoint compare:n.endPoint]==NSOrderedSame)
			return YES;
	}
	return NO;
}
@end
