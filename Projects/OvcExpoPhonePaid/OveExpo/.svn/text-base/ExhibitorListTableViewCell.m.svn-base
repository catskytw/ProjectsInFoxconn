//
//  CompanyListTableViewCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorListTableViewCell.h"
#import "NinePatch.h"
@implementation ExhibitorListTableViewCell
@synthesize iconImg,contentLabel;

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
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
 
}
-(void)setDO:(ExhibitorListDataObject*) dao{
    iconName = dao.iconName;
    contentLabel.text = dao.name;
    [iconImg setImage:[UIImage imageNamed:@"img_logo_default.png"]];
    if ([dao.iconName length]>1) {
        [iconImg setImage:[UIImage imageNamed:dao.iconName]];
    }
 
    name = dao.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [selectedImg release];
    [contentLabel release];
    [iconImg release];
    [super dealloc];
}
@end
