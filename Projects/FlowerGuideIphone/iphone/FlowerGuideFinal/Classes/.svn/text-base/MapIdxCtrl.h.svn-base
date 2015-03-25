//
//  MapIdxCtrl.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 4/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolsFunction.h"
#import "NSFileHandleExtend.h"
#import "FeatureIdxObject.h"
@interface MapIdxCtrl : NSObject {
	NSFileHandle *thisFileHandle;
	//圖資最左上角的X,目前均定為0
	NSInteger startX;
	//圖資最左上角的Y,目前均定為0
	NSInteger startY;
	//每個cell的高
	NSInteger cellHeight;
	//每個cell的寬
	NSInteger cellWidth;
	//有幾列
	NSInteger cellRow;
	//有幾欄
	NSInteger cellColumn;
	NSData *totalData;
}
@property(nonatomic) NSInteger startX;
@property(nonatomic) NSInteger startY;
@property(nonatomic) NSInteger cellHeight;
@property(nonatomic) NSInteger cellWidth;
@property(nonatomic) NSInteger cellRow;
@property(nonatomic) NSInteger cellColumn;
-(id)initWithFileName:(NSString*)fileName;
/**
 給予左上右下座標,查詢出所包含之位置
 */
-(NSMutableArray*)getAllGridWithPoint1:(CGPoint)leftUpPoint withPoint2:(CGPoint)rightDownPoint;
/**
 parsing collection中的featureId
 */
-(void)getAllFeatureIdInCollection:(NSData*)indexNodeData withDictionary:(NSMutableDictionary*)inputDictionary;
/**
 取得所有在rect中的featureId
 */
-(NSMutableDictionary*)getAllFeatureIdWithPoint1:(CGPoint)leftUpPoint withPoint2:(CGPoint)rightDownPoint;

@end
