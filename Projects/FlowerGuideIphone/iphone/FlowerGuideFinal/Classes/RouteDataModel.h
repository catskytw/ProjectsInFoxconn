//
//  DataModel.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Edge.h"
#import "Queue.h"

@interface RouteDataModel : NSObject {
}
+(NSMutableArray*)getAllData;
+(NSMutableArray*)constructLink:(Edge*)goalEdge;
+(void)printGoalEdge:(NSMutableArray*)linkEdges;
+(NSMutableArray*)removeDuplicationEdge:(NSMutableArray*)edgeArray;
@end
