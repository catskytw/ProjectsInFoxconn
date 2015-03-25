//
//  FcDrawing.m
//  FcUILibrary
//
//  Created by 廖 晨志 on 2011/8/9.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcDrawing.h"
#import "Tools.h"

@implementation FcDrawing
+(UIImage*)loadUIImage:(NSString*)fileName withType:(NSString*)fileType{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [UIImage imageWithData:data];
}

+(UIImage*)blendTextureMask:(UIImage*)iconImage withImage:(UIImage*)textureImage{
    UIGraphicsBeginImageContext(iconImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    
    CGRect region = CGRectMake(0, 0, iconImage.size.width, iconImage.size.height);
    CGContextTranslateCTM(context, 0, -region.size.height);
    CGContextSaveGState(context);
    //可以有保留透明背景的效果
    CGContextClipToMask(context, region, iconImage.CGImage);
    
    //將材質紋理與原影像混和
    CGContextDrawImage(context, region, textureImage.CGImage);
    CGContextRestoreGState(context);
    CGContextSetBlendMode(context, kCGBlendModeColor);
    CGContextDrawImage(context, region, iconImage.CGImage);
    
    //將影像指定給image
    UIImage *returnImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

+(UIImage*)clipTextureMask:(UIImage*)maskImage withImage:(UIImage*)iconImage{
    UIGraphicsBeginImageContext(iconImage.size);
    
    //設定參考範圍
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    
    CGRect region = CGRectMake(0, 0, iconImage.size.width, iconImage.size.height);
    CGContextTranslateCTM(context, 0, -region.size.height);
    
    //將context做遮罩範圍的切割再draw
    CGContextClipToMask(context, region, maskImage.CGImage);
    CGContextDrawImage(context, region, iconImage.CGImage);
    
    //將影像指定給imageView
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
 	return returnImage;
}

+(UIImage*)drawDeviceGrayImage:(UIImage*)sampleImage{
    CGRect myRect=CGRectMake(0, 0, sampleImage.size.width, sampleImage.size.height);
    CGColorSpaceRef colorSpaceRef=CGColorSpaceCreateDeviceGray();
    CGContextRef context=CGBitmapContextCreate(NULL,myRect.size.width, myRect.size.height,8, myRect.size.width,colorSpaceRef,kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpaceRef);
    
    CGContextDrawImage(context, myRect, [sampleImage CGImage]);
    
    CGImageRef imageRef=CGBitmapContextCreateImage(context);
    UIImage *returnImage=[UIImage imageWithCGImage:imageRef];
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return returnImage;
    
}

+(UIImage*)drawImageWithPattern:(NSString*)patternFileName withSize:(CGSize)i_size{
    UIGraphicsBeginImageContext(i_size);
    CGContextRef contextRef=UIGraphicsGetCurrentContext();
    UIColor *myPatternColorB = [UIColor colorWithPatternImage:[UIImage imageNamed:patternFileName]];
    CGContextSetFillColorWithColor(contextRef, myPatternColorB.CGColor);
    CGContextMoveToPoint(contextRef, 0, 0);
    CGContextAddLineToPoint(contextRef, i_size.width,0);
    CGContextAddLineToPoint(contextRef, i_size.width,i_size.height);
    CGContextAddLineToPoint(contextRef, 0, i_size.height);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathFill);
    
    UIImage *returnImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}

+(UIImage*)merge2Images:(UIImage*)firstImage withImage:(UIImage*)secondImage withSize:(CGSize)imageSize{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [firstImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    [secondImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height) blendMode:kCGBlendModeNormal alpha:1.0];
     UIImage *r=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return r;
}
@end
