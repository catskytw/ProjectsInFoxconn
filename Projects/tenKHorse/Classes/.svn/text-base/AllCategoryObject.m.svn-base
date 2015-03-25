//
//  AllCategoryObject.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/12.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "AllCategoryObject.h"
#import "QueryPattern.h"
#import "Configure.h"
static AllCategoryObject *singleton;
@implementation AllCategoryObject
@synthesize m_MDic,m_SDic,orderKeys;
+(AllCategoryObject*)share{
    if(singleton==nil)
        singleton=[AllCategoryObject new];
    return singleton;
}
+(void)releaseSingleton{
    if(singleton!=nil){
        [singleton release];
        singleton=nil;
    }
}
-(id)init{
    if((self=[super init])){
        m_MDic=[[NSMutableDictionary dictionary]retain];
        m_SDic=[[NSMutableDictionary dictionary]retain];
        orderKeys=[[NSMutableArray array]retain];
        QueryPattern *mCategoryQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
        QueryPattern *sCategoryQuery=[[QueryPattern alloc] initWithStartNotificationName:BeforeSync withEndNotification:AfterSync];
        [mCategoryQuery prepareDic:searchAllCategory()];
        NSInteger totalMCategory=[mCategoryQuery getNumberUnderNode:@"productTypeList" withKey:@"id" withDepth:1];
        NSLog(@"num:%i",totalMCategory);
        for(int i=0;i<totalMCategory;i++){
            NSString *key=[NSString stringWithString:(NSString*)[mCategoryQuery getValueUnderNode:@"productTypeList" withKey:@"id"withIndex:i withDepth:1]];
            NSString *value=[NSString stringWithString:(NSString*)[mCategoryQuery getValueUnderNode:@"productTypeList" withKey:@"name" withIndex:i withDepth:1]];
            [m_MDic setValue:[value retain] forKey:[key retain]];
            [orderKeys addObject:key];
            NSArray *subProductList=(NSArray*)[mCategoryQuery getObjectUnderNode:@"subProductTypeList" withIndex:i];
            
            NSMutableDictionary *sDic=[NSMutableDictionary new];
            for(int j=0;j<[subProductList count];j++){
                NSDictionary *thisDic=(NSDictionary*) [subProductList objectAtIndex:j];
                [sCategoryQuery prepareDicWithDictionary:thisDic];
                NSString *sKey=[NSString stringWithString:[sCategoryQuery getValue:@"id" withIndex:0]];
                NSString *sValue=[NSString stringWithString:[sCategoryQuery getValue:@"name" withIndex:0]];
                [sDic setValue:[sValue retain] forKey:[sKey retain]];
            }
            [m_SDic setValue:[[NSMutableDictionary dictionaryWithDictionary:sDic]retain] forKey:key];
            [sDic autorelease];
        }
        [sCategoryQuery release];
        [mCategoryQuery release];
    }
    return self;
}
-(void)dealloc{
    [orderKeys release];
    [m_MDic release];
    [m_SDic release];
    [super dealloc];
}
@end
