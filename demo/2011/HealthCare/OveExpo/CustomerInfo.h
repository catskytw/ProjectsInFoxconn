//
//  BusinessCard.h
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//用戶資料
@interface CustomerInfo : NSObject{
    NSString *userId;
    NSString *firstName;//姓
    NSString *lastName;//名
    NSString *fullName;//全名
    NSString *email;//
    NSString *phoneNum;
    NSString *address;
    NSString *emergencyContact;//緊急聯絡人
    NSString *note;//緊急聯絡人
}
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *phoneNum;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *emergencyContact;
@property (nonatomic, retain) NSString *note;
@end
