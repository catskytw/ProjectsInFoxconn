//
//  FcConfig.h
//  PIM_cocos2d
//
//  Created by 廖 晨志 on 2011/7/28.
//  Copyright 2011年 foxconn. All rights reserved.
//
#import "NSFormatterExtend.h"
#define USE_iOS5_FIX_PROBLEM
#define USE_QUARTZ 1
#define GroupCellWidth 274
#define GroupCellHeight 42
#define GroupCellLabelDiff_Left 8
#define GroupCellLabel_Space 6
#define GroupCellLabelDiff_Right 8
#define GroupCellLabelY_Font16 12
#define ccp(__X__,__Y__) CGPointMake(__X__,__Y__)
#define ccs(__X__,__Y__) CGSizeMake(__X__,__Y__)
#define createUUID() [Tool createUUID]
#define DefaultFontName @"STHeitiTC-Light"
#define DefaultBoldFontName @"STHeitiTC-Medium"

#define CLOSE_ACTIVITY_INDICATOR @"CLOSE_ACTIVITY_INDICATOR"
#define SHOW_ACTIVITY_INDICATOR @"SHOW_ACTIVITY_INDICATOR"
#define CLOSE_ACTIVITY_INDICATOR_GOOGLEMAP @"CLOSE_ACTIVITY_INDICATOR_GOOGLEMAP"
#define CLEAR_COMPANY_WINDOW @"CLEAR_COMPANY_WINDOW"
#define RESET_REGISTERREC_INFO @"RESET_REGISTERREC_INFO"
#define USING_LOCATION @"USING_LOCATION"
#define GeoCodeService [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/"]
#define reGeoCode(latitude,longitude) [NSString stringWithFormat:@"%@json?latlng=%f,%f&sensor=false",GeoCodeService,latitude,longitude]

typedef enum{
    FcGroupTableCellMode_MIDDLE = 0, //中
    FcGroupTableCellMode_TOP,      //上
    FcGroupTableCellMode_BUTTON,
}FcGroupTableCellMode;


static inline CGPoint
ccpAdd(const CGPoint v1, const CGPoint v2)
{
	return ccp(v1.x + v2.x, v1.y + v2.y);
}

static inline CGPoint
ccpSub(const CGPoint v1, const CGPoint v2)
{
	return ccp(v1.x - v2.x, v1.y - v2.y);
}

static inline CGRect
ccRectShift(const CGRect v1, const CGPoint v2)
{
    return CGRectMake(v1.origin.x+v2.x, v1.origin.y+v2.y, v1.size.width, v1.size.height);
}
static inline CGRect 
ccRectBackBtn(){
    return CGRectMake(15.0, 7.0, 57, 30);
}
static inline CGRect 
ccRectAddBtn(){
    return CGRectMake(15.0, 7.0, 50, 30);
}
static inline CGRect 
ccRectEditBtn(){
    return CGRectMake(255.0, 7.0, 50, 30);
}
static inline CGRect 
ccRectPathBtn(){
    return CGRectMake(245.0, 7.0, 70, 30);
}
static inline CGFloat
realRadian(CGFloat _radian)
{
    if (_radian>2*M_PI)
        return realRadian(_radian-(2*M_PI));
    else if(_radian<0)
        return realRadian(_radian+(2*M_PI));
    return _radian;
}
static inline CGRect		
fixBlurryRect(CGRect originRect)		
{		
    return CGRectMake(ceilf(originRect.origin.x), ceilf(originRect.origin.y), ceilf(originRect.size.width), ceilf(originRect.size.height));		
}

/*
 *  System Versioning Preprocessor Macros
 */ 

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)