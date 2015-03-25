//
//  FcContent1View.m
//  Logistics
//
//  Created by Chang Link on 11/8/31.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcContent1View.h"
#import "FcDrawing.h"
#import "NinePatch.h"
@implementation FcContent1View

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
        NSLog(@"content1 x:%f, y:%f, width:%f, height:%f", contentXib.frame.origin.x, contentXib.frame.origin.y, contentXib.frame.size.width, contentXib.frame.size.height);
    }
    UIImage *texture=[FcDrawing drawImageWithPattern:@"step1_material.png" withSize:bgImg.frame.size];
    NSLog(@"bgimg width:%f, height:%f", bgImg.frame.size.width, bgImg.frame.size.height);

    UIImage *mask=[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"step1_mask"];
    bgImg.image = [TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"step1_frame"];
    
    UIImageView *textureView =  [[UIImageView alloc]initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    textureView.frame = bgImg.frame;
    [bgImg addSubview:textureView];
    [self addSubview:bgImg];
    [self sendSubviewToBack:bgImg];
    [textureView release];
    [bgImg release];
}
- (void)dealloc {
    
    [super dealloc];
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
