/*
 *  Configure.h
 *  TenKHorse
 *
 *  Created by 廖 晨志 on 2011/1/24.
 *  Copyright 2011 foxconn. All rights reserved.
 *
 */
#import <UIKit/UIKit.h>
#import "Tools.h"
#import "TUNinePatchCache.h"
#import "SignInObject.h"
//#define TEST_DATA 0x00001

//prefix
//#define WebServiceURLPrefix @"http://10.155.4.121:7000/ccpt/services/kioskService"
#define WebServiceURLPrefix @"http://58.246.162.126:9090/ccpt/services/kioskService"
//58.246.162.126
#define URLBasePreFix @"http://58.246.162.126:8080"
//#define URLBasePreFix @"http://10.62.13.2:8080"
#define URLPrefix [NSString stringWithFormat:@"%@/service/",URLBasePreFix]
#define picUrl(picName) [NSString stringWithFormat:@"%@%@",URLBasePreFix,picName]
#define ProductServicePrefix [NSString stringWithFormat:@"%@productService.",URLPrefix]
#define CommonServicePrefix [NSString stringWithFormat:@"%@commonService.",URLPrefix]
#define LoginServicePrefix [NSString stringWithFormat:@"%@accountService.",URLPrefix]
#define MemberServicePrefix [NSString stringWithFormat:@"%@memberService.",URLPrefix]
#define OrderServicePrefix [NSString stringWithFormat:@"%@orderService.",URLPrefix]
#define EmployeeServicePrefix [NSString stringWithFormat:@"%@employeeService.",URLPrefix]
//商品型錄
#define searchMCategory() [NSString stringWithFormat:@"%@getProductTypeList?sortType=1",ProductServicePrefix]
#define searchAllCategory() [NSString stringWithFormat:@"%@getAllProductTypeList%@",ProductServicePrefix,randonString]
#define searchSCategory(x) [NSString stringWithFormat:@"%@&productTypeId=%@",searchMCategory(),x]
#define searchProductList(sKey,sortType,brandId,colorId,priceRange) [Tools getProductListString:sKey withSortType:sortType withBrand:brandId withColor:colorId withPrice:priceRange]
#define searchCategoryImage() [NSString stringWithFormat:@"%@getProductTypeList",ProductServicePrefix]
#define searchBrandFilter(sKey) [NSString stringWithFormat:@"%@getBrandFilter?productTypeId=%@",ProductServicePrefix,sKey]
#define searchColorFilter(sKey) [NSString stringWithFormat:@"%@getColorFilter?productTypeId=%@",ProductServicePrefix,sKey]
#define searchPriceFilter(sKey) [NSString stringWithFormat:@"%@getPriceFilter?productTypeId=%@",ProductServicePrefix,sKey]

//促銷專區
#define searchPromotionProductList() [NSString stringWithFormat:@"%@getPromotionProductList%@",ProductServicePrefix,withSessionId]
#define searchProductBrandList(sKey) [NSString stringWithFormat:@"%@getProductBrandList?productTypeId=%@",ProductServicePrefix,sKey]
#define searchProductDetailInfo(productKey) [NSString stringWithFormat:@"%@getProductInfo?productId=%@",ProductServicePrefix,productKey]
#define searchPromoteList() [NSString stringWithFormat:@"%@getPromotionEventList",CommonServicePrefix]
#define searchPromotionDetailInfo(x) [NSString stringWithFormat:@"%@getPromotionEventInfo?eventId=%@",CommonServicePrefix,x]
#define searchHotProduct() [NSString stringWithFormat:@"%@getHotProduct%@",ProductServicePrefix,withSessionId]

//Login
#define loginAPI(account,pwd) [NSString stringWithFormat:@"%@login?loginId=%@&password=%@",LoginServicePrefix,account,pwd]
#define userInfo(sessionId) [NSString stringWithFormat:@"%@getMemberInfo?sessionId=%@",MemberServicePrefix,sessionId] //member
#define employeeInfo(sessionId) [NSString stringWithFormat:@"%@getEmployeeInfo?sessionId=%@",EmployeeServicePrefix,sessionId]//employee
#define logout() [NSString stringWithFormat:@"%@logout%@",LoginServicePrefix,withSessionId]
#define activation(code,phone) [NSString stringWithFormat:@"%@activation?code=%@&phone=%@",LoginServicePrefix,code,phone]
#define forgetPwd(code,phone) [NSString stringWithFormat:@"%@forgetPassword?code=%@&phone=%@",LoginServicePrefix,code,phone]
#define changePwd(newPwd,oldPwd) [NSString stringWithFormat:@"%@changePassword%@&newPassword=%@&oldPassword=%@",LoginServicePrefix,withSessionId,newPwd,oldPwd]
//會員專區
#define orderList() [NSString stringWithFormat:@"%@getOrderList%@",OrderServicePrefix,withSessionId]
#define orderDetail(orderId) [NSString stringWithFormat:@"%@getOrderInfo?orderId=%@",OrderServicePrefix,orderId]
//Misc
#define coinIdentify @"￥"
#define withSessionId [NSString stringWithFormat:@"?sessionId=%@",[SignInObject share].sessionId]
#define randonString [NSString stringWithFormat:@"?rnd=%i",random()]
#define closePopWindow() [[NSNotificationCenter defaultCenter] postNotificationName:ClosePopWindow object:nil]
#define DefaultOrangeColor [UIColor colorWithRed:(CGFloat)135/256 green:(CGFloat)82/256 blue:(CGFloat)7/256 alpha:1]
#define ninepatch(CGSize,ninePatchName) [TUNinePatchCache imageOfSize:CGSize forNinePatchNamed:ninePatchName]
//test data
#define DefaultSubCatalogKey @"6466B8BB-6939-45B1-BDF0-7E92381AD514"
#define DefaultSubCatelogString @""
#define DefaultSortType @"1"

//Notification name
#define BeforeSync @"BeforeSync"
#define AfterSync @"AfterSync"
#define CatalogTemplateNotification @"CatalogTemplateNofitication"
#define dismissPopover @"dismissPopover"
#define ShiftComparePanel @"ShiftComparePanel"
#define AddProductCompare @"AddProductCompare"
#define SuccessLogin @"SuccessLogin"
#define FailureLogin @"FailureLogin"
#define ClosePopWindow @"ClosePopWindow"

#define DefaultFontName @"STHeitiTC-Light"

//tab bar index
#define TabBarIndex_ProductList 0
#define TabBarIndex_Promote 1
#define TabBarIndex_Member 2
#define TabBarIndex_ShoppingCart 3



@interface UITabBar (CustomImage)
@end
@implementation UITabBar (CustomImage)
-(void)drawRect:(CGRect)rect{
	UIImage *image=[UIImage imageNamed:@"content_ui_underbar.png"];
	[image drawInRect:CGRectMake( 0, -11, self.frame.size.width, 69)];
}
@end