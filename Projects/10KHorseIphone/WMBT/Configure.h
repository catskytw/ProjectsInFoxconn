/*
 *  Configure.h
 *  TenKHorse
 *
 *  Created by 廖 晨志 on 2011/1/24.
 *  Copyright 2011 foxconn. All rights reserved.
 *
 */
#import <UIKit/UIKit.h>
//#define TEST_MODE 1
//#define TEST_DATA 0x00001
//#define TEST_WEBSERVICE 0x00001
#define DefaultTintNavigationButtonColor [UIColor colorWithRed:(CGFloat)230/256 green:(CGFloat)230/256 blue:(CGFloat)230/256 alpha:1]
#define URLBasePreFix @"http://58.246.162.126:8080"
#define WebServiceURLPrefix @"http://58.246.162.126:9090/ccpt/services/kioskService"


//":8080"192.168.153.1 10.62.13.2 eaiccc.no-ip.org /10.62.13.2 10.62.13.32 10.62.12.187 58.246.162.126
#define URLPrefix [NSString stringWithFormat:@"%@/service/",URLBasePreFix]
#define picUrl(picName) [NSString stringWithFormat:@"%@%@",URLBasePreFix,picName]
#define ProductServicePrefix [NSString stringWithFormat:@"%@productService.",URLPrefix]
#define CommonServicePrefix [NSString stringWithFormat:@"%@commonService.",URLPrefix]
#define AccountServicePrefix [NSString stringWithFormat:@"%@accountService.",URLPrefix]
#define MemberServicePrefix [NSString stringWithFormat:@"%@memberService.",URLPrefix]
#define EmployeeServicePrefix [NSString stringWithFormat:@"%@employeeService.",URLPrefix]
#define OrderServicePrefix [NSString stringWithFormat:@"%@orderService.",URLPrefix]
#define searchMCategory() [NSString stringWithFormat:@"%@getProductTypeList?sortType=1",ProductServicePrefix]
#define searchSCategory(x) [NSString stringWithFormat:@"%@&productTypeId=%@",searchMCategory(),x]
#define searchProductList(sKey,sortType,sessionId,brandId) ((NSNull *)brandId==[NSNull null])?[NSString stringWithFormat:@"%@getProductList?productTypeId=%@&sortType=%@&sessionId=%@",ProductServicePrefix,sKey,sortType,sessionId]:[NSString stringWithFormat:@"%@getProductList?productTypeId=%@&sortType=%@&productBrandId=%@&sessionId=%@",ProductServicePrefix,sKey,sortType,brandId,sessionId]
#define searchProductBrandList(sKey) [NSString stringWithFormat:@"%@getProductBrandList?productTypeId=%@",ProductServicePrefix,sKey]

#define searchProductDetailInfo(productKey) [NSString stringWithFormat:@"%@getProductInfo?productId=%@",ProductServicePrefix,productKey]
#define searchPromoteList() [NSString stringWithFormat:@"%@getPromotionEventList",CommonServicePrefix]
#define searchPromotionDetailInfo(x) [NSString stringWithFormat:@"%@getPromotionEventInfo?eventId=%@",CommonServicePrefix,x]

#define DefaultSubCatalogKey @"B871B415-DBD4-413C-8976-403353EF6A1D"
#define DefaultSortType @"1"

#define CatalogTemplateNotification @"CatalogTemplateNofitication"
#define getBrandFilter(x,y) [NSString stringWithFormat:@"%@getBrandFilter?sortType=%d&productTypeId=%@",ProductServicePrefix, x,y]
#define getPriceFilter(x) [NSString stringWithFormat:@"%@getPriceFilter?sortType=1&productTypeId=%@",ProductServicePrefix, x]
#define getColorFilter(x) [NSString stringWithFormat:@"%@getColorFilter?sortType=1&productTypeId=%@",ProductServicePrefix, x]
#define searchPromotionProductList(x) [NSString stringWithFormat:@"%@getPromotionProductList?sessionId=%@",ProductServicePrefix, x]
#define searchProductBrandList(sKey) [NSString stringWithFormat:@"%@getProductBrandList?productTypeId=%@",ProductServicePrefix,sKey]
#define searchProductDetailInfo(productKey) [NSString stringWithFormat:@"%@getProductInfo?productId=%@",ProductServicePrefix,productKey]

#define searchPromotionDetailInfo(x) [NSString stringWithFormat:@"%@getPromotionEventInfo?eventId=%@",CommonServicePrefix,x]
#define loginQuery(x,y) [NSString stringWithFormat:@"%@login?loginId=%@&password=%@",AccountServicePrefix,x,y]
#define activeAccountQuery(x,y) [NSString stringWithFormat:@"%@activation?code=%@&phone=%@",AccountServicePrefix,x,y]
#define logoutQuery(x) [NSString stringWithFormat:@"%@logout?sessionId=%@",AccountServicePrefix,x]
#define getMemberInfoQuery(x) [NSString stringWithFormat:@"%@getMemberInfo?sessionId=%@",MemberServicePrefix,x]
#define getEmployeeInfoQuery(x) [NSString stringWithFormat:@"%@getEmployeeInfo?sessionId=%@",EmployeeServicePrefix,x]
#define forgetPwdQuery(x,y) [NSString stringWithFormat:@"%@forgetPassword?code=%@&phone=%@",AccountServicePrefix,x,y]
#define activationQuery(x,y) [NSString stringWithFormat:@"%@activation?code=%@&phone=%@",AccountServicePrefix,x,y]
#define changePwdQuery(x,y,z) [NSString stringWithFormat:@"%@changePassword?sessionId=%@&oldPassword=%@&newPassword=%@",AccountServicePrefix,x,y,z]
#define getSessionInfoQuery(x) [NSString stringWithFormat:@"%@getSessionInfo?sessionId=%@",AccountServicePrefix,x]
#define getOnlineSessionQuery [NSString stringWithFormat:@"%@getOnlineSessions",AccountServicePrefix]

#define orderListQuery(x) [NSString stringWithFormat:@"%@getOrderList?sessionId=%@",OrderServicePrefix,x]
#define orderInfoQuery(x) [NSString stringWithFormat:@"%@getOrderInfo?orderId=%@",OrderServicePrefix,x]
#define coinIdentify @"￥"

#define DefaultSubCatelogString @"客廳 > 空調"
#define DefaultSortType @"1"

//Notification name
#define CatalogTemplateNotification @"CatalogTemplateNofitication"
#define dismissPopover @"dismissPopover"
#define ShiftComparePanel @"ShiftComparePanel"

#define DefaultFontName @"STHeitiTC-Light"

#define ninepatch(CGSize,ninePatchName) [TUNinePatchCache imageOfSize:CGSize forNinePatchNamed:ninePatchName]

#define kOFFSET_FOR_KEYBOARD 60.0
#define webserviceNotif @"webserviceNotification"
#define TYPE_EMPLOYE @"E"
#define TYPE_MEMBER @"M"

#define SHOW_ACTIVITY_INDICATOR @"ShowActivityIndicator"
#define CLOSE_ACTIVITY_INDICATOR @"CloseActivityIndicator"
#define SESSION_ERROR @"SessionError"

typedef enum{
    ACTIVATIONFOREGETVIEW_ACTIVE = 0,
    ACTIVATIONFOREGETVIEW_FORGET = 1
    }activeForgetViewIndex;
@implementation UITabBar (CustomImage)
-(void)drawRect:(CGRect)rect{
	UIImage *image=[UIImage imageNamed:@"content_ui_underbar.png"];
	[image drawInRect:CGRectMake( 0, -11, self.frame.size.width, 69)];
}
@end