//
//  DrawFunctions.h
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DrawFunctions : NSObject {

}
+(CGContextRef)createBitmapContext:(NSInteger)pixelsWide withHeight:(NSInteger)pixelsHigh;

+(CGImageRef)createYellowRect:(NSInteger)width withHeight:(NSInteger)height;
+(CGImageRef)createSelectorImage:(NSInteger)width withHeight:(NSInteger)height;
+(CGImageRef)createToolBarBackgroundWithNum:(NSInteger)num;
+(CGImageRef)createThermographRedball:(NSInteger)radius;
+(CGImageRef)createThermographLength:(NSInteger)temperature;
+(CGImageRef)createMessageBk:(CGSize)mySize;
+(CGImageRef)createWhiteLine:(NSInteger)width;
+(CGImageRef)createWhiteBKFont:(NSString*)context withFontSize:(float)fontSize withSize:(CGSize)rectSize withPanWidth:(NSInteger)space;
+(UIImage *)imageWithString:(NSString *)string // What we want an image of.
						font:(UIFont *)font // The font we'd like it in.
						size:(CGSize)size; // Size of the desired image.
+(CGImageRef)createGreenRect:(NSInteger)width withHeight:(NSInteger)height;
+(void) createAndDrawBitmapImage:(CGContextRef)myContext withRect:(CGRect)myContextRect withImageRef:(CGImageRef)image withTitle:(NSString*)title withTitleSize:(CGSize)titleSize withTitleYAxisInsect:(NSInteger)yInsect;
@end
