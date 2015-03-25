//
//  CooperatorDataObject.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommonDataObject.h"

@interface CooperatorDataObject : CommonDataObject{
    NSString *phone;
    NSString *address;
    NSString *email;
    NSString *webSite;
}
@property(nonatomic,retain)NSString *phone,*address,*email,*webSite;
@end
