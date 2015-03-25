//
//  FcGroupTableCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/29.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcGroupTableCell.h"
#import "FcConfig.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "FcDrawing.h"

@implementation FcGroupTableCell
@synthesize mode;
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
    CGSize selectedSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    UIImage *texture=[FcDrawing drawImageWithPattern:@"group_table_i.png" withSize:selectedSize];
  
    seperateLineImg.frame = CGRectMake(1, self.frame.size.height-3, GroupCellWidth-2, 1);
    seperateLineImg.image =[TUNinePatchCache imageOfSize:seperateLineImg.frame.size forNinePatchNamed:@"group_table_line"];
    //UIView *selectedView = [[UIView alloc]initWithFrame:self.selectedBackgroundView.frame];
    UIImage *mask;
    if (FcGroupTableCellMode_TOP==mode) {
        mask=[TUNinePatchCache imageOfSize:selectedSize forNinePatchNamed:@"group_table_top_mask"];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    }else if(mode == FcGroupTableCellMode_BUTTON){
        mask=[TUNinePatchCache imageOfSize:selectedSize forNinePatchNamed:@"group_table_down_mask"];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[FcDrawing clipTextureMask:[FcDrawing drawDeviceGrayImage:mask]withImage:texture]];
    }else{
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:texture];
    }
    
    [self addSubview:seperateLineImg];

    [seperateLineImg release];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
