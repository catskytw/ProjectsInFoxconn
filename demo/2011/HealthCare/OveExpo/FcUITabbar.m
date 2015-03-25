//
//  FcUITabbar.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcUITabbar.h"
#import "NinePatch.h"
@implementation UITabBar(PrivateMethod)
-(void)drawRect:(CGRect)rect{
	UIImage *image=[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, self.frame.size.height) forNinePatchNamed:@"img_belowbar"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
