//
//  MyLifeDescriptionObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeDescriptionObject.h"


@implementation MyLifeDescriptionObject
@synthesize categoryName,storeName,storePicName,introduction,address,telephone,discountKey,fax,hour_open,hour_close,day_off,web,email;
@synthesize payment,parking,indoor_navi,wifi,pet_allow;
-(void)dealloc{
	/*
	 *fax,*hour_open,*hour_close,*day_off,*web,*email
	 */
	[fax release];
	[hour_open release];
	[hour_close release];
	[day_off release];
	[web release];
	[email release];
	[categoryName release];
	[storeName release];
	[storePicName release];
	[introduction release];
	[address release];
	[telephone release];
	[discountKey release];
	[super dealloc];
}
@end
