//
//  MyFavoriteBus.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyFavoriteBusObject : NSObject{
	NSString *itemId,*lineName,*stationName,*icon,*busRouteId,*stationId,*lat,*lon,*min,*urgent,*isGo;
}
@property(nonatomic,retain)NSString *itemId,*lineName,*stationName,*icon,*busRouteId,*stationId,*lat,*lon,*min,*urgent,*isGo;
@end
