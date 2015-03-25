//
//  SignInObject.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignInObject.h"


@implementation SignInObject
@synthesize sessionId,memberId,account,password,name,isLogin,address,birthday,code,cityName,email,habit,marryStatus,mobile,postCode,provinceName,sex,storeId,storeName,sectionName,workIncome,workJob,phone,isMember;
static SignInObject *instance=nil;
-(id)init{
    if((self=[super init])){
        isLogin=NO;
        sessionId=account=password=name=address=birthday=code=cityName=email=habit=marryStatus=mobile=postCode=provinceName=sex=storeId=storeName=sectionName=workIncome=workJob=phone=@"";
    }
    return self;
}
+(SignInObject*)share{
    if(instance==nil){
        instance=[[SignInObject alloc]init];
    }
    return instance;
}
+(void)SignInRelease{
    if(instance!=nil){
        [instance release];
        instance=nil;
    }
}
@end
