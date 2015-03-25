//
//  HelloWorldScene.mm
//  Box2DDemo
//
//  Created by 廖 晨志 on 2011/3/9.
//  Copyright foxconn 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldScene.h"

//How many points for 1 meter.
#define PTM_RATIO 32

//using accelerometer?
//#define IS_USING_ACCELEROMETER 0x000001
// enums that will be used as tags
enum {
	kTagTileMap = 1,
	kTagBatchNode = 1,
	kTagAnimation1 = 1,
};


// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	CCScene *scene = [CCScene node];
	HelloWorld *layer = [HelloWorld node];
	[scene addChild: layer];
	return scene;
}

// initialize your instance here
-(id) init
{
	if( (self=[super init])) {
		
		// enable touches
		self.isTouchEnabled = YES;
		
		// enable accelerometer
		self.isAccelerometerEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
		
		// Define the gravity vector.
		b2Vec2 gravity;
		gravity.Set(0.0f,0.0f);
		
		bool doSleep = true;
		
		world = new b2World(gravity, doSleep);

		world->SetContinuousPhysics(true);
		
		// Debug Draw functions
		m_debugDraw = new GLESDebugDraw( PTM_RATIO );
		world->SetDebugDraw(m_debugDraw);
		
		uint32 flags = 0;
		flags += b2DebugDraw::e_shapeBit;

		m_debugDraw->SetFlags(flags);		
		
		
		// Define the ground body.
		b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0); // bottom-left corner
		
		m_groundBody = world->CreateBody(&groundBodyDef);
		
		// Define the ground box shape.
		b2PolygonShape groundBox;		
		
		// bottom
		groundBox.SetAsEdge(b2Vec2(0,0), b2Vec2(screenSize.width/PTM_RATIO,0));
		m_groundBody->CreateFixture(&groundBox,0);
		
		// top
		groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
		m_groundBody->CreateFixture(&groundBox,0);
		
		// left
		groundBox.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
		m_groundBody->CreateFixture(&groundBox,0);
		
		// right
		groundBox.SetAsEdge(b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,0));
		m_groundBody->CreateFixture(&groundBox,0);

		
		//Set up sprite
		mySpaceLayer=[CCLayer node];
		[self addChild:mySpaceLayer z:0 tag:kTagBatchNode];
		
		for(int i=0;i<5;i++){
			[self addCircleSprite];
		}
		//[self addNewSpriteWithCoords:ccp(screenSize.width/2, screenSize.height/2)];
		[self createBlackHole];
		[self schedule: @selector(tick:)];
	}
	return self;
}

-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);

}
-(void)createBlackHole
{
    b2BodyDef blackHoleDef;
    blackHoleDef.position.Set(240.0f/PTM_RATIO,160.0f/PTM_RATIO);
    m_bhPoint=b2Vec2(240.0f/PTM_RATIO, 160.0f/PTM_RATIO);
    blackHoleDef.type=b2_staticBody;
    blackHoleDef.userData=NULL;
    
    b2Body* m_blackHole=world->CreateBody(&blackHoleDef);
    b2CircleShape blackHoleCircle;
    blackHoleCircle.m_radius=96.0f/PTM_RATIO;
    
    b2FixtureDef bhFixtureDef;
    bhFixtureDef.shape=&blackHoleCircle;
    bhFixtureDef.density = 1.0f;
	bhFixtureDef.friction = 0.6f;
	bhFixtureDef.restitution=0.6f;
	m_blackHole->CreateFixture(&bhFixtureDef);
}

