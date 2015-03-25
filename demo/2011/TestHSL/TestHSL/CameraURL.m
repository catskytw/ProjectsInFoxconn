//
//  CameraURL.m
//  TestHSL
//
//  Created by Liao Chen-chih on 2011/11/1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CameraURL.h"
static NSString *singletonCameraURL=nil;
@implementation CameraURL
+(NSString*)cameraURL
{
    if(singletonCameraURL==nil){
        singletonCameraURL=[[NSString string] retain];
    }
    return singletonCameraURL;
}

+(NSString*)setCameraURL:(NSString*)url{
    if(singletonCameraURL!=nil){
        [singletonCameraURL release];
        singletonCameraURL=nil;
    }
    singletonCameraURL=[[NSString stringWithString:url] retain];
    return singletonCameraURL;
}
@end
