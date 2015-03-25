//
//  HomeButtonDataObject.m
//  OveExpo
//
//  Created by Liao Chen-chih on 2011/10/12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "HomeButtonDataObject.h"

@implementation HomeButtonDataObject
@synthesize tag,title,imageFileName;
- (id)initWithTitle:(NSString*)_title withImage:(NSString*)fileName withTag:(NSInteger)_tag
{
    self = [super init];
    if (self) {
        title=[[NSString stringWithString:_title] retain];
        imageFileName=[[NSString stringWithString:fileName]retain];
        tag=_tag;
    }
    return self;
}
-(void)dealloc{
    [title release];
    [imageFileName release];
    [super dealloc];
}

@end
