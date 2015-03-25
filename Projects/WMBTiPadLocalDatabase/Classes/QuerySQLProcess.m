//
//  QuerySQL.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "QuerySQLProcess.h"
#import "SingletonDBConnect.h"
#import "FMDatabaseAdditions.h"
#import "QuerySQL.h"
#import "Tools.h"
@implementation QuerySQLProcess
+(NSDictionary*)queryAllCategories{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    FMResultSet *rs=[[SingletonDBConnect share] executeQuery:
                                   QueryScene];
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
        [dictionary setValue:[rs stringForColumn:@"ID"] forKey:@"id"];
        [dictionary setValue:[rs stringForColumn:@"DOCK"] forKey:@"dockImage"];
        [dictionary setValue:[rs stringForColumn:@"SCENE"] forKey:@"sceneImage"];
        [dictionary setValue:[rs stringForColumn:@"NAME"] forKey:@"name"];
        [dictionary setValue:[rs stringForColumn:@"PRIMARY"] forKey:@"primaryImage"];
        [dictionary setValue:[self querySubCategory:[rs stringForColumn:@"ID"]] forKey:@"subProductTypeList"];//
        [array addObject:dictionary];
    }
    [r setValue:array forKey:@"productTypeList"];
    [rs close];
    return r;
}

+(NSMutableArray*)querySubCategory:(NSString*)primaryKey{
    NSMutableArray *rArray=[NSMutableArray array];
    FMResultSet *rs=[[SingletonDBConnect share]executeQuery:QueryProductType(primaryKey)];
    while ([rs next]) {
        NSMutableDictionary *contentDic=[NSMutableDictionary dictionary];
        [contentDic setValue:[rs stringForColumn:@"ID"] forKey:@"id"];
        [contentDic setValue:[rs stringForColumn:@"PRIMARY"] forKey:@"primaryImage"];
        [contentDic setValue:[rs stringForColumn:@"NAME"] forKey:@"name"];
        [rArray addObject:contentDic];
    }
    [rs close];
    return rArray;
}

+(NSMutableDictionary*)queryProductType{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    FMResultSet *rs=[[SingletonDBConnect share] executeQuery:
                     QueryScene];
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
        [dictionary setValue:[rs stringForColumn:@"ID"] forKey:@"id"];
        [dictionary setValue:[rs stringForColumn:@"DOCK"] forKey:@"dockImage"];
        [dictionary setValue:[rs stringForColumn:@"SCENE"] forKey:@"sceneImage"];
        [dictionary setValue:[rs stringForColumn:@"NAME"] forKey:@"name"];
        [dictionary setValue:[rs stringForColumn:@"PRIMARY"] forKey:@"primaryImage"];
        [array addObject:dictionary];
    }
    [r setValue:array forKey:@"productTypeList"];
    [rs close];
    return r;
}

+(NSMutableDictionary*)queryProductList:(NSString*)categoryKey withBrandId:(NSString*)brandId withColor:(NSString*)color withPrice:(NSString*)price withType:(NSString*)type{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    NSMutableArray *productList=[NSMutableArray array];
    FMResultSet *rs=[[SingletonDBConnect share]executeQuery:queryProductListBlock(categoryKey,brandId,color,price,type)];
    while ([rs next]) {
        NSMutableDictionary *content=[NSMutableDictionary dictionary];
        [content setValue:[rs stringForColumn:@"ID"] forKey:@"id"];
        [content setValue:[rs stringForColumn:@"RETAIL_PRICE"] forKey:@"retailPrice"];
        [content setValue:[rs stringForColumn:@"PRODUCT_NAME"] forKey:@"name"];
        [content setValue:[rs stringForColumn:@"SCORE"] forKey:@"score"];
        [content setValue:[rs stringForColumn:@"BRAND"] forKey:@"brand"];
        [content setValue:[rs stringForColumn:@"IMAGE46"] forKey:@"image46"];
        [content setValue:[rs stringForColumn:@"IMAGE110"] forKey:@"image110"];
        [content setValue:[rs stringForColumn:@"IMAGE250"] forKey:@"image250"];
        [productList addObject:content];
    }
    [r setValue:productList forKey:@"productList"];
    [rs close];
    return r;
}

