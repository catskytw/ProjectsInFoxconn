//
//  ExhibitorEventDatoObject.h
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitorEventDatoObject : NSObject{
    NSString* title;
    NSString* attender;
    NSString* status;
    NSString* eventId;
    NSString* mobile;
    BOOL bAdmited;
}
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* attender;
@property (nonatomic, retain) NSString* eventId;
@property (nonatomic, retain) NSString* mobile;
@property (nonatomic, retain) NSString* status;
@property (assign) BOOL bAdmited;
@end
