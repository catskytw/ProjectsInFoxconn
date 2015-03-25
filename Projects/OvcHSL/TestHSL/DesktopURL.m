//
//  DesktopURL.m
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/11/1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "DesktopURL.h"
static NSString *singletonDesktopURL=nil;
@implementation DesktopURL
+(NSString*)desktopURL{
    if(singletonDesktopURL==nil)
        singletonDesktopURL=[[NSString string] retain];
    return singletonDesktopURL;
}
+(NSString*)setDesktopURL:(NSString*)url{
    if(singletonDesktopURL!=nil){
        [singletonDesktopURL release];
        singletonDesktopURL=nil;
    }
    singletonDesktopURL=[[NSString stringWithString:url] retain];
    return singletonDesktopURL;
}
@end
