//
//  sql.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/18.
//  Copyright 2011年 foxconn. All rights reserved.
//
#import "FMDatabase.h"
#import "SingletonDBConnect.h"
#import "QueryPattern.h"
#import "FMDatabaseAdditions.h"
#import "SignInObject.h"
#import "Configure.h"
//#define TEST_SPEC_IMAGE 1

#pragma mark URL_DEFINITION
#define AppendSessionId [NSString stringWithFormat:@"?sessionId=%@",[SignInObject share].sessionId]
#define SERVERPREFIX URLBasePreFix
#define SYNCSERVERPREFIX [NSString stringWithFormat:@"%@/service/productService0.",SERVERPREFIX]

#define PRODUCTTYPE_SYNC [NSString stringWithFormat:@"%@getProductTypeList%@",SYNCSERVERPREFIX,AppendSessionId]
#define PRODUCTBRAND_SYNC [NSString stringWithFormat:@"%@getProductBrandList%@",SYNCSERVERPREFIX,AppendSessionId]
#define PRODUCT_SYNC [NSString stringWithFormat:@"%@getProductList%@",SYNCSERVERPREFIX,AppendSessionId]

#ifndef TEST_SPEC_IMAGE
#define PRODUCTSPEC_SYNC [NSString stringWithFormat:@"%@getProductSpecList%@",SYNCSERVERPREFIX,AppendSessionId]
#else
#define PRODUCTSPEC_SYNC [NSString stringWithFormat:@"http://10.62.13.2/spec.html",SERVERPREFIX]
#endif

#ifndef TEST_SPEC_IMAGE
#define PRODUCTIMAGE_SYNC [NSString stringWithFormat:@"%@getProductImageList%@",SYNCSERVERPREFIX,AppendSessionId]
#else
#define PRODUCTIMAGE_SYNC @"http://10.62.13.2/image.html"
#endif
#define PRODUCTSCENE_SYNC [NSString stringWithFormat:@"%@getProductSceneList%@",SYNCSERVERPREFIX,AppendSessionId]
#define PRODUCTSCENEGROUP_SYNC [NSString stringWithFormat:@"%@getProductSceneGroupList",SYNCSERVERPREFIX]
#pragma mark -

#pragma mark SQL_STRING
#define COUNTSQLSTRING(x) [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",x]
NSString *i_productType=@"INSERT INTO T_PRODUCT_TYPE0 (ID,NAME,SYS02,SYS01,\"PRIMARY\") values (?, ?, ?, ?, ?)";

NSString *i_product=@"INSERT INTO T_PRODUCT (ID, RETAIL_PRICE, MODEL_NAME, SYS03, SYS04, SYS05,REF_productType,REF_brand,SYS02,CODE,SYS01,PRODUCT_NAME,COLOR) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
NSString *i_productBrand=@"INSERT INTO T_PRODUCT_BRAND0 (ID, SYS03, SYS04, NAME, SYS02, SYS01) values (?, ?, ?, ?, ?, ?)";
NSString *i_productImage=@"INSERT INTO T_PRODUCT_IMAGE0 (ID, IMAGE46, IMAGE110, IMAGE250, SYS02, SYS01,SORT_NUMBER,REF_product) values (?, ?, ?, ?, ?, ?, ?, ?)";
NSString *i_productScene=@"INSERT INTO T_PRODUCT_SCENE0 (ID, DOCK, SCENE, NAME, SYS02, SYS01, SORT_NUMBER,\"PRIMARY\") values (?, ?, ?, ?, ?, ?, ?, ?)";
NSString *i_productSceneGroup=@"INSERT INTO T_PRODUCT_SCENE_GROUP0 (ID, POINT_X, POINT_Y, SYS02, REF_scene, SYS01, SORT_NUMBER,REF_type) values (?, ?, ?, ?, ?, ?, ?, ?)";
NSString *i_productSpec=@"INSERT INTO T_PRODUCT_SPEC0 (ID, REF_product, SYS03, SYS04, NAME, VALUE,SYS02,SYS01,SORT_NUMBER) values (?, ?, ?, ?, ?, ?, ?, ?,?)";

NSString *s_productType=@"SELECT * FROM T_PRODUCT_TYPE0";

NSString *s_getImageName=@"SELECT IMAGE46,IMAGE110,IMAGE250 FROM T_PRODUCT_IMAGE0 LIMIT ? OFFSET ?";
#pragma mark -

