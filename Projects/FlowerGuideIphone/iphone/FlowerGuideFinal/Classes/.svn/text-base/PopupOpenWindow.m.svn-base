//
//  ContentTextViewController.m
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PopupOpenWindow.h"


@implementation PopupOpenWindow
@synthesize mainView;
@synthesize titleLabel;
- (void)dealloc {
    [super dealloc];
}
-(IBAction)closeThisWindow:(id)sender{
	[self removeFromSuperview];
	//在外部alloc,本身自己release
	[self release];
}

@end
