//
//  RegisterListDataObject.h
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterRecListDataObject : NSObject{
    NSString *recordId;
    NSString *departmentName;
    NSString *doctorName;
    NSString *hospitalName;
    int status;//0 未看診 1 已看診
}
@property (nonatomic, retain) NSString* recordId;
@property (nonatomic, retain) NSString* doctorName;
@property (nonatomic, retain) NSString* hospitalName;
@property (nonatomic, retain) NSString* departmentName;
@property (assign) int status;

@end
