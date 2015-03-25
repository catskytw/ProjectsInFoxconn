//
//  FcContent2View.m
//  Logistics
//
//  Created by Chang Link on 11/8/31.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcContent2View.h"
#import "FcDrawing.h"
#import "NinePatch.h"

@implementation FcContent2View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setBackGround{
    UIImageView *bgImg = [UIImageView new];
    if (contentXib) {
        [contentXib setLayout];
        bgImg.frame = contentXib.frame;
    }
    
    UIImage *texture=[FcDrawing drawImageWithPattern:@"step2_material.png" withSize:bgImg.frame.size];
    UIImage *mask=[TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"step2_mask"];
    bgImg.image = [TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"step2_frame"];
    UIImageView *textureView =  [[UIImageView alloc]initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    textureView.frame = bgImg.frame;
    [bgImg addSubview:textureView];
    [textureView release];
    [self addArrowImage];
    
    [self addSubview:bgImg];
    [self sendSubviewToBack:bgImg];
    //[self moveArrow];
    [bgImg release];
}

-(void)addArrowImage{
    
    arrowScrollView = [[UIScrollView alloc]init];
    arrowImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_step3_line_triangle.png"]];
    [arrowScrollView setFrame:CGRectMake(self.frame.size.width-arrowImgView.frame.size.width, contentXib.dataTable.frame.origin.y-2, arrowImgView.frame.size.width, contentXib.dataTable.frame.size.height)];
    NSLog(@"add ArrowImg frame width %f, arrow width %f ", self.frame.size.width,arrowImgView.frame.size.width);
    //[arrowScrollView setFrame:CGRectMake(self.frame.size.width-arrowImgView.frame.size.width-4, defaultArrowY-2, arrowImgView.frame.size.width, defaultArrowHeight)];
    
    [arrowImgView setFrame:CGRectMake(0, -arrowImgView.frame.size.height/2 - 20, arrowImgView.frame.size.width, arrowImgView.frame.size.height)];
    arrowScrollView.clipsToBounds = YES;
    [arrowScrollView addSubview:arrowImgView];
    [self addSubview:arrowScrollView];
    
    
    UIImageView *imgUplineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"step3_white_line.png"]];
    UIImageView *imgDownlineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"step3_white_line.png"]];
    
    [imgUplineView setFrame:CGRectMake(arrowScrollView.frame.origin.x+5, scrollShadowY-1, arrowScrollView.frame.size.width, 1)];
    [imgDownlineView setFrame:CGRectMake(arrowScrollView.frame.origin.x+5, self.frame.size.height-scrollShadowY-1, arrowScrollView.frame.size.width, 1)];
    UIImageView *imgScrollMask = [UIImageView new];
    //imgScrollMask.image = [UIImage imageNamed:@"img_step3_line_triangle_mask.png"];
    imgScrollMask.image = [TUNinePatchCache imageOfSize:CGSizeMake(arrowScrollView.frame.size.width, arrowScrollView.frame.origin.y - scrollShadowY +1) forNinePatchNamed:@"img_step3_line_triangle_mask"];
    [imgScrollMask setFrame:CGRectMake(arrowScrollView.frame.origin.x , scrollShadowY ,
                                       imgScrollMask.image.size.width, imgScrollMask.image.size.height)];
    
    [self addSubview:imgScrollMask];
    [self addSubview:imgUplineView];
    [self addSubview:imgDownlineView];
    [imgScrollMask release];
    [imgUplineView release];
    [imgDownlineView release];
}
-(void)moveArrow{
    CGPoint scrollPosition = [contentXib.dataTable contentOffset];
    float arrowY = -scrollPosition.y + contentXib.cellHeight * contentXib.selectedIndex + contentXib.cellHeight/2;
    if (arrowY<  - ArrowHeight -5) {
        arrowY =  - ArrowHeight -5 ;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    arrowImgView.frame = CGRectMake(arrowImgView.frame.origin.x, arrowY-arrowImgView.frame.size.height/2, arrowImgView.frame.size.width, arrowImgView.frame.size.height);
    [UIView commitAnimations];

}
@end
