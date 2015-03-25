//
//  ContentView.m
//  logistic
//
//  Created by Chang Link on 11/8/10.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView
@synthesize superController,contentXib;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setInfo
{    
    if (contentXib) {
        [contentXib setInfo];
    }
};
-(void)setBackGround{};
-(void)addContextXibView:(ContentXibView*)xibView{
    contentXib = xibView;
    [self addSubview:contentXib];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
