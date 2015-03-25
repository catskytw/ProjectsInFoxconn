//
//  AllCategoryObject.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/12.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AllCategoryObject : NSObject {
    NSMutableDictionary *m_MDic;
    NSMutableDictionary *m_SDic;
    NSMutableArray *orderKeys;
}
@property(nonatomic,retain)NSMutableDictionary *m_MDic,*m_SDic;
@property(nonatomic,retain)NSMutableArray *orderKeys;
+(AllCategoryObject*)share;
+(void)releaseSingleton;
@end
