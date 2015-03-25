//
//  RegistryOnlineDataObj.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommonDataObject.h"

@interface RegistryOnlineDataObj : CommonDataObject{
    NSArray *times,*doctors;
    NSString *registryCount,*comment;
}
@property(nonatomic,retain)NSArray *times,*doctors;
@property(nonatomic,retain)NSString *registryCount,*comment;
@end
