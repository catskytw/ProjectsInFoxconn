//
//  DataModel.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "DataModel.h"
#import "PresidentParameters.h"
#import "ManagerPriceParameters.h"
#import "FirstPriceParameters.h"
static NSMutableDictionary *priceParameters;
@implementation DataModel
+(NSMutableDictionary*)getPriceParameters{
	if(priceParameters==nil){
		priceParameters=[[NSMutableDictionary dictionary]retain];
		[priceParameters setValue:[PresidentParameters new] forKey:@"PresidentPrice"];
		[priceParameters setValue:[ManagerPriceParameters new] forKey:@"ManagerPrice"];
		[priceParameters setValue:[FirstPriceParameters new] forKey:@"FirstPrice"];
	}
	return priceParameters;
}

+(void)destoryPriceParameters{
	if(priceParameters!=nil)
		[priceParameters release];
}

@end
