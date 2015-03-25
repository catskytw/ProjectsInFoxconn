//
//  OveMeetingListCell2.m
//  OveExpo
//
//  Created by  on 11/9/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard_Cell3.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
@implementation BusinessCard_Cell3
@synthesize bgView, selectedImg, seperateImg, label1, textField1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setUIDefault{
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 1) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    
    //[label1 setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    //[label1 setTextColor:[UIColor colorWithRed:157/255.f green:157/255.f blue:157/255.f alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*- (void)dealloc {
    [selectedImg release];
    [bgView release];
    [seperateImg release];
    [label1 release];
    [textField1 release];
    [super dealloc];
}*/
@end
