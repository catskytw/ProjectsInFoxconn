//
//  FcDrawing.h
//  FcUILibrary
//
//  Created by 廖 晨志 on 2011/8/9.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FcDrawing : NSObject {
    
}
/**
 loadUIImage:使用NSData方式讀取image,避免[UIImage imageName:]造成cache過大
*/
+(UIImage*)loadUIImage:(NSString*)fileName withType:(NSString*)fileType;

/**
 使用mask來切割材質
 */
+(UIImage*)clipTextureMask:(UIImage*)maskImage withImage:(UIImage*)iconImage;
    
/**
 clipTextureMas:
 混合材質與遮罩的效果
 */
+(UIImage*)blendTextureMask:(UIImage*)iconImage withImage:(UIImage*)textureImage;

/**
 去除alpha channel
 */
+(UIImage*)drawDeviceGrayImage:(UIImage*)sampleImage;

/**
 以底圖pattern做出uiimage
 */
+(UIImage*)drawImageWithPattern:(NSString*)patternFileName withSize:(CGSize)i_size;

/**將兩張uiimage合併成一張
 */
+(UIImage*)merge2Images:(UIImage*)firstImage withImage:(UIImage*)secondImage withSize:(CGSize)imageSize;
@end
