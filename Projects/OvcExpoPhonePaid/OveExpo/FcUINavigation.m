//
//  FcUINavigation.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcUINavigation.h"
#import "NinePatch.h"
@implementation UINavigationBar (PrivateMethod) 
-(void)drawRect:(CGRect)rect{
    
	UIImage *image=[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"img_actionbar"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
