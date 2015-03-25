//
//  MapSettingDataObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapSettingDataObject.h"


@implementation MapSettingDataObject
@synthesize distance,mapSettingType,settingArray;

-(void)dealloc{
	[settingArray release];
	[super dealloc];
}
@end