+(NSMutableDictionary*)queryProductDetail:(NSString*)productKey{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    NSMutableDictionary *content=[NSMutableDictionary dictionary];
    
    FMResultSet *rs=[[SingletonDBConnect share]executeQuery:QueryProductDetail(productKey)];
    while ([rs next]) {
        [content setValue:[rs stringForColumn:@"id"] forKey:@"id"];
        [content setValue:[rs stringForColumn:@"SCORE"] forKey:@"score"];
        [content setValue:[rs stringForColumn:@"CODE"] forKey:@"code"];
        [content setValue:[rs stringForColumn:@"ACCESSORIES"] forKey:@"accessories"];
        [content setValue:[rs stringForColumn:@"description"] forKey:@"description"];
        [content setValue:[rs stringForColumn:@"SERVICE"] forKey:@"service"];
        [content setValue:[rs stringForColumn:@"BRAND"] forKey:@"brand"];
        [content setValue:[rs stringForColumn:@"PRODUCT_NAME"] forKey:@"productName"];
        [content setValue:[rs stringForColumn:@"RETAIL_PRICE"] forKey:@"retailPrice"];
        [content setValue:[self querySpec:productKey] forKey:@"specList"];
        [content setValue:[self queryImagesInProduct:productKey] forKey:@"imageList"];
    }
    [r setValue:content forKey:@"productInfo"];
    [rs close];
    return r;
}
+(NSMutableArray*)querySpec:(NSString*)productKey{
    NSMutableArray *r=[NSMutableArray array];
    FMResultSet *rs=[[SingletonDBConnect share]executeQuery:QueryProductSpec(productKey)];
    while([rs next]){
        NSMutableDictionary *content=[NSMutableDictionary dictionary];
        [content setValue:[rs stringForColumn:@"NAME"] forKey:@"name"];
        [content setValue:[rs stringForColumn:@"VALUE" ]forKey:@"value"];
        [r addObject:content];
    }
    [rs close];
    return r;
}

+(NSMutableArray*)queryImagesInProduct:(NSString*)productKey{
    NSMutableArray *r=[NSMutableArray array];
    FMResultSet *rs=[[SingletonDBConnect share]executeQuery:QueryProductImages(productKey)];
    while([rs next]){
        NSMutableDictionary *content=[NSMutableDictionary dictionary];
        [content setValue:[rs stringForColumn:@"ID" ]forKey:@"id"];
        [content setValue:[rs stringForColumn:@"IMAGE46" ]forKey:@"image46"];
        [content setValue:[rs stringForColumn:@"IMAGE110" ]forKey:@"image110"];
        [content setValue:[rs stringForColumn:@"IMAGE250" ]forKey:@"image250"];
        [r addObject:content];
    }
    [rs close];
    return r;
}

+(NSMutableDictionary*)queryBrand:(NSString*)categoryKey{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    NSMutableArray *rArray=[NSMutableArray array];
    FMResultSet *rs=[[SingletonDBConnect share] executeQuery:QueryBrand(categoryKey)];
    while ([rs next]) {
        NSMutableDictionary *content=[NSMutableDictionary dictionary];
        [content setValue:[rs stringForColumn:@"id"] forKey:@"id"];
        [content setValue:[rs stringForColumn:@"name"] forKey:@"name"];
        [rArray addObject:content];
    }
    [r setValue:rArray forKey:@"productBrandList"];
    return r;
}

+(NSMutableDictionary*)queryColor:(NSString*)categoryKey{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    NSMutableArray *rArray=[NSMutableArray array];
    FMResultSet *rs=[[SingletonDBConnect share] executeQuery:QueryColor(categoryKey)];
    while ([rs next]) {
        NSMutableDictionary *content=[NSMutableDictionary dictionary];
        [content setValue:[rs stringForColumn:@"COLOR"] forKey:@"color"];
        [rArray addObject:content];
    }
    [r setValue:rArray forKey:@"productColorList"];
    return r;
}

+(NSMutableDictionary*)queryPrice:(NSString*)categoryKey{
    NSMutableDictionary *r=[NSMutableDictionary dictionary];
    FMResultSet *rs=[[SingletonDBConnect share] executeQuery:QueryPrice(categoryKey)];
    NSMutableArray *array=[NSMutableArray array];
    float max,min;
    while ([rs next]) {
        max=(float)[rs intForColumn:@"maxprice"];
        min=(float)[rs intForColumn:@"minprice"];
    }
    float s=(max-min)/6;
    
    NSInteger minValue=[Tools detectBaseValue:(int)min withPlusBase:NO];
    NSInteger maxValue=[Tools detectBaseValue:(int)max withPlusBase:YES];
    NSInteger space=[Tools detectBaseValue:(int)s withPlusBase:NO];
    for (int i=0; i<6; i++) {
        NSMutableDictionary *content=[NSMutableDictionary dictionary];
        int origin=(int)minValue;
        minValue+=space;
        (i<5)?[content setValue:[NSString stringWithFormat:@"%i - %i",origin,minValue] forKey:@"price"]:[content setValue:[NSString stringWithFormat:@"%i - %i",origin,maxValue] forKey:@"price"];
        [array addObject:content];
    }
    [r setValue:array forKey:@"productPriceList"];
    [rs close];
    return r;
}


@end
