//
//  LotteryMainScene.m
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "LotteryMainScene.h"
#import "GameConfig.h"
#import "LuckyGuyListView.h"
#import "NSMutableArray+Queue.h"
#import "Tools.h"
@interface LotteryMainScene(PrivateMethod)
-(void)playAnimation;
-(void)stopAllAnimation;
-(void)invokeLuckyGuyList;
-(void)fallingMenoy:(ccTime)dt;
-(void)addResultView;
-(void)lockMenuAction:(id)sender;
-(void)playRollAnimation;
@end

@implementation LotteryMainScene
#pragma mark LifeCycle
-(id)init{
	if((self=[super init])){
		backgroundLayer=[CCLayer node];
		[self addChild:backgroundLayer z:0];
		rollLayer=[CCLayer node];
		[self addChild:rollLayer z:1];
		animationLayer=[CCLayer node];
		[self addChild:animationLayer z:2];
		priceLayer=[CCLayer node];
		[self addChild:priceLayer z:3];
		
		rollLayer.visible=NO;
		
		settingView=[SettingView new];
		[settingView.view setFrame:CGRectMake(0, -settingViewFoldHeight, settingView.view.frame.size.width, settingView.view.frame.size.height)];
		[[[CCDirector sharedDirector] openGLView] addSubview:settingView.view];
		totalNumLabel=[CCLabelTTF labelWithString:@"" fontName:@"Helvetica-Bold" fontSize:65.0f];
		totalNumLabel.color=ccc3(0, 0, 0);
		rollSprite=[CCSprite spriteWithFile:@"1.png"];
		runningSprite=[CCSprite spriteWithFile:@"ic_people_01.png"];
		lMoneySprite=[CCSprite spriteWithFile:@"ic_money_l.png"];
		mMoneySprite=[CCSprite spriteWithFile:@"ic_money_m.png"];
		sMoneySprite=[CCSprite spriteWithFile:@"ic_money_s.png"];
		lMoneySprite1=[CCSprite spriteWithFile:@"ic_money_l.png"];
		mMoneySprite1=[CCSprite spriteWithFile:@"ic_money_m.png"];
		sMoneySprite1=[CCSprite spriteWithFile:@"ic_money_s.png"];
		
		rollSprite.anchorPoint=CGPointMake(0, 1);
		rollLayer.position=CGPointMake(288, 534);
		totalNumLabel.position=CGPointMake(512, 322);
		runningSprite.anchorPoint=CGPointZero;
		runningSprite.position=CGPointMake(700, 35);
		lMoneySprite.anchorPoint=CGPointZero;
		mMoneySprite.anchorPoint=CGPointZero;
		sMoneySprite.anchorPoint=CGPointZero;
		lMoneySprite.position=CGPointMake(-200, -200);
		mMoneySprite.position=CGPointMake(-200, -200);
		sMoneySprite.position=CGPointMake(-200, -200);
		lMoneySprite1.position=CGPointMake(-200, -200);
		mMoneySprite1.position=CGPointMake(-200, -200);
		sMoneySprite1.position=CGPointMake(-200, -200);
		[animationLayer addChild:lMoneySprite];
		[animationLayer addChild:mMoneySprite];
		[animationLayer addChild:sMoneySprite];
		[animationLayer addChild:lMoneySprite1];
		[animationLayer addChild:mMoneySprite1];
		[animationLayer addChild:sMoneySprite1];
		[animationLayer addChild:runningSprite];
		[rollLayer addChild:rollSprite];
		[self playRollAnimation];
		CCSprite *backgroundSprite=[CCSprite spriteWithFile:@"bg_index.png"];
		backgroundSprite.anchorPoint=CGPointZero;
		backgroundSprite.position=CGPointZero;
		[backgroundLayer addChild:backgroundSprite];
		
		CCMenuItem *lockMenuItem=[CCMenuItemImage itemFromNormalImage:@"btn_lock.png" selectedImage:@"btn_lock.png" target:self selector:@selector(lockMenuAction:)];
		lockMenuItem.anchorPoint=CGPointZero;
		lockMenu=[CCMenu menuWithItems:nil];
		[lockMenu addChild:lockMenuItem];
		lockMenu.anchorPoint=CGPointZero;
		lockMenu.position=CGPointMake(20, 20);
		[animationLayer addChild:lockMenu];
		menu=[CCMenu menuWithItems:nil];
		menu.position=CGPointMake(512, 405);
		[priceLayer addChild:menu];
		[priceLayer addChild:totalNumLabel];
		
		luckyGuysQuery=[QueryPattern new];
		
		isAllowPress=YES;
		isRunningAnimation=NO;
		isLock=YES;
		isQuerying=NO;
		
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePriceName:) name:@"ChangePriceName" object:nil];
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openRoll:) name:@"openRoll" object:nil];
		[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeRoll:) name:@"closeRoll" object:nil];

	}
	return self;
}

