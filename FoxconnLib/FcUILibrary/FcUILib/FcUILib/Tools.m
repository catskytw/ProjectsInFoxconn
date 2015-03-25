//
//  Tools.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(CGContextRef)createBitmapContext:(NSInteger)pixelsWide withHeight:(NSInteger)pixelsHigh{
	CGContextRef    context = NULL; 
    CGColorSpaceRef colorSpace; 
    int             bitmapByteCount; 
    int             bitmapBytesPerRow; 
    bitmapBytesPerRow   = (pixelsWide * 4); 
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh); 
    colorSpace = CGColorSpaceCreateDeviceRGB();	
    context = CGBitmapContextCreate (NULL, 
									 pixelsWide, 
									 pixelsHigh, 
									 8,      // bits per component 
									 bitmapBytesPerRow, 
									 colorSpace, 
									 kCGImageAlphaPremultipliedFirst); 
    if (context== NULL) 
    { 
        fprintf (stderr, "Context not created!"); 
        return NULL; 
    } 
    CGColorSpaceRelease( colorSpace ); 
	colorSpace=NULL;
    return context; 	
}

+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize{
	CGSize maxSize=CGSizeMake(768, fontSize);
	return [examString sizeWithFont:[UIFont fontWithName:DefaultFontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize{
	return [examString sizeWithFont:[UIFont fontWithName:DefaultFontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
@end
