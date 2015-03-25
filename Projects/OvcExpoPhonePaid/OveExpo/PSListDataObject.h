//
//  PSListDataObject.h
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
// type [M)會議, E)看展, R)預約廠商]
@interface PSListDataObject : NSObject{
    NSString *startTime;
    NSString *endTime;
    NSString *bookingStatus;
    NSString *bookingStatusName;
    NSString *type;
    NSString *targetId;
    NSString *location;
    NSString *name;
    NSString *eventId;
}
@property (nonatomic, retain) NSString *targetId;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *bookingStatus;
@property (nonatomic, retain) NSString *bookingStatusName;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *eventId;
@end