-(void)dealloc{
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	[totalNumDic release];
	[settingView release];
	[luckyGuysQuery release];
	[super dealloc];
}
#pragma mark -

#pragma mark DelegateAction
-(void)fetchLotteryData:(NSString*)url{
	NSLog(@"Lottery Data Thread Start!");
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
	[luckyGuysQuery prepareDic:url];
	[self performSelectorOnMainThread:@selector(fetchLotteryDataDone) withObject:nil waitUntilDone:YES];
	[pool drain];
}
-(void)fetchLotteryDataDone{
	NSLog(@"fetchDone");
	isQuerying=NO;
}
-(void)startLotteryAction:(id)sender{
	/* 1.call API for acquiring the lucky guy's info.
	   2.setting the values into UIViewController
	   3.pop up a window which contains the UIViewController's view
	 */
	if(isLock) return;
	if(isRunningAnimation==NO){
		if(isAllowPress==NO) return;
		isAllowPress=NO;
		if([currentParameters.ticketOfA count]==0&&[currentParameters.ticketOfB count]==0&&[currentParameters.ticketOfC count]==0&&[currentParameters.ticketOfD count]==0){
			isAllowPress=YES;
			return;
		}
		NSMutableArray *currentArray;
		NSString *category;
		if([currentParameters.ticketOfD count]!=0){
			currentArray=currentParameters.ticketOfD;
			category=@"D";
		}
		else if([currentParameters.ticketOfC count]!=0){
			currentArray=currentParameters.ticketOfC;
			category=@"C";
		}
		else if([currentParameters.ticketOfB count]!=0){
			currentArray=currentParameters.ticketOfB;
			category=@"B";
		}
		else if([currentParameters.ticketOfA count]!=0){
			currentArray=currentParameters.ticketOfA;
			category=@"A";
		}
		//TODO show result
		NSString *priceString=[Tools caculatePriceString:currentParameters];
		NSNumber *number=(NSNumber*)[currentArray dequeue];
		NSString *numberString=[NSString stringWithFormat:@"%d",[number intValue]];
		isQuerying=YES;
		[NSThread detachNewThreadSelector:@selector(fetchLotteryData:) toTarget:self withObject:searchLotteryList(priceString,category,numberString)];

		//play animation
		[self playAnimation];
		isRunningAnimation=YES;
		if(settingView.isOpen)
			[settingView slideAnimation];
	}else {
		[self schedule:@selector(showLuckyGuyList:) interval:0.2f];
	}
}

-(void)showLuckyGuyList:(ccTime)dt{
	if(isQuerying) return;
	[self unschedule:@selector(showLuckyGuyList:)];
	[self stopAllAnimation];
	[self invokeLuckyGuyList];
}
#pragma mark -

