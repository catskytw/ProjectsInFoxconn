//
//  Edge.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Edge : NSObject {
	Edge *parent;
	int hValue;
	int fValue;
	NSString *startPoint;
	NSString *endPoint;
	NSString *edgeName;
}
@property(nonatomic,assign)Edge *parent;
@property(nonatomic)int hValue;
@property(nonatomic)int fValue;
@property(nonatomic,retain)NSString *startPoint;
@property(nonatomic,retain)NSString *endPoint;
@property(nonatomic,retain)NSString *edgeName;
-(id)initWithStartpoint:(NSString*)thisStartPoint withEndpoint:(NSString*)thisEndpoint withCost:(NSInteger)cost withEdgename:(NSString*)thisEdgename;

@end
