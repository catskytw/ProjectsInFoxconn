//
//  PromotEventListTableCell.m
//  WMBT
//
//  Created by link on 2011/6/9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PromotEventListTableCell.h"


@implementation PromotEventListTableCell
@synthesize titleLabel;
@synthesize contentLabel;
@synthesize durationLabel;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    //[titleLabel release];
    //[contentLabel release];
    //[durationLabel release];
    [super dealloc];
}

- (void)setInfoDO:(PromoteEventCellDataObject*) dao
{
    titleLabel.text = dao.title;
    contentLabel.text =dao.content;
    durationLabel.text =dao.duration;
    titleLabel.textColor = [UIColor colorWithRed:(float)134/255.0f green:(float)84/255.0f blue:(float)34/255.0f alpha:1];
}
@end
