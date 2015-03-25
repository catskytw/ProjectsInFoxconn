//
//  FcTabbarController.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/7/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "FcTabbarController.h"


@implementation FcTabbarController
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    NSLog(@"shouldAutorotateToInterfaceOrientation = %d",interfaceOrientation);
    BOOL r;
    if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        r=NO;
    }
    
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        r=NO;
    }
    
    if(interfaceOrientation == UIInterfaceOrientationPortrait){
        r=YES;
    }
    
    if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        r=YES;
    }
    return r;
}
@end
