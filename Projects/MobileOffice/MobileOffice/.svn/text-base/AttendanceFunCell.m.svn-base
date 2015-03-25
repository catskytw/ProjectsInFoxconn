//
//  AttendanceFunCell.m
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "AttendanceFunCell.h"

@implementation AttendanceFunCell
@synthesize funImage,nameLabel,selectedImg,seperateImgView;

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
