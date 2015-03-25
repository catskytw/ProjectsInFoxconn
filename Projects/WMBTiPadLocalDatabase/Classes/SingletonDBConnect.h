//
//  SingletonDb.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/18.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface SingletonDBConnect : NSObject {
    
}
+(FMDatabase*)share;
+(void)closeDB;
@end
