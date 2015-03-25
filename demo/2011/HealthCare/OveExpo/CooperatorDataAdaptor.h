//
//  CooperatorDataAdaptor.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CooperatorDataObject;
@protocol CooperatorDataAdaptorProtocol <NSObject>
@required
-(NSArray*)categoryData; //取得合作機構類別之名單,array type:CommonDataObject 
-(NSArray*)cooperatorsData:(NSString*)_categoryId; //取得合作機構名單,array type:CommonDataObject
-(CooperatorDataObject*)getCooperatorData:(NSString*)_cooperatorId;
@end
@interface CooperatorDataAdaptor : NSObject<CooperatorDataAdaptorProtocol>
@end
