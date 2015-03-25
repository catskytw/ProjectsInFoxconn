//
//  OveMeetingListCell2.m
//  OveExpo
//
//  Created by  on 11/9/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard_ListCell.h"
#import "PSListDataObject1.h"
#import "NinePatch.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
@implementation BusinessCard_ListCell
@synthesize bgView, selectedImg, seperateImg, label1, label2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setUIDefault{
    seperateImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2);
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
    [label2 release];
}*/
@end
