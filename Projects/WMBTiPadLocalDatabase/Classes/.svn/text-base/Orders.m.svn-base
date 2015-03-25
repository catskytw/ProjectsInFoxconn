//
//  Orders.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/5/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "Orders.h"
#import "SignInObject.h"
#import "WMBTWebService.h"
#import "OrderDtlObject.h"
#import "Configure.h"
#define  AFTER_ORDERS_SEND @"AFTER_ORDERS_SEND"
static Orders *sigletonOrders;
@interface Orders (PrivateMethod)
-(NSString*)filePath;
@end
@implementation Orders
+(Orders*)share{
    if(sigletonOrders==nil)
       sigletonOrders=[Orders new];
    return sigletonOrders;
}
-(id)init{
    if((self=[super init])){
        //先讀plist檔,讀沒有才new
        orders=[[NSMutableDictionary alloc]initWithContentsOfFile:[self filePath]];
        if(orders==nil)
            orders=[NSMutableDictionary dictionary];
        [orders retain];
    }
    return  self;
}
-(BOOL)replaceOrder:(OrderItem*)newOrder withIndex:(NSInteger)index{
    NSMutableArray *ordersArray=(NSMutableArray*)[orders valueForKey:[SignInObject share].account];
    [ordersArray replaceObjectAtIndex:index withObject:newOrder];
    [orders setValue:ordersArray forKey:[SignInObject share].account];
    return YES;
}
-(BOOL)removeOrder:(NSString*)orderId{
    NSInteger totalNum=[self getOrdersNum];
    for(NSInteger i=0;i<totalNum;i++){
        OrderItem *thisOrder=[self getOrders:i];
        if([thisOrder.productId isEqualToString:orderId]){
            NSMutableArray *ordersArray=(NSMutableArray*)[orders valueForKey:[SignInObject share].account];
            [ordersArray removeObject:thisOrder];
            [orders setValue:ordersArray forKey:[SignInObject share].account];
            return YES;
        }
    }
    return NO;
}
-(BOOL)addOrder:(OrderItem*)inputOrderItem{
    @try {
        if([SignInObject share].isLogin==NO) return NO; //this should not been happened.
        NSArray *keys=[orders allKeys];
        NSMutableArray *values=nil;
        for(NSString *key in keys){
            if([[SignInObject share].account isEqualToString:key]){
                NSMutableArray *tmpValue=(NSMutableArray*)[orders valueForKey:key];
                values=tmpValue;
                break;
            }
        }
        if(values==nil) values=[NSMutableArray array];
        [values addObject:inputOrderItem];
        [orders setValue:values forKey:[SignInObject share].account];
        
        [self saveToFile];
    }
    @catch (NSException *exception) {
        NSLog(@"Error:%@",[exception description]);
        return NO;
    }
    return YES;
}
-(void)flushOrders:(NSString*)notificationName{
    //送出API
    NSInteger orderNum=[[Orders share]getOrdersNum];
    WMBTWebService *webService=
    [[WMBTWebService alloc]initWithNotificationName:notificationName withURLPrefix:WebServiceURLPrefix];
    NSMutableArray *ordersArray=[[NSMutableArray array]retain];
    for (int i=0; i<orderNum; i++) {
        OrderItem *thisItem=[[Orders share]getOrders:i];
        OrderDtlObject *o=[OrderDtlObject new];
        o.prodId=thisItem.productId;
        o.prodPrice=[NSString stringWithFormat:@"%i",thisItem.price];
        o.prodQty=[NSString stringWithFormat:@"%i",thisItem.number];
        [ordersArray addObject:o];
        [o autorelease];
    }
    [webService createAdvance:ordersArray withCpy:[SignInObject share].storeId withMember:[SignInObject share].memberId
     ];
    NSLog(@"memberId:%@",[SignInObject share].memberId);
    //B263A3660AB516C00028CA1CC73D4489
}

-(void)removeAllOrders{
    [orders setValue:[NSMutableArray array] forKey:[SignInObject share].account];
}
-(void)saveToFile{
    BOOL r=[orders writeToFile:[self filePath] atomically:YES];
    NSLog(@"write result:%i",r);
}
-(void)dealloc{
    if(orders!=nil)
        [orders release];
    [super dealloc];
}
-(NSInteger)getOrdersNum{
    NSArray *ordersArray=(NSArray*)[orders valueForKey:[SignInObject share].account];
    return ([SignInObject share].isLogin==NO)?0:[ordersArray count];
}

-(OrderItem*)getOrders:(NSInteger)index{
    NSArray *ordersArray=(NSArray*)[orders valueForKey:[SignInObject share].account];
    int(^maxCount)(int)=^(int a){
        int r=(a>[ordersArray count]-1)?[ordersArray count]-1:a;
        return r;
    };
    OrderItem *rOrder=[ordersArray objectAtIndex:maxCount(index)];
    return ([SignInObject share].isLogin==NO)?nil:rOrder;
}
//取得plist path
-(NSString*)filePath{
    
    //NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docPath=[paths objectAtIndex:0];
    //NSString *filePath=[docPath stringByAppendingPathComponent:@"myOrders.plist"];
    
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"myOrders" ofType:@"plist"];
    NSLog(@"path:%@",filePath);
    return filePath;
}
@end
