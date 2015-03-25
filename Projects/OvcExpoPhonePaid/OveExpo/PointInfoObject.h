//
//  PointInfoObject.h
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointInfoObject : NSObject{
    NSString *pointName;
    NSInteger pointId;
}
@property(nonatomic,retain)NSString *pointName;
@property(nonatomic)NSInteger pointId;
@end
