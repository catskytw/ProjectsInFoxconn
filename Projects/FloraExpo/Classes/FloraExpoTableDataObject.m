//
//  FloraExpoTableDataObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FloraExpoTableDataObject.h"
#import "Vars.h"
#import "FloraExpoCell.h"

@implementation FloraExpoTableDataObject
@synthesize sectionArray;
@synthesize title;

/**
 FloraExpoContent=1,
 News=2,
 AboutFlora=3,
 Hotel=4
 */
-(id)initWithTableKey:(NSInteger)tableKey{
	if((self=[super init])){
		thisTableKey=tableKey;
		[self createTitle];
		[self createSection];
	}
	return self;
}

-(NSString*)createTitle{
	NSString *returnString;
	switch (thisTableKey) {
		case FloraExpoContent:
			returnString=AMLocalizedString(@"2010FloraExpo",nil);
			break;
		case News:
			returnString=AMLocalizedString(@"News",nil);
			break;
		case AboutFlora:
			returnString=AMLocalizedString(@"AboutFlora",nil);
			break;
		case HotelArea:
			returnString=AMLocalizedString(@"FloraHotel",nil);
			break;
		default:
			break;
	}
	return returnString;
}

-(void)createSection{
	switch (thisTableKey) {
		case FloraExpoContent:
			break;
		case News:
			break;
		case AboutFlora:
			break;
		case HotelArea:
			break;
		default:
			break;
	}
}
@end
