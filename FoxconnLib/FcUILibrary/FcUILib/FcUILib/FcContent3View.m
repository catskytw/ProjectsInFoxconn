//
//  FcContent3View.m
//  Logistics
//
//  Created by Chang Link on 11/8/31.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcContent3View.h"
#import "NinePatch.h"
@implementation FcContent3View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setBackGround{
    UIImageView *bgImg = [UIImageView new];
    if (contentXib) {
        [contentXib setLayout];
        bgImg.frame = contentXib.frame;
    }
    bgImg.image = [TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"bg_step3"];
    [self addSubview:bgImg];
    [self sendSubviewToBack:bgImg];
    [bgImg release];
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