-(void) addCircleSprite
{
	CGPoint initPoint=ccp(200,160);
	int rnd=arc4random()%5+1;
	CCSprite *sprite=[CCSprite spriteWithFile:[NSString stringWithFormat:@"ball%d.png",rnd]];
	CCLayer *thisLayer=(CCLayer*)[self getChildByTag:kTagBatchNode];
	[thisLayer addChild:sprite];
	sprite.position=initPoint;
	
	b2BodyDef bodyDef;
	bodyDef.type=b2_dynamicBody;
	bodyDef.position.Set(initPoint.x/PTM_RATIO,initPoint.y/PTM_RATIO);
	bodyDef.userData=sprite;

	b2Body *body=world->CreateBody(&bodyDef);
	b2CircleShape dynamicBox;
	dynamicBox.m_radius=20.5f/PTM_RATIO;
	
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.6f;
	fixtureDef.restitution=0.6f;
	body->CreateFixture(&fixtureDef);
}
-(void)implementBlackHoleImpluse:(b2Body*)body{
    b2Vec2 bhPosition=m_bhPoint;
    b2Vec2 bodyPosition=body->GetPosition();
    
    b2Vec2 d=bhPosition-bodyPosition;
    if(d.LengthSquared()<b2_epsilon*b2_epsilon) return;
    d.Normalize();
    b2Vec2 force=15.0f*d;
    body->ApplyForce(force,bodyPosition);
}
-(void) tick: (ccTime) dt
{
	
	int32 velocityIterations = 16;
	int32 positionIterations = 4;

	world->Step(dt, velocityIterations, positionIterations);

	
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            [self implementBlackHoleImpluse:b];
		}	
		
	}
}
- (void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	//Add a new body/atlas sprite at the touched location
	
	for(UITouch *touch in touches){
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		[self MouseDown:CGPointMake(location.x/PTM_RATIO, location.y/PTM_RATIO)];
	}
}
- (void)ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	for(UITouch *touch in touches){
		CGPoint touchLocation=[touch locationInView:[touch view]];
		touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
		CGPoint nodePosition = [self convertToNodeSpace: touchLocation];
		[self MouseMove:CGPointMake(nodePosition.x/PTM_RATIO, nodePosition.y/PTM_RATIO)];
		break;
	}
}
- (void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	for(UITouch *touch in touches){
		CGPoint touchLocation=[touch locationInView:[touch view]];
		touchLocation=[[CCDirector sharedDirector] convertToGL:touchLocation];
		CGPoint nodePosition = [self convertToNodeSpace: touchLocation];
		[self MouseUp:CGPointMake(nodePosition.x/PTM_RATIO, nodePosition.y/PTM_RATIO)];
		break;
	}
}

#ifdef IS_USING_ACCELEROMETER
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	b2Vec2 gravity( -accelY * 10, accelX * 10);
	
	world->SetGravity( gravity );
}
#endif
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	delete world;
	world = NULL;
	
	delete m_debugDraw;

	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void)MouseDown:(CGPoint)point{
	
	b2Vec2 p=b2Vec2(point.x,point.y);
	
	m_mouseWorld = p;
	
	if (m_mouseJoint != NULL)
	{
		return;
	}
	// Make a small box.
	b2AABB aabb;
	b2Vec2 d;
	d.Set(0.001f, 0.001f);
	aabb.lowerBound = p - d;
	aabb.upperBound = p + d;
	
	// Query the world for overlapping shapes.
	QueryCallback callback(p);
	world->QueryAABB(&callback, aabb);
	
	if (callback.m_fixture)
	{
		b2Body* body = callback.m_fixture->GetBody();
		b2MouseJointDef md;
		md.bodyA = m_groundBody;
		md.bodyB = body;
		md.target = p;
		md.maxForce = 1000.0f * body->GetMass();
		
		m_mouseJoint = (b2MouseJoint*)world->CreateJoint(&md);
		body->SetAwake(true);
	}
}

-(void)MouseUp:(CGPoint)point{
	b2Vec2 p=b2Vec2(point.x,point.y);
	if (m_mouseJoint)
	{
		world->DestroyJoint(m_mouseJoint);
		m_mouseJoint = NULL;
        
        // Make a small box.
        b2AABB aabb;
        b2Vec2 d;
        d.Set(0.001f, 0.001f);
        aabb.lowerBound = p - d;
        aabb.upperBound = p + d;
        
        QueryCallback callback(p);
        world->QueryAABB(&callback, aabb);
        
        if (callback.m_fixture)
        {
            b2Body* body = callback.m_fixture->GetBody();
            [self implementBlackHoleImpluse:body];
        }
	}
    /*
    for(b2Contact* c=world->GetContactList();c;c=c->GetNext()){
        b2Body* bodyA=c->GetFixtureA()->GetBody();
        b2Body* bodyB=c->GetFixtureB()->GetBody();
    }
     */
	
}

-(void)MouseMove:(CGPoint)point{
	b2Vec2 p=b2Vec2(point.x,point.y);
	m_mouseWorld = p;
	
	if (m_mouseJoint)
	{
		m_mouseJoint->SetTarget(p);
	}
}
@end
