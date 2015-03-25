//
//  MOSearchTableCell.m
//  MobileOffice
//
//  Created by Jeff foxconn on 11/11/25.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "MOSearchTableCell.h"
#import "NinePatch.h"
#import "FcDrawing.h"
@implementation MOSearchTableCell
@synthesize separateLine;
@synthesize cellLabel;
-(void) setDefaultUI
{
    UIView *_uiView = [UIView new];
    [_uiView setBackgroundColor:[[UIColor alloc] initWithRed:196/255.f green:197/255.f blue:206/255.f alpha:0.5]];
    //[_uiView setFrame:CGRectMake(_uiView.frame.origin.x+2, _uiView.frame.origin.y+2, _uiView.frame.size.width-2, _uiView.frame.size.height-4)];
    [self setSelectedBackgroundView:_uiView];
    [separateLine setImage:[TUNinePatchCache imageOfSize:separateLine.frame.size forNinePatchNamed:@"bg_search_popup_group_line"]];
}

- (void)dealloc {
    [cellLabel release];
    [separateLine release];
    [super dealloc];
}
@end
