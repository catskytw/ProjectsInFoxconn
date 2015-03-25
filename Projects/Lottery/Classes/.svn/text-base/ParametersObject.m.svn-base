//
//  ParametersObject.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "ParametersObject.h"
#import "NSMutableArray+Queue.h"

@implementation ParametersObject
@synthesize priceName;
@synthesize ticketOfA,ticketOfB,ticketOfC,ticketOfD;
-(id)init{
	if((self=[super init])){
		ticketOfA=[NSMutableArray new];
		ticketOfB=[NSMutableArray new];
		ticketOfC=[NSMutableArray new];
		ticketOfD=[NSMutableArray new];
	}
	return self;
}

-(void)dealloc{
	[ticketOfA release];
	[ticketOfB release];
	[ticketOfC release];
	[ticketOfD release];
	[super dealloc];
}
@end
