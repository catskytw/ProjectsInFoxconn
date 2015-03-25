//
//  StepIcon.m
//  Logistics
//
//  Created by Chang Link on 11/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "StepIcon.h"
#define StepOffColor [UIColor colorWithRed:(CGFloat)97/256 green:(CGFloat)107/256 blue:(CGFloat)125/256 alpha:1]
#define StepOnColor [UIColor colorWithRed:(CGFloat)35/256 green:(CGFloat)35/256 blue:(CGFloat)35/256 alpha:1]

@implementation StepIcon
@synthesize imgStep, imgStep_i, LabelStep;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setOnOff:(BOOL)bOn andNo:(int)iNo{
    imgStep_i.hidden = !bOn;
    [LabelStep setTextColor:(bOn)?StepOnColor:StepOffColor];
    [LabelStep setText:[NSString stringWithFormat:@"%d",iNo]];
    [LabelStep setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:12.0]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
