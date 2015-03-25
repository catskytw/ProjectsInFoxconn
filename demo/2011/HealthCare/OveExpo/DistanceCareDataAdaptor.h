//
//  DistanceCareDataAdaptor.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DistanceCareDataObject;
@protocol DistanceCareDataAdaptorProtocol <NSObject>
@required
-(DistanceCareDataObject*)fetchDistanceCareData;
@end
@interface DistanceCareDataAdaptor : NSObject <DistanceCareDataAdaptorProtocol>

@end
