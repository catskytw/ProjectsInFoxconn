//
//  DrawFunctions.m
//  FlowerGuideCocos2d
//
//  Created by Change Liao on 3/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrawFunctions.h"


@implementation DrawFunctions
/**
 取得一塊bitmap ContextRef
 */
//CGContextRef createBitmapContext (int pixelsWide, 
//									int pixelsHigh) 
//{ 
//    CGContextRef    context = NULL; 
//    CGColorSpaceRef colorSpace; 
//    int             bitmapByteCount; 
//    int             bitmapBytesPerRow; 
//    bitmapBytesPerRow   = (pixelsWide * 4); 
//    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh); 
//    colorSpace = CGColorSpaceCreateDeviceRGB();
//
//    context = CGBitmapContextCreate (NULL, 
//									 pixelsWide, 
//									 pixelsHigh, 
//									 8,      // bits per component 
//									 bitmapBytesPerRow, 
//									 colorSpace, 
//									 kCGImageAlphaPremultipliedFirst); 
//    if (context== NULL) 
//    { 
//        fprintf (stderr, "Context not created!"); 
//        return NULL; 
//    } 
//    CGColorSpaceRelease( colorSpace ); 
//	colorSpace=NULL;
//    return context; 
//} 

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
+(CGImageRef)createMessageBk:(CGSize)mySize{
	float radius=4.0f;
	CGContextRef thisRef=[self createBitmapContext:mySize.width withHeight:mySize.height];
	CGContextSetRGBFillColor(thisRef, 0.136, 0.098, 0.086, 0.8);
	CGContextSetRGBStrokeColor(thisRef, 0.136, 0.098, 0.086, 0.8);
	CGRect rect=CGRectMake(0, 0, mySize.width, mySize.height);
	
	CGContextBeginPath(thisRef);
	CGContextMoveToPoint(thisRef, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
    CGContextAddArc(thisRef, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(thisRef, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(thisRef, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(thisRef, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);	
    CGContextClosePath(thisRef);
	CGContextDrawPath(thisRef, kCGPathFillStroke);
	
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}
+(CGImageRef)createToolBarBackgroundWithNum:(NSInteger)num{
	float radius=7.0f;
	CGContextRef thisRef=[self createBitmapContext:60 withHeight:num*60+4];

	CGContextSetRGBFillColor(thisRef, 0.4, 0.4, 0.4, 0.7);
	CGContextSetRGBStrokeColor(thisRef, 0, 0, 0.7, 0.7);
	CGRect rect=CGRectMake(0, 0, 60, num*60+4);
	
	CGContextBeginPath(thisRef);
	CGContextMoveToPoint(thisRef, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
    CGContextAddArc(thisRef, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(thisRef, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(thisRef, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(thisRef, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);	
    CGContextClosePath(thisRef);
	CGContextDrawPath(thisRef, kCGPathFill);
	
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}
+(CGImageRef)createSelectorImage:(NSInteger)width withHeight:(NSInteger)height{
	CGContextRef thisRef=[self createBitmapContext:width withHeight:height];
	CGContextClearRect(thisRef, CGRectMake(0, 0, width, height));
	CGContextSetRGBStrokeColor(thisRef,1, 1, 1, 1);
	CGContextSetLineWidth(thisRef, 3.0f);
	CGContextStrokeRect(thisRef, CGRectMake(0, 0, width,height));
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}
+(CGImageRef)createYellowRect:(NSInteger)width withHeight:(NSInteger)height{
	CGContextRef thisRef=[self createBitmapContext:width withHeight:height];
	CGContextSetRGBFillColor(thisRef, 1, 1, 0, 1);
	CGContextFillRect(thisRef,CGRectMake(0, 0, width, height));
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}

+(CGImageRef)createThermographRedball:(NSInteger)radius{
	CGContextRef thisRef=[self createBitmapContext:radius withHeight:radius];
	CGContextSetRGBFillColor(thisRef, 1, 0, 0, 1);
	CGContextFillEllipseInRect(thisRef, CGRectMake(0, 0, radius, radius));
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}
+(CGImageRef)createThermographLength:(NSInteger)temperature{
	NSInteger height=(temperature+100)/6;
	CGContextRef thisRef=[self createBitmapContext:5 withHeight:height];
	CGContextSetRGBFillColor(thisRef, 1, 0, 0, 1);
	CGContextFillRect(thisRef,CGRectMake(0, 0, 2, height));
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}

+(CGImageRef)createWhiteLine:(NSInteger)width{
	CGContextRef thisRef=[self createBitmapContext:width withHeight:3];
	CGContextSetRGBStrokeColor(thisRef, 1, 1, 1, 1);
	CGContextSetLineWidth(thisRef,3.0f);
	CGContextMoveToPoint(thisRef, 0, 1);
	CGContextAddLineToPoint(thisRef, width, 1);
	CGContextStrokePath(thisRef);
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}
+ (UIImage *)imageWithString:(NSString *)string // What we want an image of.
						font:(UIFont *)font // The font we'd like it in.
						size:(CGSize)size // Size of the desired image.
{
	// Create a context to render into.
	UIGraphicsBeginImageContext(size);
	
	// Work out what size of font will give us a rendering of the string
	// that will fit in an image of the desired size.
	
	// We do this by measuring the string at the given font size and working
	// out the ratio scale to it by to get the desired size of image.
	
	// Measure the string size.
	CGSize stringSize = [string sizeWithFont:font];
	
	// Work out what it should be scaled by to get the desired size.
	CGFloat xRatio = size.width / stringSize.width;
	CGFloat yRatio = size.height / stringSize.height;
	CGFloat ratio = MIN(xRatio, yRatio);
	
	// Work out the point size that'll give us the desired image size, and
	// create a UIFont that size.
	CGFloat oldFontSize = font.pointSize;
	CGFloat newFontSize = floor(oldFontSize * ratio);
	ratio = newFontSize / oldFontSize;
	font = [font fontWithSize:newFontSize];
	
	// What size is the string with this newfont?
	
	stringSize = [string sizeWithFont:font];
	
	
	
	// Work out where the origin of the drawn string should be to get it in
	
	// the centre of the image.
	CGPoint textOrigin = CGPointMake((size.width - stringSize.width) / 2,
									 (size.height - stringSize.height) / 2);
	
	// Draw the string into out image.
	[string drawAtPoint:textOrigin withFont:font];
	
	// We actually don't have the scaling right, because the rendered
	// string probably doesn't actually fill the entire pixel area of the
	// box we were given. We'll use what we just drew to work out the /real/
	// size we need to draw at to fill the image.
	
	// First, we work out what area the drawn string /actually/ covered.
	
	// Get a raw bitmap of what we've drawn.
	CGImageRef maskImage = [UIGraphicsGetImageFromCurrentImageContext()
							CGImage];
	CFDataRef imageData = CGDataProviderCopyData(
												 CGImageGetDataProvider(maskImage));
	uint8_t *bitmap = (uint8_t *)CFDataGetBytePtr(imageData);
	size_t rowBytes = CGImageGetBytesPerRow(maskImage);
	
	// Now, go through the pixels one-by-one working out the area in which the
	// image is not still blank.
	size_t minx = size.width, maxx = 0, miny = size.height, maxy = 0;
	uint8_t *rowBase = bitmap;
	for(size_t y = 0; y < size.width; ++y, rowBase += rowBytes) {
		uint8_t *component = rowBase;
		for(size_t x = 0; x < size.width; ++x, component += 4) { 
			if(*component != 0) {
				if(x < minx) {
					minx = x;
				} else if(x > maxx) {
					maxx = x;
				}
				if(y < miny) {
					miny = y;
				} else if(y > maxy) {
					maxy = y;
				}
			}
		}
	}
	CFRelease(imageData); // We're done with this data now.
	
	// Put the area we just found into a CGRect.
	CGRect boundingBox =
	CGRectMake(minx, miny, maxx - minx + 1, maxy - miny + 1);
	
	// We're going to have to move string we're drawing as well as scale it,
	// so we work out how the origin we used to draw the string relates to the
	// 'real' origin of the filled area.
	CGPoint goodBoundingBoxOrigin =
	CGPointMake((size.width - boundingBox.size.width) / 2,
				(size.height - boundingBox.size.height) / 2);
	CGFloat textOriginXDiff = goodBoundingBoxOrigin.x - boundingBox.origin.x;
	CGFloat textOriginYDiff = goodBoundingBoxOrigin.y - boundingBox.origin.y;
	
	// Work out how much we'll need to scale by to fill the entire image.
	xRatio = size.width / boundingBox.size.width;
	yRatio = size.height / boundingBox.size.height;
	ratio = MIN(xRatio, yRatio);
	
	// Now, work out the font size we really need based on our scaling ratio.
	// newFontSize is still holding the size we used to draw with.
	oldFontSize = newFontSize;
	newFontSize = floor(oldFontSize * ratio);
	ratio = newFontSize / oldFontSize;
	font = [font fontWithSize:newFontSize];
	
	// Work out where to place the string.
	// We offset the origin by the difference between the string-drawing origin
	// and the 'real' image origin we measured above, scaled up to the new size.
	stringSize = [string sizeWithFont:font];
	textOrigin = CGPointMake((size.width - stringSize.width) / 2,
							 (size.height - stringSize.height) / 2); 
	textOrigin.x += textOriginXDiff * ratio;
	textOrigin.y += textOriginYDiff * ratio;
	
	// Clear the context to remove our old, too-small, rendering.
	CGContextClearRect(UIGraphicsGetCurrentContext(),
					   CGRectMake(0, 0, size.width, size.height));
	
	// Draw the string again, in the right place, at the right size this time!
	[string drawAtPoint:textOrigin withFont:font];
	
	// We're done! Grab the image and return it!
	// (Don't forget to end the image context first though!)
	UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return retImage;
}

+(CGImageRef)createWhiteBKFont:(NSString*)context withFontSize:(float)fontSize withSize:(CGSize)rectSize withPanWidth:(NSInteger)space{
	int startX=3;
	int startY=4;
	CGContextRef thisRef=[self createBitmapContext:rectSize.width+space withHeight:rectSize.height+space];
    CGContextSelectFont (thisRef, "Arial", rectSize.height,kCGEncodingMacRoman); 
	CGContextSetFontSize(thisRef, fontSize);
	CGContextSetTextDrawingMode (thisRef, kCGTextFillStroke); 
	//鋪白底
	CGContextSetRGBStrokeColor(thisRef, 1, 1, 1, 1);
	CGContextSetLineWidth(thisRef, space);
	CGContextShowTextAtPoint(thisRef, startX, startY, [context UTF8String], [context lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	//畫清楚的字
	CGContextSetRGBFillColor(thisRef, 1, 0, 0, 1);
	CGContextSetLineWidth(thisRef, 0);
	CGContextShowTextAtPoint(thisRef, startX, startY, [context UTF8String], [context lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	
	
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}

+(CGImageRef)createGreenRect:(NSInteger)width withHeight:(NSInteger)height{
	CGContextRef thisRef=[self createBitmapContext:width withHeight:height];
	CGContextSetRGBFillColor(thisRef, 0.1797f, 0.625f, 0.5273f, 1);
	CGContextFillRect(thisRef,CGRectMake(0, 0, width, height));
	CGImageRef imageRef=CGBitmapContextCreateImage(thisRef);
	CGContextRelease(thisRef);
	return imageRef;
}


+(void) createAndDrawBitmapImage:(CGContextRef)myContext withRect:(CGRect)myContextRect withImageRef:(CGImageRef)image withTitle:(NSString*)title withTitleSize:(CGSize)titleSize withTitleYAxisInsect:(NSInteger)yInsect{ 
	CGContextDrawImage (myContext, myContextRect, image); 

	// draw title
	if(title!=nil){
		CGContextSelectFont (myContext, "Arial", titleSize.height,kCGEncodingMacRoman); 
		CGContextSetFontSize(myContext, 22.0f);
		CGContextSetTextDrawingMode (myContext, kCGTextFillStroke); 
		
		CGContextSetRGBFillColor(myContext, 1.0f, 1.0f, 1.0f, 1.0f);
		CGContextSetLineWidth(myContext, 0);
		CGContextShowTextAtPoint(myContext, (myContextRect.size.width-titleSize.width)/2, myContextRect.size.height/2 + yInsect, [title UTF8String], [title lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);		
	}
} 
@end
