//
//  setSelectedBGTableCell.m
//  WMBT
//
//  Created by link on 2011/6/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "setSelectedBGTableCell.h"


@implementation UITableViewCell (setSelectedBGTableCell)

-(void)drawRect:(CGRect)rect
{
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contentui_btn_list_reaction.png"]];
    self.textLabel.highlightedTextColor =[UIColor blackColor];
    [self.textLabel setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:20.0]];
    [super drawRect:rect];
}
@end
