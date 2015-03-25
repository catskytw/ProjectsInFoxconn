//
//  QuerySQL.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/22.
//  Copyright 2011年 foxconn. All rights reserved.


#define QueryScene @"SELECT ID,\"PRIMARY\",DOCK,SCENE,NAME FROM T_PRODUCT_SCENE0"
#define QueryProductType(subKey) [NSString stringWithFormat:@"SELECT T_PRODUCT_TYPE0.ID AS ID,\"PRIMARY\",NAME FROM T_PRODUCT_SCENE_GROUP0 LEFT JOIN T_PRODUCT_TYPE0 ON T_PRODUCT_SCENE_GROUP0.[REF_type]=T_PRODUCT_TYPE0.ID WHERE T_PRODUCT_SCENE_GROUP0.[REF_scene]=\"%@\"",subKey]

//#define QueryProductList(categoryKey) [NSString stringWithFormat:@"SELECT T_PRODUCT.ID AS ID,retail_price,product_name,score,image46,image110,image250,T_PRODUCT_BRAND0.NAME AS BRAND from T_PRODUCT LEFT JOIN T_product_image0 on T_PRODUCT.ID=T_product_image0.REF_PRODUCT LEFT JOIN T_PRODUCT_BRAND0 ON T_PRODUCT.REF_BRAND=T_PRODUCT_BRAND0.ID WHERE REF_productType=\"%@\" and T_PRODUCT_IMAGE0.SORT_NUMBER=1",categoryKey]

//#define QueryProductList(categoryKey,brandId, price, color,  type) queryProductListBlock(categoryKey,brandId,price,color,type)

#define QueryProductDetail(productKey) [NSString stringWithFormat:@"SELECT T_PRODUCT.ID as id,CODE,ACCESSORIES,SCORE,RETAIL_PRICE,COLOR,T_PRODUCT.SYS05 as description, SERVICE,PRODUCT_NAME, T_PRODUCT_BRAND0.NAME as BRAND FROM T_PRODUCT LEFT JOIN T_PRODUCT_BRAND0 on T_PRODUCT.REF_brand=T_PRODUCT_BRAND0.ID WHERE T_PRODUCT.ID=\"%@\"",productKey]

#define QueryProductSpec(productKey) [NSString stringWithFormat:@"SELECT NAME,VALUE FROM T_PRODUCT_SPEC0 WHERE REF_product=\"%@\"",productKey]

#define QueryProductImages(productKey) [NSString stringWithFormat:@"SELECT ID,IMAGE46,IMAGE110,IMAGE250 FROM T_PRODUCT_IMAGE0 WHERE REF_product=\"%@\"",productKey]

#define QueryBrand(categoryKey) [NSString stringWithFormat:@"SELECT DISTINCT T_PRODUCT_BRAND0.ID AS id,T_PRODUCT_BRAND0.NAME AS name FROM T_PRODUCT_BRAND0 LEFT JOIN T_PRODUCT on T_PRODUCT.REF_brand=T_PRODUCT_BRAND0.ID WHERE T_PRODUCT.REF_productType=\"%@\"",categoryKey]

#define QueryColor(categoryKey) [NSString stringWithFormat:@"SELECT DISTINCT color FROM T_PRODUCT WHERE T_PRODUCT.REF_productType=\"%@\"",categoryKey]

#define QueryPrice(categoryKey) [NSString stringWithFormat:@"SELECT RETAIL_PRICE, MAX(RETAIL_PRICE) AS maxprice, MIN(RETAIL_PRICE) as minprice FROM T_PRODUCT WHERE REF_productType=\"%@\"",categoryKey]

NSString*(^queryProductListBlock)(NSString *categoryKey,NSString *brandId, NSString *price, NSString *color, NSString *type)=^(NSString *categoryKey,NSString *brandId, NSString *color, NSString *price, NSString *type){

    NSString *r=[NSString stringWithFormat:@"SELECT T_PRODUCT.ID AS ID,retail_price,product_name,score,image46,image110,image250,T_PRODUCT_BRAND0.NAME AS BRAND from T_PRODUCT , (SELECT * FROM T_PRODUCT_IMAGE0 WHERE T_PRODUCT_IMAGE0.SORT_NUMBER=1) T2,T_PRODUCT_BRAND0 WHERE REF_productType=\"%@\"  and T2.REF_PRODUCT=T_PRODUCT.ID and T_PRODUCT.REF_BRAND=T_PRODUCT_BRAND0.ID",categoryKey];
    
    NSLog(@"%@",r);
    if((NSNull*)brandId!=[NSNull null])
        r=[r stringByAppendingFormat:@" AND T_PRODUCT_BRAND0.ID=\"%@\"",brandId];
    if((NSNull*)color!=[NSNull null])
        r=[r stringByAppendingFormat:@" AND T_PRODUCT.COLOR=\"%@\"",color];
    if((NSNull*)price!=[NSNull null]){
        NSArray *stringArray=[price componentsSeparatedByString:@"-"];
        NSString *startPrice=[stringArray objectAtIndex:0];
        NSString *endPrice=[stringArray objectAtIndex:1];
        
        r=[r stringByAppendingFormat:@" AND T_PRODUCT.RETAIL_PRICE BETWEEN %@ AND %@",startPrice,endPrice];
    }
    //TODO add price
    NSInteger i_type=[type intValue];
    switch(i_type){
        case 1:
            r=[r stringByAppendingString:@" ORDER BY T_PRODUCT.SYS04"];
            break;
        case 2:
            r=[r stringByAppendingString:@" ORDER BY T_PRODUCT.RETAIL_PRICE"];
            break;
        case 3:
            r=[r stringByAppendingString:@" ORDER BY T_PRODUCT.PRODUCT_NAME"];
            break;
    }
    NSLog(@"%@",r);
    return r;
};