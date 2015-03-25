//
//  OveMeetingListCell2.m
//  OveExpo
//
//  Created by  on 11/9/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomerInfo_Cell.h"
#import "FcConfig.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "FcDrawing.h"

@implementation CustomerInfo_Cell
@synthesize mode, bgView, selectedImg, seperateLineImg, label1, textField1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setFcLayout:(NSIndexPath *)indexPath withRows:(NSInteger)rows{
    //int cellCount = [(UITableView *)self.superview numberOfRowsInSection:indexPath.section];
    int cellCount = rows;
    if (0==indexPath.row) {
        mode =FcGroupTableCellMode_TOP;
    }else if(indexPath.row == cellCount-1){
        mode = FcGroupTableCellMode_BUTTON;
    }else{
        mode = FcGroupTableCellMode_MIDDLE;
    }
    
    seperateLineImg = [UIImageView new];
    CGSize selectedSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    UIImage *texture=[FcDrawing drawImageWithPattern:@"group_table_i.png" withSize:selectedSize];
    
    //seperateLineImg.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 1);
    seperateLineImg.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 1);
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
    
    if(mode != FcGroupTableCellMode_BUTTON)
    {
        [self addSubview:seperateLineImg];
    }
    
    [seperateLineImg autorelease];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*- (void)dealloc {
    [selectedImg release];
    [bgView release];
    [seperateLineImg release];
    [label1 release];
    [textField1 release];
    [super dealloc];
}*/
@end
