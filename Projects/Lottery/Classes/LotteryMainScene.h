//
//  LotteryMainScene.h
//  LotteryProject
//
//  Created by 廖 晨志 on 2011/3/2.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SettingView.h"
#import "QueryPattern.h"
@interface LotteryMainScene : CCNode {
	CCLayer *backgroundLayer;
	CCLayer *animationLayer;
	CCLayer *rollLayer;
	CCLayer *priceLayer;
	CCLayer *resultLayer;
	
	SettingView *settingView;
	
	CCMenuItem *startLottery;
	CCMenu *menu,*lockMenu;
	
	CCSprite *rollSprite;
	CCSprite *runningSprite;
	CCSprite *lMoneySprite;
	CCSprite *mMoneySprite;
	CCSprite *sMoneySprite;
	CCSprite *lMoneySprite1;
	CCSprite *mMoneySprite1;
	CCSprite *sMoneySprite1;
	CCLabelTTF *totalNumLabel;
	CCLabelTTF *priceLabel;
	
	ParametersObject *currentParameters;
	
	QueryPattern *luckyGuysQuery;
	
	NSDictionary *totalNumDic;
	
	//雙重鎖
	BOOL isAllowPress;
	BOOL isLock;
	
	BOOL isSchedule;
	BOOL isRunningAnimation;
	BOOL isQuerying;
}
-(void)startLotteryAction;
@end
