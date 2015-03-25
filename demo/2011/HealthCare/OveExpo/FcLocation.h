//
//  FcLocation.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/10.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface FcLocation : NSObject
+(void)setNowLocation:(CLLocation*)_location;
+(CLLocation*)nowLocation;
@end
