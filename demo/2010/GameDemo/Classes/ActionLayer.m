//
//  ActionLayer.m
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "ActionLayer.h"


@implementation ActionLayer
-(id)init{
	if((self=[super init])){
		cow=[[Cow newAnimal]retain];
	}
	return self;
}
-(void)dealloc{
	[cow release];
	[super dealloc];
}
-(void)onEnter{
	[super onEnter];
	[self addChild:cow];
	[cow runSettingAnimation];
}
@end
