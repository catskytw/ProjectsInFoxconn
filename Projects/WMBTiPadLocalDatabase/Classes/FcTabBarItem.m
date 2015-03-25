//
//  FcTabBarItem.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/1/26.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcTabBarItem.h"


@implementation FcTabBarItem

@synthesize customHighlightedImage;
@synthesize customStdImage;

- (void) dealloc
{
    [customHighlightedImage release]; customHighlightedImage=nil;
    [customStdImage release]; customStdImage=nil;   
    [super dealloc];
}

-(UIImage *) selectedImage
{
    return self.customHighlightedImage;
}

-(UIImage *) unselectedImage
{
    return self.customStdImage;
}

@end
