//
//  QRCodeSingletonObject.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeSingletonObject : NSObject{
    NSInteger functionType;
}
@property(nonatomic)NSInteger functionType;
+(QRCodeSingletonObject*)current;
+(void)releaseSingleton;
-(NSString*)getExhibitorIdFromQRCode:(NSString*)_uuid;
-(NSString*)addFriendNameCard:(NSString*)_uuid;
@end
