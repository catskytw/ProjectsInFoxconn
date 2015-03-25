//
//  PicNamePicker.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPicNamePicker.h"
#import "AllContentPointProperties.h"

@implementation MapPicNamePicker
+(NSString*)getTreePicName:(NSInteger)bitmapId{
	return (bitmapId>8)?[NSString stringWithFormat:@"mapui_icon_tree_%i.png",bitmapId+1]:
	[NSString stringWithFormat:@"mapui_icon_tree_0%i.png",bitmapId+1];
}
+(NSString*)getPointMarkString:(NSInteger)featureId{
	return (featureId>9)?[NSString stringWithFormat:@"%i",featureId]:[NSString stringWithFormat:@"0%i",featureId];
}

/**
 bitmapID
 0:內容點
 1:出入口
 2:服務處
 3:廁所
 */
+(NSString*)getPointPicName:(NSInteger)bitmapId withFeatureId:(NSInteger)featureId{
	NSString *resultString=nil;
	switch (bitmapId) {
		case 0:
			resultString=[MapPicNamePicker getPOIBtnImage:featureId];
			break;
		case 1:
			resultString=@"mapui_icon_facility_exit.png";
			break;
		case 2:
			resultString=@"mapui_icon_facility_information.png";
			break;
		case 3:
			resultString=@"mapui_icon_facility_toilet.png";
			break;
		case 4:
			break;
		default:
			break;
	}
	return resultString;
}

+(NSString*)getPOIBtnImage:(NSInteger)featureId{
	AllContentPointProperties *allContent=[AllContentPointProperties current];
	for(IndicatePointPassObject *indicatePoint in allContent.allPoint){
		if(indicatePoint.featureId==featureId){
			if(indicatePoint.isScaned==YES)
				return @"mapui_icon_point_03.png";
			else if(indicatePoint.isPassed==YES)
				return @"mapui_icon_point_02.png";
			else
				return @"mapui_icon_point_01.png";
		}
	}
	return @"mapui_icon_point_01.png";
}
@end
