//
//  MaskLayer.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/28.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MaskLayer : CCLayer {
    CCSprite *selSprite,*unSelSprite;
    NSMutableArray *movableSprites;
}
-(void)addTimeMeter;
-(CGPoint)meterSpritePosition:(CGPoint)translation withSprite:(CCSprite*)thisSprite;
-(BOOL)isReachBound:(CCSprite*)_selSprite withTranslation:(CGPoint)_translation;
-(double)caculateRadian:(CGPoint)point1 withPoint2:(CGPoint)point2;
@end
