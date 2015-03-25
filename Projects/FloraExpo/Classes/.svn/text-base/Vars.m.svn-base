//
//  Vars.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Vars.h"
@implementation Vars

+(CLLocationCoordinate2D)NullPOILocation{
	CLLocationCoordinate2D nullPOILocation;
	nullPOILocation.latitude=0.0f;
	nullPOILocation.longitude=0.0f;
	return nullPOILocation;
}

+(CLLocationCoordinate2D)TaipeiStationLocation{
	CLLocationCoordinate2D a1;
	a1.latitude=25.047703;
	a1.longitude=121.518012;
	return a1;
}

+(CLLocationCoordinate2D)locationWithLat:(double)latitude withLong:(double)longitude{
	CLLocationCoordinate2D a1;
	a1.latitude=latitude;
	a1.longitude=longitude;
	return a1;
}

+(NSString*)emptyOrOriginString:(NSString*)originString{
	return ([originString isEqualToString:@"-"])?@"":originString;
}
@end
