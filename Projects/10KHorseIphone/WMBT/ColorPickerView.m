//
//  ColorPickerView.m
//  WMBT
//
//  Created by link on 2011/6/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ColorPickerView.h"
#import "UITuneLayout.h"


@implementation ColorPickerView
@synthesize nameLabel, colorView;

- (void) setColor:(NSString*)sColor andTitle:(NSString*) sTitle
{
    nameLabel.text = sTitle;
    NSLog(@"Color:%@",sColor);
    [colorView setBackgroundColor:[UITuneLayout colorWithHexString:sColor]];
    strColor = sColor;
    
}
// Enable accessibility for this view.
- (BOOL)isAccessibilityElement
{
	return YES;
}

// Return a string that describes this view.


- (void)dealloc
{
    if (strColor) {
        [strColor release];
    }
    //[nameLabel release];
    //[colorView release];
	[super dealloc];
}
@end
