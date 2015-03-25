//
//  UINavigationBar.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar.h"


@implementation UINavigationBar (CustomBackground)
-(void)drawRect:(CGRect)rect{
	UIImage *image=[UIImage imageNamed:@"contentui_bg_titel.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
