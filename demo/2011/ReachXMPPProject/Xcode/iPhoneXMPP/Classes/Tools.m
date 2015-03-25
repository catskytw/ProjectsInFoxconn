//
//  Tools.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "Tools.h"
static UIView *waitView;
@implementation Tools
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize{
	CGSize maxSize=CGSizeMake(768, fontSize);
	return [examString sizeWithFont:[UIFont fontWithName:@"STHeitiTC-Light" size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize{
	return [examString sizeWithFont:[UIFont fontWithName:@"STHeitiTC-Light" size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(CGSize)estimateStringSize:(NSString*)examString withFontSize:(CGFloat)fontSize withMaxSize:(CGSize)maxSize withFontName:(NSString*)fontName{
	return [examString sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
}
+(UIColor*)convertString2UIColor:(NSString*)colorString{
    //the colorString's syntax: #ffffff
    if([colorString isEqualToString:@"-"])
        return [UIColor clearColor];
    unsigned r=0,g=0,b=0;
    NSScanner *scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&r];
    scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&g];
    scanner=[NSScanner scannerWithString:[colorString substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&b];
    return [UIColor colorWithRed:(CGFloat)r/255.0f green:(CGFloat)g/255.0f blue:(CGFloat)b/255.0f alpha:1];
}


@end
