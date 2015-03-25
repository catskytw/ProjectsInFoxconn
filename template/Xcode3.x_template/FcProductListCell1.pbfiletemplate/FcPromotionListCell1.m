//
//  FcPromotionListCell1.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/27.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcPromotionListCell1.h"


@implementation FcPromotionListCell1
/*
 @property(nonatomic,retain)UILabel *titleLabel,*descriptionLabel,*subLabelLeft,*subLabelRight;
*/
@synthesize titleLabel,descriptionLabel,subLabelLeft,subLabelRight;


#pragma mark DelegateMethod
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state.
}
#pragma mark -

#pragma mark LifeCycle
- (void)dealloc {
    [super dealloc];
}
#pragma mark -


@end
