//
//  CustomTintExtension.m
//  WMBT
//
//  Created by link on 2011/7/1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomTintExtension.h"


@implementation UISegmentedControl (CustomTintExtension)
-(void)setTag:(NSInteger)tag forSegmentAtIndex:(NSInteger)segment{
    [[[self subviews] objectAtIndex:segment] setTag:tag]; 
}
-(void)setTintColor:(UIColor*)Color forTag:(NSInteger)aTag{
    UIView *segment = [self viewWithTag:aTag];
    SEL tint =@selector(setTintColor:);
    if(segment&& [segment respondsToSelector:tint]){
        [segment performSelector:tint withObject:Color];
    }
}
-(void)setTextColor:(UIColor*)Color forTag:(NSInteger)aTag{
    UIView *segment = [self viewWithTag:aTag];
    for(UIView *view in segment.subviews){
        SEL text = @selector(setTextColor:);
        if(view && [view respondsToSelector:text]){
            [view performSelector:text withObject:Color];
        }
    }
}
-(void)setShadowColor:(UIColor*)Color forTag:(NSInteger)aTag{
    UIView *segment = [self viewWithTag:aTag];
    for(UIView *view in segment.subviews){
        SEL shadowColor = @selector(setShadowColor:);
        if(view && [view respondsToSelector:shadowColor]){
            [view performSelector:shadowColor withObject:Color];
        }
    }
}
@end
