//
//  ExhibitorAddBookingListDataObject.h
//  OveExpo
//
//  Created by Chang Link on 11/9/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitorAddBookingListDataObject : NSObject{
    NSString *title;
    NSString *note;
    NSString *reserveId;
    NSString *startDate;
    NSString *endDate;
}
@property (nonatomic, retain) NSString* reserveId;
@property (nonatomic, retain) NSString* startDate;
@property (nonatomic, retain) NSString* endDate;
@property (nonatomic, retain) NSString* note;
@property (nonatomic, retain) NSString* title;
@end
