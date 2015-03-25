//
//  PresidentParameters.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "PresidentParameters.h"
#import "NSMutableArray+Queue.h"
#import "GameConfig.h"
@implementation PresidentParameters
-(id)init{
	if((self=[super init])){
		priceName=PresidentPrcieName;
		[ticketOfA enqueue:[NSNumber numberWithInt:1]];
		[ticketOfA enqueue:[NSNumber numberWithInt:1]];
		[ticketOfA enqueue:[NSNumber numberWithInt:1]];
		
		[ticketOfB enqueue:[NSNumber numberWithInt:1]];
		[ticketOfB enqueue:[NSNumber numberWithInt:1]];
		
		[ticketOfC enqueue:[NSNumber numberWithInt:1]];
		
		[ticketOfD enqueue:[NSNumber numberWithInt:1]];
	}
	return self;
}
@end
