//
//  Animal.h
//  GameDemo
//
//  Created by 廖 晨志 on 2011/1/10.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Animal : CCSprite {
	//the moving time from outside to the destination
	float moveDuration;
	//在螢幕外等候時間
	float waitWhileOutside;
	//螢幕內等候時間
	float waitWhileInside;
}
@property(nonatomic)float moveDuration,waitWhileOutside,waitWhileInside;
+(id)newAnimal;
@end
