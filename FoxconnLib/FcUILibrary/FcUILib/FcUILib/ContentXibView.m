//
//  ContentXibView.m
//  Logistics
//
//  Created by Chang Link on 11/8/31.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ContentXibView.h"

@implementation ContentXibView
@synthesize dataTable,selectedIndex,cellHeight;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setInfo{
    
}
-(void)setLayout{
    
}
- (void)dealloc {
    [dataTable release];
    [super dealloc];
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
