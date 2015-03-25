//
//  MyFavoritePark.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyFavoriteParkObject : NSObject {
	NSString *itemId,*parkId,*parkName,*address,*restSpace,*lat,*lon,*icon;
}
@property(nonatomic,retain)NSString *itemId,*parkId,*parkName,*address,*restSpace,*lat,*lon,*icon;
@end