#pragma mark Animation
-(void)playRollAnimation{
	CCAnimation* animation = [CCAnimation animation];
	for( int i=1;i<6;i++){
		NSString *fileName= [NSString stringWithFormat:@"%d.png", i];
		[animation addFrameWithFilename:fileName];
	}
	id run=[CCAnimate actionWithDuration:0.1f animation:animation restoreOriginalFrame:NO];
	id forever=[CCRepeatForever actionWithAction:run];
	[rollSprite runAction:forever];
}
-(void)playAnimation{
	//人物移動
	CCAnimation* animation = [CCAnimation animation];
	for( int i=1;i<6;i++){
		NSString *fileName= [NSString stringWithFormat:@"ic_people_%02d.png", i];
		[animation addFrameWithFilename:fileName];
	}
	id run = [CCAnimate actionWithDuration:0.25f animation:animation restoreOriginalFrame:NO];
	id running=[CCRepeat actionWithAction:run times:6];
	id running1=[CCRepeat actionWithAction:run times:10];
	
	id waypoint1=[CCMoveTo actionWithDuration:1.5f position:CGPointMake(400, 35)];
	id waypoint2=[CCMoveTo actionWithDuration:1.5f position:CGPointMake(600, 35)];
	id waypoint3=[CCMoveTo actionWithDuration:1.5f position:CGPointMake(200, 35)];
	id waypoint4=[CCMoveTo actionWithDuration:2.5f position:CGPointMake(700, 35)];

	id run1=[CCSpawn actions:running,waypoint1,nil];
	id run2=[CCSpawn actions:running,waypoint2,nil];
	id run3=[CCSpawn actions:running,waypoint3,nil];
	id run4=[CCSpawn actions:running1,waypoint4,nil];
	
	id finalAction=[CCRepeatForever actionWithAction:[CCSequence actions: 
					run1,[CCFlipX actionWithFlipX:YES],
					run2,[CCFlipX actionWithFlipX:NO],
					run3,[CCFlipX actionWithFlipX:YES],
					run4,[CCFlipX actionWithFlipX:NO],
					nil]];
	[runningSprite runAction:finalAction];
	
	//金元寶掉落
	[self schedule:@selector(fallingMenoy:) interval:0.1f];
	[[NSNotificationCenter defaultCenter]postNotificationName:@"openRoll" object:nil userInfo:nil];
}
-(void)stopAllAnimation{
	isRunningAnimation=NO;
	[self unschedule:@selector(fallingMenoy:)];
	[runningSprite stopAllActions];
	[lMoneySprite stopAllActions];
	[mMoneySprite stopAllActions];
	[sMoneySprite stopAllActions];
	[lMoneySprite1 stopAllActions];
	[mMoneySprite1 stopAllActions];
	[sMoneySprite1 stopAllActions];
	
	[animationLayer removeChild:runningSprite cleanup:NO];
	runningSprite=[CCSprite spriteWithFile:@"ic_people_01.png"];
	runningSprite.anchorPoint=CGPointZero;
	runningSprite.position=CGPointMake(700, 35);
	[animationLayer addChild:runningSprite];
	lMoneySprite.position=CGPointMake(-200, -200);
	mMoneySprite.position=CGPointMake(-200, -200);
	sMoneySprite.position=CGPointMake(-200, -200);
	lMoneySprite1.position=CGPointMake(-200, -200);
	mMoneySprite1.position=CGPointMake(-200, -200);
	sMoneySprite1.position=CGPointMake(-200, -200);	
	[[NSNotificationCenter defaultCenter]postNotificationName:@"closeRoll" object:nil userInfo:nil];
}
-(void)fallingMenoy:(ccTime)dt{
	int i=arc4random()%6;
	CCSprite *currentSprite;
	CGFloat x=(arc4random()%400)+250.0f;
	CGFloat y=500.0f;
	
	switch (i) {
		case 0:
			currentSprite=lMoneySprite;
			break;
		case 1:
			currentSprite=mMoneySprite;
			break;
		case 2:
			currentSprite=sMoneySprite;
			break;
		case 3:
			currentSprite=lMoneySprite1;
			break;
		case 4:
			currentSprite=mMoneySprite1;
			break;
		case 5:
			currentSprite=sMoneySprite1;
			break;			
	}
	currentSprite.position=CGPointMake(x, y);
	currentSprite.visible=YES;
	id move=[CCMoveTo actionWithDuration:0.5f position:CGPointMake(x, 50)];
	id rotate=[CCRotateBy actionWithDuration:0.5f angle:100+(arc4random()%260)];
	[currentSprite runAction:[CCSpawn actions:move,rotate,nil]];
}
-(void)invokeLuckyGuyList{
	/*
	LuckyGuyListView *luckyGuyList=[LuckyGuyListView new];
	luckyGuyList.currentQuery=luckyGuysQuery;
	//TODO valueBinding
	[[[CCDirector sharedDirector] openGLView] addSubview:luckyGuyList.view];
	 */
	resultLayer=[CCColorLayer layerWithColor:ccc4(0, 0, 0, 128)];
	resultLayer.isTouchEnabled=YES;
	CCSprite *background=[CCSprite spriteWithFile:@"bg_result.png"];
	background.anchorPoint=CGPointZero;
	background.position=CGPointMake(0,0);
	[resultLayer addChild:background];
	[self addResultView];
	[self addChild:resultLayer z:100 tag:100];
	
	[self schedule:@selector(updatePrice:) interval:0.5f];
}
-(void)updatePrice:(ccTime)dt{
	[self unschedule:@selector(updatePrice:)];
	[menu removeAllChildrenWithCleanup:YES];
	[totalNumLabel setString:[Tools caculateTotalNumberString:totalNumDic withParametersObject:currentParameters]];
	
	priceLabel=[CCLabelTTF labelWithString:[Tools caculatePriceString:currentParameters] fontName:@"Helvetica-Bold" fontSize:72.0f];
	priceLabel.color=ccc3(1,1,1);
	startLottery=[CCMenuItemLabel itemWithLabel:priceLabel target:self selector:@selector(startLotteryAction:)];
	[menu addChild:startLottery];
}
-(void)openRoll:(NSNotification *)notif{
	rollLayer.visible=YES;
}
-(void)closeRoll:(NSNotification *)notif{
	rollLayer.visible=NO;
}
-(void)changePriceName:(NSNotification *)notif{
	[menu removeAllChildrenWithCleanup:YES];
	NSDictionary *dataDic=(NSDictionary*)notif.userInfo;
	NSString *labelString=(NSString*)[dataDic valueForKey:@"priceString"];
	//[priceLabel setString:labelString];
	if(totalNumDic!=nil){
		[totalNumDic release];
		totalNumDic=nil;
	}
	totalNumDic=[[NSDictionary dictionaryWithDictionary:dataDic]retain];
	
		priceLabel=[CCLabelTTF labelWithString:labelString fontName:@"Helvetica-Bold" fontSize:72.0f];
	priceLabel.color=ccc3(1,1,1);
	startLottery=[CCMenuItemLabel itemWithLabel:priceLabel target:self selector:@selector(startLotteryAction:)];
	[menu addChild:startLottery];
	currentParameters=(ParametersObject*)[dataDic valueForKey:@"parameters"];
	[totalNumLabel setString:[Tools caculateTotalNumberString:totalNumDic withParametersObject:currentParameters]];
}


