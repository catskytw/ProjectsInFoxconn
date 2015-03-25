//
//  UIViewClearSubViews.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/4/12.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "UIViewClearSubViews.h"


@implementation UIView(ClearSubViews)
-(void)clearSubViews{
    NSArray *allSubView=[self subviews];
    for (int i=0; i<[allSubView count]; i++) {
        UIView *currentView=(UIView*)[allSubView objectAtIndex:i];
        [currentView removeFromSuperview];
    }
}
@end
