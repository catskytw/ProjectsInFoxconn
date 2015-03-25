//
//  ServiceIntroCell.m
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "ServiceIntroCell.h"
#import "NinePatch.h"
@implementation ServiceIntroCell
@synthesize contentLabel,serviceId;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [contentLabel release];
    [selectedImg release];
    [super dealloc];
}

#pragma -
#pragma mark -  PrivateMethod

-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    
}

-(void)setDAO:(ServiceDataObject*)_sdo{
    contentLabel.text = _sdo.name;
    serviceId = _sdo.serviceId;
}
@end
