//
//  Tools.h
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/3.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParametersObject.h"

@interface Tools : NSObject {

}
+(NSString*)caculatePriceString:(ParametersObject*)currentParameters;
+(NSString*)caculateTotalNumberString:(NSDictionary*)dic withParametersObject:(ParametersObject*)currentParameters;
@end
