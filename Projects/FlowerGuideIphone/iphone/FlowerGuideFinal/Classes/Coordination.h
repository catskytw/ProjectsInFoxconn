//
//  Coordination.h
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 12/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 符合Android之x,y座標物件
 */
@interface Coordination : NSObject {
	NSInteger x;
	NSInteger y;
}
@property(nonatomic)NSInteger x;
@property(nonatomic)NSInteger y;
-(id)init:(CGPoint)iphoneXY;
-(id)initWithXY:(NSInteger)inputX withY:(NSInteger)inputY;
@end
