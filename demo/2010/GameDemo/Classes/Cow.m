//
//  Cow.m
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "Cow.h"


@implementation Cow
+(id)newAnimal{
	Cow *instance=[Cow spriteWithFile:@"cow.png"];
	instance.moveDuration=10.0f;
	//instance.anchorPoint=CGPointZero;
	instance.position=ccp(360,310);
	instance.scale=0.5;
	instance.waitWhileInside=3;
	instance.waitWhileOutside=6;
	return instance;
}

-(void)runSettingAnimation{
	id headForward=[CCScaleTo actionWithDuration:0 scaleX:0.5 scaleY:0.5];
	id action=[CCMoveBy actionWithDuration:10 position:ccp(-170,0)];
	id runInside=[CCSpawn actions:headForward,action,nil];
	
	
	id reverseAction=[action reverse];
	id headBk=[CCScaleTo actionWithDuration:0 scaleX:-0.5 scaleY:0.5];
	id runOutside=[CCSpawn actions:reverseAction,headBk,nil];
	

	
	CCAnimation* animation = [CCAnimation animation];
	[animation addFrameWithFilename:@"cow1.png"];
	id wait = [CCAnimate actionWithDuration:self.waitWhileInside animation:animation restoreOriginalFrame:YES];
	id waitcomposite=[CCSpawn actions:wait,[CCDelayTime actionWithDuration:self.waitWhileInside],nil];
	 
	id allAction=[CCRepeatForever actionWithAction:
				   [CCSequence actions:runInside,
					waitcomposite,
					runOutside,
					[CCDelayTime actionWithDuration:waitWhileOutside],
					nil]];
	[self runAction:allAction];
}


@end
