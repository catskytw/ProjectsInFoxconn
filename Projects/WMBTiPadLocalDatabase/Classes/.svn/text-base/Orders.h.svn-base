//
//  Orders.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"

@interface Orders : NSObject {
    @public
    NSMutableDictionary *orders;
}
//儲入資料清空訂單
-(void)flushOrders:(NSString*)notificationName;
//從檔案讀取訂單
//-(BOOL)loadFromFile;
//儲存檔案進訂單
-(void)saveToFile;
//加入某一筆訂單
-(BOOL)addOrder:(OrderItem*)inputOrderItem;
//取得該使用者orders之數量
-(NSInteger)getOrdersNum;
//變更該訂單
-(BOOL)replaceOrder:(OrderItem*)newOrder withIndex:(NSInteger)index;
-(OrderItem*)getOrders:(NSInteger)index;
-(BOOL)removeOrder:(NSString*)orderId;
-(void)removeAllOrders;
+(Orders*)share;
@end
