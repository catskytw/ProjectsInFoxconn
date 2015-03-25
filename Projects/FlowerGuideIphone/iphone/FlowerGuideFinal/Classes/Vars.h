//
//  Vars.h
//  FlowerGuide
//
//  Created by Change Liao on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#define DEBUG_MODE 1
#define QRCODE 1
//#define SHOWMEM 1
//是否使用prefix來接image
#define USEPREFIXIMAGE 1
//#define HASTIMESTAMP 1
#define USELITTLEENDIAN 1

//notification name
#define MapDrawingNotificationName @"mapdrawNotification"
#define MapCancelWalking @"cancelWalk"
#define MapForwardWalking @"forwardWalk"
#define ResetBackgroundView @"resetBackgroundView"
#define SetImageStyle @"setImageStyle"
#define SetImageStyleBig @"setImageStyleBig"
#define PopupWindow @"popupWindow"
//花協對外ip 114.34.161.145
#define URLHead @"http://10.62.13.2:8080"
#define DefaultUrlString [NSString stringWithFormat:@"%@%@",URLHead,@"/service/pavilionService."]

//多國語系
//#define DEFAULTLANG @"ja_JP"
#define DEFAULTLANG @"zh_TW"
//#define DEFAULTLANG @"en_US"
#define AndLangSurfix [NSString stringWithFormat:@"&LANG=%@",DEFAULTLANG]
#define InterrLangSurfix [NSString stringWithFormat:@"?LANG=%@",DEFAULTLANG]
enum MapDataTypeNum {
	MapDataTypeIdx=1,
	MapDataTypeDat=2
};

enum FeatureTypeNum{
	FeatureTypePoint=0,
	FeatureTypeLine=1,
	FeatureTypeRegion=2
};

enum pointType{
	regionPointType=0,
	pointPointType=1,
	plantPointType=2
};

enum directionPoint{
	directionNone=0,
	directionLeft=1,
	directionUp=2,
	directionRight=3,
	directionDown=4
};

enum DescriptionType{
	DescriptionTypeSubject=0,
	DescriptionTypeContent=1
};

enum CellHeightStyle{
	CellHeightStyleMedium=54,
	CellHeightStyleHuge=110
};

@interface Vars : NSObject {

}

@end
