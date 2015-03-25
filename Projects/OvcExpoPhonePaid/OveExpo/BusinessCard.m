//
//  BusinessCard.m
//  OveExpo
//
//  Created by  on 11/9/27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard.h"

@implementation BusinessCard
@synthesize
cardId,
//個人資料
userId,
image,//大頭照
nickName,
firstName,//姓
lastName,//名
fullName,//全名
sex,//性別[1)男/, 2)女]
title,//职业/职位, jobTitle
department,//部門
mobilePhone_num,//行動電話
email,
photo_url,//

//公司資料
companyId,//公司Id
company,//公司名稱
countryId,//國家id
countryName,
province,//省份(自己填)
city,//城市(自己填)
zip,//郵編
company_addr,//公司地址
phone_num,//電話
fax_num,//傳真機
url//公司網址
;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
@end
