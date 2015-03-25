//
//  CooperatorCategoryListCell.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CooperatorCategoryListCell.h"
#import "NinePatch.h"
@implementation CooperatorCategoryListCell
@synthesize contentLabel;
#pragma mark - Layout
-(void)setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
}
#pragma -
@end
