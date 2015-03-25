//
//  Action.h
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateView.h"
@interface EventAction : NSObject {
    NSMutableArray *eventsInMonth;
    NSInteger radiusOffset; //依時間軸拖拉之offset
}
@property(nonatomic,retain)NSMutableArray *eventsInMonth;
@property(nonatomic)NSInteger radiusOffset;
+(EventAction*)share;
+(void)singletonRelease;
-(void)drawEvents:(UIView*)eventView;

/*
 取得輪盤上應出現之事件
 */
-(void)fetchEventsInWheel:(NSDate*)selectedDate withInitAngle:(CGFloat)angle;
/*
 調整每個事件item之位置
 @param:位移
 */
-(void)tuneEventDistance:(NSInteger)distance;
/*
 調整每個事件item之位置
 @param:旋轉孤度
 */
-(void)tuneEventRadian:(double)radian;
/*
 依畫面上位移之兩點來計算旋轉之孤度
 */
-(double)caculateRadian:(CGPoint)point1 withPoint2:(CGPoint)point2;
/*
 依type取得該事件在todayEventList上之顏色色塊圖之檔名
 */
-(NSString*)eventColorByStyle:(NSInteger)type;
/*
 依type取得事件icon檔名
 */
-(NSString*)eventIconNameByStyle:(NSInteger)type;

/**
 調整日期之角度
 */
-(void)tuneDatesByWheel:(NSMutableArray*)dates withRadian:(double)radian;


/**
 檢查datebywhell之字型大小
 */
-(void)setDateByWheelFontSize:(DateView*)date withVec:(CGPoint)bound;

/**
 取得當日所有事件
 */
-(NSArray*)fetchEventsOnDate:(NSDate*)selecteDate;

/**
 當日是否有事件
 */
-(BOOL)hasEventsOnDate:(NSDate*)_date;

/**
 依事件型別給予不同的圖
 */
-(UIImage*)buttonTypeImage:(NSInteger)i_eventType;
/**
 依事件型別給予不同的名稱
 */
-(NSString*)typeNameString:(NSInteger)eventType;
@end
