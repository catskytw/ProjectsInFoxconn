//
//  SignOffTypeCell.m
//  MobileOffice
//
//  Created by Chang Link on 11/9/5.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "SignOffTypeCell.h"

@implementation SignOffTypeCell
@synthesize nameLabel,seperateImgView,selectedImg;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setDO:(NSString*)name{
    nameLabel.text = name;
    seperateLineRect = seperateImgView.frame;
    selectedRect = selectedImg.frame;
    selectedArray = [NSMutableArray new];
    [selectedArray addObject:nameLabel];
    [super setLayout];
}
- (void)dealloc {
    [nameLabel release];
    [seperateImgView release];
    if (selectedArray) {
        [selectedArray release];
    }
    
    [super dealloc];
}
@end
