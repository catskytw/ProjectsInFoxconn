//
//  BusSearchCategoryObject.m
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BusSearchCategoryObject.h"


@implementation BusSearchCategoryObject
@synthesize picName;
@synthesize categoryName;
@synthesize categoryId;
-(id)initWithPicname:(NSString*)pic withCategoryName:(NSString*)category withCategoryId:(NSString*)lineId{
	if((self=[super init])){
		picName=[[NSString stringWithFormat:@"%@",pic]retain];
		categoryName=[[NSString stringWithFormat:@"%@",category]retain];
		categoryId=[[NSString stringWithString:lineId]retain];
	}
	return self;
}

-(void)dealloc{
	[picName release];
	[categoryName release];
	[categoryId release];
	[super dealloc];
}
@end
