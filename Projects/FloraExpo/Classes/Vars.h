//
//  Vars.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//  Ç

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocalizationSystem.h"
/*****************************
 如果非測試,
 以下兩個define應mark
 *****************************/

//#define DEBUG_MODE 0
//#define USE_TEST_SERVER

/*****************************
 common define
 DON'T MARK unless you know what you are doing!
 *****************************/
#define BARBUTTON(TITLE,SELECTOR) [[[UIBarButtonItem alloc]initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]autorelease]
#define DefaultTintNavigationButtonColor [UIColor colorWithRed:(CGFloat)0/256 green:(CGFloat)151/256 blue:(CGFloat)165/256 alpha:1]
#define DefaultCategoryString [NSString stringWithString:AMLocalizedString(@"NotCategoryDirectory",nil)]
#define NullPOIPosition [Vars NullPOILocation]
#define TaipeiStationPosition [Vars TaipeiStationLocation]
#define MarketPosition [Vars MarketLocation]
#define DefaultCellSelectedBackground @"contentui_btn_menu_green_i.png"
#define DefaultLanguage @"1"
#ifdef DEBUG_MODE
#define DefaultUserId @"0922654321"
#else
#define DefaultPreUserId [[NSUserDefaults standardUserDefaults]stringForKey:@"SBFormattedPhoneNumber"]
#define DefaultUserId (DefaultPreUserId==nil)?@"guest":DefaultPreUserId
#endif
//domain name是mota.taipei.gov.tw
//正式ip: 163.29.36.98
//測試ip: 59.124.89.21
#ifdef USE_TEST_SERVER
#define DefaultUrlString @"http://59.124.89.21/FloraQuery/Query.aspx?method="
#else
#define DefaultUrlString @"http://163.29.36.98/FloraQuery/Query.aspx?method="
#endif

#define ALERTMSGURL @"http://mota.taipei.gov.tw/Intro/floraexposition.html"
enum StationType{
	StationTypeStart=0,
	StationTypeNormal=1,
	StationTypeEnd=2
};

enum BusLineType {
	BusLineRed=0,
	BusLineBlue=1,
	BusLineBrown=2,
	BusLineGreen=3,
};

enum QueryType{
	TrainType=0,
	HighSpeedType=1,
	BusType=2,
	MRTType=3
};

enum CrossLineType{
	CrossLineTypeNone=0,
	CrossLineTypeRedBlue=1,
	CrossLineTypeRedGreen=2
};

enum tableType{
	FloraExpoContent=1,
	News=2,
	AboutFlora=3,
	HotelArea=4,
	FlowerInfo=5,
	Exhibition=6,
	HotelList=7,
	ExhibitionInfo=8
};

enum DescriptionType {
	DescriptionTypeTitle=1,
	DescriptionTypeContent=2,
	DescriptionTypeWebView=3
};

enum poiType {
	poiBusType=1,
	poiHighSpeedType=2,
	poiParkType=3,
	poiTrainType=4,
	poiTRTCType=5,
	poiMainPositionType=6
};

enum myFavoriteQueryType{
	busQuery=0,
	parkingQuery=1,
	govermentQuery=2,
	financeQuery=3,
	educationQuery=4,
	enterTainmentQuery=5,
	accommodationQuery=6,
	transportationQuery=7,
	noneQuery=8
};

enum cellHeightType {
	cellHeightTypeSmall=50,
	cellHeightTypeMedium=58,
	cellHeightTypeLarge=64
};
@interface Vars : NSObject {

}
+(CLLocationCoordinate2D)NullPOILocation;
+(CLLocationCoordinate2D)TaipeiStationLocation;
+(CLLocationCoordinate2D)locationWithLat:(double)latitude withLong:(double)longitude;
+(NSString*)emptyOrOriginString:(NSString*)originString;
@end
