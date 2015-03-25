//
//  QuerySQL.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/22.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuerySQLProcess : NSObject {
    
}
+(NSMutableDictionary*)queryAllCategories;
+(NSMutableArray*)querySubCategory:(NSString*)primaryKey;
+(NSMutableDictionary*)queryProductType;
+(NSMutableDictionary*)queryProductList:(NSString*)categoryKey withBrandId:(NSString*)brandId withColor:(NSString*)color withPrice:(NSString*)price withType:(NSString*)type;
+(NSMutableDictionary*)queryProductDetail:(NSString*)productKey;
+(NSMutableArray*)querySpec:(NSString*)productKey;
+(NSMutableArray*)queryImagesInProduct:(NSString*)productKey;
+(NSMutableDictionary*)queryBrand:(NSString*)categoryKey;
+(NSMutableDictionary*)queryColor:(NSString*)categoryKey;
+(NSMutableDictionary*)queryPrice:(NSString*)categoryKey;
@end
