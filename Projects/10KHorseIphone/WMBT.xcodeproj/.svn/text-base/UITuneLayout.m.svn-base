//
//  UITuneLayout.m
//  WMBT
//
//  Created by link on 2011/6/2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UITuneLayout.h"
#import "LocalizationSystem.h"

@implementation UITuneLayout
//set Navigation bar title font 
+(void) setNaviTitle: (id)controller{
    CGRect frame = CGRectMake(0,0, 180, 44);
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.backgroundColor = [UIColor clearColor];
    //label.font = [UIFont boldSystemFontOfSize:21];
    [label setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:21.0]];
    label.shadowColor = [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor= [UIColor colorWithRed:25/255.f green:25/255.f blue:25/255.f alpha:1];
    UIViewController *ctrl = (UIViewController*)controller;
    ctrl.navigationItem.titleView = label;
    label.text= ctrl.navigationItem.title;
    [ctrl.navigationController.navigationBar setTintColor:[UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:0]]; 
}
+(void) setBackground:(id)view{
    //設定背景圖示 [UIImage imageNamed:thumbnailPath]]
    UIImage *img = [UIImage imageNamed:@"contentui_bg_gary_background.png"];
	[view setBackgroundColor:[UIColor colorWithPatternImage:img]];
	//[img release];
}
// takes 0x123456
+(UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}
// takes @"#123456"
+(UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}
+(NSString *)getMoneyString:(NSString *)str {
    NSString* returnStr = [NSString stringWithFormat:@"%@: %@",AMLocalizedString(@"money_unit", nil), str];
    return returnStr;
}
@end
