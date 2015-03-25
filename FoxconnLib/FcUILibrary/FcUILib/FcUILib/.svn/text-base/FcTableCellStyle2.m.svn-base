//
//  FcTableCellStyle2.m
//  Logistics
//
//  Created by Chang Link on 11/9/1.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcTableCellStyle2.h"
#import "NinePatch.h"
@implementation FcTableCellStyle2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setLayout{
    
    UIImageView * seperateView = [[UIImageView alloc] initWithImage:[TUNinePatchCache imageOfSize:seperateLineRect.size forNinePatchNamed:@"line_step2"]];
    seperateView.frame = seperateLineRect;
    [self addSubview:seperateView];
    if (index%2==0) {
        UIView *coverView = [[UIView alloc]initWithFrame:self.frame];
        [coverView setBackgroundColor:[UIColor whiteColor]];
        [coverView setAlpha:0.2];
        coverView.userInteractionEnabled = NO;
        [self addSubview:coverView];
        [self sendSubviewToBack:coverView];
        [coverView release];
    }
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [seperateView release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
    if (selectedArray) {
        for (UILabel* selectedLabel in selectedArray) {
            if (selected) {
                selectedLabel.textColor= [UIColor colorWithRed:0 green:102/255.f blue:255/255.f alpha:1];
            }else{
                selectedLabel.textColor= [UIColor blackColor];
                
            }

        }  
    }
    // Configure the view for the selected state
}

@end
