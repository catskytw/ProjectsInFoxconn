//
//  DistanceCareDataObject.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CommonDataObject.h"

@interface DistanceCareDataObject : CommonDataObject{
    NSString *contentText;
    NSString *phoneNumber;
}
@property(nonatomic,retain)NSString *contentText,*phoneNumber;
@end
