//
//  MyFavoriteTableCell.m
//  FloraExpo2010
//
//  Created by Change Liao on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyFavoriteTableCell.h"


@implementation MyFavoriteTableCell
@synthesize myFavoriteTableCellLabel;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
