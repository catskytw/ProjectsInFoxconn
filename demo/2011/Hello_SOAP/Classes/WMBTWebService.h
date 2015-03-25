//
//  WMBTWebService.h
//  WMBTWebServiceLib
//
//  Created by 廖 晨志 on 2011/6/9.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WMBTWebService : NSObject {
@public
    NSDictionary *resultDic;
@private
    NSMutableData *webData;
    NSString *_notificationName;
}
@property(nonatomic,retain)NSDictionary *resultDic;
-(id)initWithNotificationName:(NSString*)notificationName;
-(BOOL)createAdvance:(NSArray*)advanceProdDtlModelArray withCpy:(NSString*)cpyId withMember:(NSString*)memberId;
@end
