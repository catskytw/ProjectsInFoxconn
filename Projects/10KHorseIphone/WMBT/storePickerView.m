//
//  storePickerView.m
//  WMBT
//
//  Created by link on 2011/6/21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "storePickerView.h"


@implementation storePickerView
@synthesize storeName;



- (void)dealloc
{
    [self setStoreName:nil];
    //[storeName release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void) setName:(NSString*)name
{
    storeName.text = name;
}
@end
