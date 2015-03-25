//
//  PSListByDateTableViewCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PSListByDateTableViewCell.h"
#import "NinePatch.h"
@implementation PSListByDateTableViewCell
@synthesize contentLabel;
@synthesize bgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}
-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    //[bgView setImage:[TUNinePatchCache imageOfSize:bgView.frame.size forNinePatchNamed:@"list_i"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [selectedImg release];
    [bgView release];
    [contentLabel release];
    [super dealloc];
}
@end
