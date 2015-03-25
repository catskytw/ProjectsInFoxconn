//
//  FcTextField.m
//  Logistics
//
//  Created by Chang Link on 11/8/30.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcTextField.h"
#import "NinePatch.h"
@implementation FcTextField
@synthesize textField,iconImg,bgImg,bFocus;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setFocus:(BOOL)focus{
    bFocus = focus;
    [self setLayout];
}
-(void) setLayout{
    if (bFocus) {
        bgImg.image = [TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox_search_i"];
        iconImg.image = [UIImage imageNamed:@"editbox_search_ico_i.png"];
    }else{
        bgImg.image = [TUNinePatchCache imageOfSize:bgImg.frame.size forNinePatchNamed:@"editbox_search"];
        iconImg.image = [UIImage imageNamed:@"editbox_search_ico.png"];
    }
}
-(void) setDelegate:(id)delegate{
    textField.delegate = delegate;
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
