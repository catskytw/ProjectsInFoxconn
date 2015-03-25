    //
//  ProductButtonView.m
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "FcProductButtonView1.h"
#import "Tools.h"
#import "TUNinePatchCache.h"
#import "Configure.h"
@implementation FcProductButtonView1
@synthesize picture,price,name,actionButton,brand,frame;
-(void)tuneLayout{
    CGSize maxsize=CGSizeMake(118, 20);
    CGSize actualSize=[Tools estimateStringSize:brand.text withFontSize:17.0 withMaxSize:maxsize];
    [brand setFrame:CGRectMake(brand.frame.origin.x, brand.frame.origin.y, actualSize.width, actualSize.height)];
    [frame setImage:[UIImage imageNamed:@"compare_blend.png"]];
    frame.hidden=YES;
}
@end
