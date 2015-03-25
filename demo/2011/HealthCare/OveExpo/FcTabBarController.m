//
//  FcTabBarController.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/9/20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcTabBarController.h"
#import "NinePatch.h"
@implementation FcTabBarController
@synthesize tabBar1;

-(void)viewDidLoad{
    [super viewDidLoad];
    [tabBar1 setBackgroundColor:[UIColor clearColor]];
    CGRect frame=CGRectMake(0, 0, 320, 50);
    UIView *v=[[UIView alloc]initWithFrame:frame];
    UIImage *i=[TUNinePatchCache imageOfSize:CGSizeMake(320,50)  forNinePatchNamed:@"img_belowbar"];
    v.backgroundColor=[UIColor colorWithPatternImage:i];
    [[self tabBar]insertSubview:v atIndex:0];
    [v release];
}
@end
