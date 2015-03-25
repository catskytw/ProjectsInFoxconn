//
//  HelloWorldLayer.h
//  TiledmapDemo
//
//  Created by 廖 晨志 on 2011/1/12.
//  Copyright foxconn 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
// HelloWorld Layer
@interface HelloWorld : CCScene <CCTargetedTouchDelegate>
{
	CCTMXTiledMap *_TiledMap;
	CCTMXLayer *_backgroundLayer;
	CCTMXLayer *_meta_Collision;
	
	CCSprite *_player;
	CGPoint spawnPoint;
	CGPoint viewPortPoint;
}
@property(nonatomic,retain)CCTMXTiledMap *_TiledMap;
@property(nonatomic,retain)CCTMXLayer *_backgroundLayer,*_meta_Collision;
// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void)addPlayer;
-(void)setViewpointCenter:(CGPoint)position;
-(BOOL)isCollision:(CGPoint)coordination;
@end
