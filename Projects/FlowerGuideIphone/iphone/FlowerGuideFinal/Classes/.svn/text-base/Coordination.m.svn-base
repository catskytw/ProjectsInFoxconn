//
//  Coordination.m
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 12/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Coordination.h"

@implementation Coordination
@synthesize x;
@synthesize y;
-(id)init:(CGPoint)iphoneXY{
	//特別注意,要轉換y
	if((self=[super init])){
		x=iphoneXY.x;
		//33為上方系統列之高度
		y=480-33-iphoneXY.y;
	}
	return self;
}

-(id)initWithXY:(NSInteger)inputX withY:(NSInteger)inputY{
	if((self=[super init])){
		x=inputX;
		y=inputY;
	}
	return self;
}
@end
