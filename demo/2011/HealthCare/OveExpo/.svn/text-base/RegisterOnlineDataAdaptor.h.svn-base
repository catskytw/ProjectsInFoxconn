//
//  RegisterOnlineDataAdaptor.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RegistryOnlineDataObj;
@protocol RegisterOnlineDataAdaptorProtocol <NSObject>
@required
-(NSArray*)hospitalList;
-(NSArray*)getDepartmentList:(NSString*)hospitalId;
-(RegistryOnlineDataObj*)getRegistryOnlineData:(NSString*)_queryId;
@end
@interface RegisterOnlineDataAdaptor : NSObject<RegisterOnlineDataAdaptorProtocol>{
    
}

@end
