//
//  AreaListObject.h
//  FlowerGuide
//
//  Created by Liao Change on 9/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AreaListObject : NSObject {
	NSString *areaId;
	NSString *name;
	NSInteger x,y,exhibitId;
}
@property(nonatomic,retain)NSString *areaId;
@property(nonatomic,retain)NSString *name;
@property(nonatomic)NSInteger x,y,exhibitId;
@end
