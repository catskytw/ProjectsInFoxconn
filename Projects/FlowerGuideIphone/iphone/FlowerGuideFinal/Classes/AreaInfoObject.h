//
//  AreaInfoObject.h
//  FlowerGuide
//
//  Created by Liao Change on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AreaInfoObject : NSObject {
	NSString *areaId,*parentAreaId,*title,*picURL;
	NSMutableArray *descList;
}
@property(nonatomic,retain)NSString *areaId,*parentAreaId,*title,*picURL;
@property(nonatomic,retain)NSMutableArray *descList;
@end
