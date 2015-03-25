//
//  FlowerAreaObject.h
//  FlowerGuide
//
//  Created by Liao Change on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FlowerAreaObject : NSObject {
	NSString *bgImageString;
	NSMutableArray *flowerEntity;
}
@property(nonatomic,retain)NSString *bgImageString;
@property(nonatomic,retain)NSMutableArray *flowerEntity;
@end
