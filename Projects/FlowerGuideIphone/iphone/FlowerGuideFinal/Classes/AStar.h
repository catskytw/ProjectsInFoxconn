//
//  AStar.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Queue.h"
#import "Edge.h"
#import "RouteDataModel.h"
@interface AStar : NSObject {
	NSMutableArray *allEdges;
	NSMutableArray *leafEdges;
	NSMutableArray *closeEdges;
	NSString *startPoint;
	NSString *endPoint;
	Edge *goalEdge;
}
@property(nonatomic,retain)NSMutableArray *allEdges;
@property(nonatomic,retain)NSMutableArray *leafEdges;
@property(nonatomic,retain)NSMutableArray *closeEdges;
@property(nonatomic,retain)NSString *startPoint;
@property(nonatomic,retain)NSString *endPoint;
@property(nonatomic,retain)Edge *goalEdge;
-(id)initWithStartpoint:(NSString*)thisStartpoint withEndpoint:(NSString*)thisEndpoint;
-(void)initialLeafEdges;
-(NSMutableArray*)runAstar;
-(void)expand:(Edge*)n;
-(BOOL)dominaceRule:(Edge*)n;
-(Edge*)selectHStar;
-(BOOL)hasPass:(Edge*)n;
@end
