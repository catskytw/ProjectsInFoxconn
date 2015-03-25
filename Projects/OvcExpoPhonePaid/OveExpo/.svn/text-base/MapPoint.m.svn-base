//
//  MapPoint.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint
@synthesize size;
@synthesize bmpId;
@synthesize isIcon;
-(id)initWithColorData:(NSData*)colorData withSize:(NSData*)sizeData withBmpId:(NSData*)bmpIdData withIsIcon:(NSData*)iconData{
	if((self=[super initWithColorData:colorData])){
		size=[MiscTool getIntFromLittleNSData:sizeData];
		bmpId=[MiscTool getIntFromLittleNSData:bmpIdData];
		int a;
		[iconData getBytes:&a range:NSMakeRange(0, 1)];
		isIcon=(a==0)?NO:YES;
	}
	return self;
}

@end
