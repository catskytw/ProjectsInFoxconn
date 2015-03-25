//
//  MOLoginInfo.h
//  MobileOffice
//
//  Created by  on 11/9/17.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOLoginInfo : NSObject
{
    NSString *sessionId;
    NSString *loginId;
}
@property(nonatomic,retain) NSString *sessionId;
@property(nonatomic,retain) NSString *loginId;

@end
