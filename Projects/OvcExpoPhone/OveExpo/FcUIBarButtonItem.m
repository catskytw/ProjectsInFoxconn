//
//  FcUIBarButtonItem.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FcUIBarButtonItem.h"
#import "Tools.h"
#import "NinePatch.h"
@implementation UIBarButtonItem (FcCategory)
+(UIBarButtonItem*)backBarItemWithImage:(UIImage*)image withHighlightImage:(UIImage*)h_image target:(id)target action:(SEL)action withTitle:(NSString*)btnTitle{

    UIButton *fakeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [fakeBtn setImage:image forState:UIControlStateNormal];
    [fakeBtn setImage:h_image forState:UIControlStateHighlighted];
    fakeBtn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    [fakeBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UILabel *_label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, image.size.width-20.0f, image.size.height)];
    [_label setTextAlignment:UITextAlignmentCenter];
    [_label setText:btnTitle];
    [_label setTextColor:[UIColor blackColor]];
    [_label setBackgroundColor:[UIColor clearColor]];
    [_label setFont:[UIFont fontWithName:DefaultFontName size:14.0f]];

    UIView *v=[[UIView alloc] initWithFrame:fakeBtn.frame];
    [v addSubview:fakeBtn];
    _label.center=fakeBtn.center;
    [v addSubview:_label];
    
    UIBarButtonItem *newBackButton=[[UIBarButtonItem alloc] initWithCustomView:v];

    return [newBackButton autorelease];
}

+(UIBarButtonItem*)rightBarItemWithImage:(UIImage*)image withHighlightImage:(UIImage*)h_image target:(id)target action:(SEL)action withTitle:(NSString*)btnTitle{
    //現在rightBar以及backBar定義一樣,但未來可能會有不同的區分.
    return [UIBarButtonItem backBarItemWithImage:image withHighlightImage:h_image target:target action:action withTitle:btnTitle];
}
@end
