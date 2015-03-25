//
//  FcContent2View.h
//  Logistics
//
//  Created by Chang Link on 11/8/31.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#define defaultArrowY 150
#define defaultArrowHeight 400


@interface FcContent2View : ContentView{
    UIScrollView *arrowScrollView;
    UIImageView *arrowImgView;
}
-(void)addArrowImage;
-(void)moveArrow;
@end
