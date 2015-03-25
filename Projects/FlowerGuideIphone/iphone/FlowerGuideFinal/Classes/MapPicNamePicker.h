//
//  PicNamePicker.h
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MapPicNamePicker : NSObject {

}
+(NSString*)getTreePicName:(NSInteger)bitmapId;
+(NSString*)getPointPicName:(NSInteger)bitmapId withFeatureId:(NSInteger)featureId;
+(NSString*)getPOIBtnImage:(NSInteger)featureId;
@end
