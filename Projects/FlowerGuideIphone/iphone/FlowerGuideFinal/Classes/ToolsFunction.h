//
//  ToolsFunction.h
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 2009/11/3.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsFunction : NSObject {

}
+(int)getIntFromLittleNSData:(NSData*)data;
+(NSArray*)getOneASCSortDescriptor:(NSString*)key;
+(NSArray*)getOneDeascSortDescriptor:(NSString*)key;
+(void)getImageFromURL:(NSString*)urlString withTargetUIImageView:(UIImageView*)targetImageView;
+(void)getImageFromURL:(NSString*)urlString withTargetButton:(UIButton*)targetButton;
+(void)getImageFromURL:(NSString*)urlString withTargetUIImageView:(UIImageView*)targetImageView withNotificationString:(NSString*)notificationString;
+(CGSize)getContentTextSize:(NSString*)stringText withWidth:(NSInteger)width withFontSize:(NSInteger)fontSize;
+(CGSize)getContentTextWidthSize:(NSString*)stringText withHeight:(NSInteger)height withFontSize:(NSInteger)fontSize;
+(UIImage*)getBatteryImage:(NSInteger)batteryIndex;
+(BOOL)conntectedToNetwork;
+(BOOL)hasConnected;
+(BOOL)hasCorrectJSON:(NSString*)checkString;
+(void)report_memory;
+(NSString*)currentMillionSec;
+(double)getCurrentTime;
+(void)delWaitCursor;
+(void)addWaitCursor;
@end