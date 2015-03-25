//
//  Tool.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Tool : NSObject
//把陣列中所有指標均指向nil
+(void)pointNil:(NSArray*)_pointers;

//把pointer指向之物件release並指向nil
+(void)nilRelease:(id)_pointer;

/**讓_targetArray是一個空的mutableArray
 retain count 1,要另外手動release
 */
-(void)contructArray:(NSMutableArray*)_targetArray;

//建立一個UUID
+(NSString *)createUUID;

+(NSString *)getReGeoCode:(CLLocation *)_Location;
+(void)makePhoneCall:(NSString*)phoneNumber;@end
