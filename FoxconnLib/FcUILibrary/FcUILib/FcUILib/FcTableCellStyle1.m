//
//  FcStyle1Cell.m
//  Logistics
//
//  Created by Chang Link on 11/9/1.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcTableCellStyle1.h"
#import "NinePatch.h"
#import "FcDrawing.h"
@implementation FcTableCellStyle1
//@synthesize selectedImg;
//@synthesize seperateLineImg;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setLayout{

    UIImageView *seperateLineImg = [UIImageView new];
    UIImage *texture=[FcDrawing drawImageWithPattern:@"btn_step1_orange_material.png" withSize:selectedRect.size];
    UIImage *mask=[TUNinePatchCache imageOfSize:selectedRect.size forNinePatchNamed:@"btn_step1_orangemask"];
    seperateLineImg.image =[TUNinePatchCache imageOfSize:seperateLineRect.size forNinePatchNamed:@"line_step1"];
    UIView *selectedView = [[UIView alloc]initWithFrame:self.selectedBackgroundView.frame];
    UIImageView *selectedImgView = [[UIImageView alloc] initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    selectedImgView.frame = selectedRect;
    seperateLineImg.frame = seperateLineRect;
    [self addSubview:seperateLineImg];
    [selectedView addSubview:selectedImgView];
    self.selectedBackgroundView = selectedView;
    [selectedView release];
    [selectedImgView release];
    [seperateLineImg release];
    //[self setSelectionStyle:UITableViewCellSelectionStyleNone];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selectedArray) {
        for (UILabel* selectedLabel in selectedArray) {
            if (selected) {
                selectedLabel.textColor= [UIColor blackColor];
            }else{
                selectedLabel.textColor= [UIColor whiteColor];
                
            }
            
        }  
    }
    // Configure the view for the selected state
}
-(void)dealloc{
    [super dealloc];
}
@end