-(void)addResultView{
	int count=[luckyGuysQuery getNumberUnderNode:@"ticketList" withKey:@"name"];
	int totalCount=count+1;
	totalCount=(totalCount>11)?11:totalCount;
	
	int x [] = {60,130,251,395,533,795};
	int width [] ={70,121,144,138,262,172};
	int height=49;
	int y[totalCount];
	int yOffset=0;
	
	int lastY=340+(totalCount*49/2.0f);
	for(int i=0;i<totalCount;i++){
		y[i]=lastY-((i+1)*49)-yOffset;
	}
	
	for(int i=0;i<totalCount;i++){
		NSString *orderStrig=(i==0)?@"排序":[NSString stringWithFormat:@"%02d",i];
		NSInteger fontSize=(i==0)?23:25;
		CCLabelTTF *order=[CCLabelTTF labelWithString:orderStrig dimensions:CGSizeMake(width[0], height) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:fontSize];
		order.color=(i==0)?ccc3(0,0,0):ccc3(230,0,0);
		order.anchorPoint=CGPointZero;
		order.position=CGPointMake(x[0], y[i]);
		[resultLayer addChild:order];
		
		NSString *ticketString=(i==0)?@"獎票號碼":[luckyGuysQuery getValueUnderNode:@"ticketList" withKey:@"ticketNumber" withIndex:i-1];
		CCLabelTTF *ticket=[CCLabelTTF labelWithString:ticketString dimensions:CGSizeMake(width[1], height) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:fontSize];
		ticket.color=(i==0)?ccc3(0,0,0):ccc3(230,0,0);
		ticket.anchorPoint=CGPointZero;
		ticket.position=CGPointMake(x[1], y[i]);
		[resultLayer addChild:ticket];
		
		NSString *jobNumberString=(i==0)?@"工號":[luckyGuysQuery getValueUnderNode:@"ticketList" withKey:@"jobNumber" withIndex:i-1];
		CCLabelTTF *jobNumber=[CCLabelTTF labelWithString:jobNumberString dimensions:CGSizeMake(width[2], height) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:fontSize];
		jobNumber.color=(i==0)?ccc3(0,0,0):ccc3(230,0,0);
		jobNumber.anchorPoint=CGPointZero;
		jobNumber.position=CGPointMake(x[2], y[i]);
		[resultLayer addChild:jobNumber];
		
		NSString *nameString=(i==0)?@"姓名":[luckyGuysQuery getValueUnderNode:@"ticketList" withKey:@"name" withIndex:i-1];

		CCLabelTTF *name=[CCLabelTTF labelWithString:nameString dimensions:CGSizeMake(width[3], height) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:fontSize];
		name.color=(i==0)?ccc3(0,0,0):ccc3(230,0,0);
		name.anchorPoint=CGPointZero;
		name.position=CGPointMake(x[3], y[i]);
		[resultLayer addChild:name];
		
		NSString *orgString=(i==0)?@"單位":[luckyGuysQuery getValueUnderNode:@"ticketList" withKey:@"organization" withIndex:i-1];

		CCLabelTTF *org=[CCLabelTTF labelWithString:orgString dimensions:CGSizeMake(width[4], height) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:fontSize];
		org.color=(i==0)?ccc3(0,0,0):ccc3(230,0,0);
		org.anchorPoint=CGPointZero;
		org.position=CGPointMake(x[4], y[i]);
		[resultLayer addChild:org];
		
		NSString *commentString=(i==0)?@"備註":[luckyGuysQuery getValueUnderNode:@"ticketList" withKey:@"description" withIndex:i-1];
		NSInteger commentFontSize=(i==0)?fontSize:20;
		CCLabelTTF *comment=[CCLabelTTF labelWithString:commentString dimensions:CGSizeMake(width[5], height) alignment:UITextAlignmentCenter fontName:@"Helvetica" fontSize:commentFontSize];
		comment.color=(i==0)?ccc3(0,0,0):ccc3(230,0,0);
		comment.anchorPoint=CGPointZero;
		comment.position=CGPointMake(x[5], y[i]);
		[resultLayer addChild:comment];
	}

	CCMenuItem *closeBtn=[CCMenuItemImage itemFromNormalImage:@"btn_result_close.png" selectedImage:@"btn_result_close.png" target:self selector:@selector(closeResultLayer:)];
	closeBtn.anchorPoint=CGPointZero;
	CCMenu *closeMenu=[CCMenu menuWithItems:closeBtn,nil];
	closeMenu.anchorPoint=CGPointZero;
	closeMenu.position=CGPointMake(942, 13);
	[resultLayer addChild:closeMenu];
}

-(void)closeResultLayer:(id)sender{
	[self removeChildByTag:100 cleanup:YES];
	isAllowPress=YES;
}

-(void)lockMenuAction:(id)sender{
	isLock=!isLock;
	
	//[lockMenu removeAllChildrenWithCleanup:NO];
	NSString *image=(isLock)?@"btn_lock.png":@"btn_lock_i.png";
	CCMenuItem *lockMenuItem=[CCMenuItemImage itemFromNormalImage:image selectedImage:image target:self selector:@selector(lockMenuAction:)];
	lockMenuItem.anchorPoint=CGPointZero;
	[lockMenu addChild:lockMenuItem];
}
#pragma mark -
@end
