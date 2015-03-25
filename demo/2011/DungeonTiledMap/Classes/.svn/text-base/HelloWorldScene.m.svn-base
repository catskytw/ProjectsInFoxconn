//
//  HelloWorldLayer.m
//  TiledmapDemo
//
//  Created by 廖 晨志 on 2011/1/12.
//  Copyright foxconn 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"

// HelloWorld implementation
@implementation HelloWorld
@synthesize _backgroundLayer,_meta_Collision;
@synthesize _TiledMap;
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		_TiledMap=[CCTMXTiledMap tiledMapWithTMXFile:@"DungeonISOTiledMap.tmx"];
		_meta_Collision=[_TiledMap layerNamed:@"Collision"];
		_meta_Collision.visible=NO;
		[self addChild:_TiledMap];
		spawnPoint=CGPointMake(14, 14);
		//從spawn點產生sprite
		[self addPlayer];
		[self registerWithTouchDispatcher];
		[self schedule:@selector(repositionSprite:)];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void)addPlayer{
	CCTMXLayer *player=[_TiledMap layerNamed:@"PlayerLayer"];
	CGPoint charPoint=[player positionAt:spawnPoint];
	
	_player = [CCSprite spriteWithFile:@"Man-NE.png"];
	_player.anchorPoint=CGPointZero;
	_player.position = charPoint;
	[self addChild:_player]; 
	[self setViewpointCenter:_player.position];
}

-(void)setViewpointCenter:(CGPoint) position {
	
    CGSize winSize = [[CCDirector sharedDirector] winSize];
	
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (_TiledMap.mapSize.width * _TiledMap.tileSize.width) 
			- winSize.width / 2);
    y = MIN(y, (_TiledMap.mapSize.height * _TiledMap.tileSize.height) 
			- winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
	
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
	[self runAction:[CCMoveTo actionWithDuration:0.25f position:viewPoint]];
	self.position = viewPoint;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self 
													 priority:0 swallowsTouches:YES];
}
-(void) repositionSprite:(ccTime)dt
{
	// tile height is 64x32
	// map size: 30x30
	CGPoint p = [_player positionInPixels];
	[_player setVertexZ: -( (p.y+32) /16) ];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

-(void)setPlayerPosition:(CGPoint)position {
	[_player runAction:[CCMoveTo actionWithDuration:0.25f position:ccp(position.x,position.y)]];
	_player.position = position;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	
    CGPoint touchLocation = [touch locationInView: [touch view]];		
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
	
    CGPoint playerPos = _player.position;
    CGPoint diff = ccpSub(touchLocation,playerPos);
	CGPoint preSpawnPoint;
	[_player removeFromParentAndCleanup:NO];
	if(diff.x>=0 && diff.y>=0){
		_player=[CCSprite spriteWithFile:@"Man-NE.png"];
		preSpawnPoint=CGPointMake(spawnPoint.x, spawnPoint.y-1);
	}else if (diff.x>=0 && diff.y<0) {
		_player=[CCSprite spriteWithFile:@"Man-SE.png"];
		preSpawnPoint=CGPointMake(spawnPoint.x+1, spawnPoint.y);
	}else if (diff.x<0 && diff.y>=0) {
		_player=[CCSprite spriteWithFile:@"Man-NW.png"];
		preSpawnPoint=CGPointMake(spawnPoint.x-1, spawnPoint.y);
	}else if (diff.x<0 && diff.y<0) {
		_player=[CCSprite spriteWithFile:@"Man-SW.png"];
		preSpawnPoint=CGPointMake(spawnPoint.x, spawnPoint.y+1);
	}
	[self addChild:_player];
	_player.anchorPoint=CGPointZero;
	_player.position=playerPos;
	
	if([self isCollision:preSpawnPoint]) return;
	spawnPoint=preSpawnPoint;
	CCTMXLayer *playerLayer=[_TiledMap layerNamed:@"PlayerLayer"];
	playerPos=[playerLayer positionAt:spawnPoint];

	[self setPlayerPosition:playerPos];
	CGRect allowRange=CGRectMake(viewPortPoint.x-120, viewPortPoint.y-80, 240, 160);
	if(!CGRectContainsPoint(allowRange, playerPos)){
		viewPortPoint=_player.position;
		[self setViewpointCenter:_player.position];
	}
}

-(BOOL)isCollision:(CGPoint)coordination{
	BOOL returnFlag=NO;
	CGPoint tileCoord = coordination;
	int tileGid = [_meta_Collision tileGIDAt:tileCoord];
	if (tileGid!=0) {
		NSDictionary *properties = [_TiledMap propertiesForGID:tileGid];
		if (properties) {
			NSString *collision = [properties valueForKey:@"Collidable"];
			if (collision && [collision compare:@"True"] == NSOrderedSame) {
				returnFlag=YES;
			}
		}
	}
	return returnFlag;
}
@end
