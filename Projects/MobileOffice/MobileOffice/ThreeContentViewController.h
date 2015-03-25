//
//  ThreeContentViewController.h
//  logistic
//
//  Created by Chang Link on 11/8/10.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ArrowHeight 13.95
#define scrollShadowY 6.5
@interface ThreeContentViewController : UIViewController{
    NSMutableArray* contentViews;
    NSArray* contentPosition;
    NSArray *contentViewsName;
    NSMutableDictionary *arrowDictionary;
    UIImageView *arrowImg;
    UIScrollView *arrowScrollView;
}
@property (nonatomic, retain) NSMutableArray *contentViews;
@property (nonatomic, retain) UIScrollView *arrowScrollView;
-(void)initWithXibNames:(NSArray*) nibName;
-(void)initWithXibNames:(NSArray*) nibName withPosition:(NSArray*) nibPosition;
//-(void)addArrowImage:(NSString*) imgUrl withIndex:(int) idx;
//-(void)moveArrow:(float)y withIndex:(int)idx;
//-(void)moveArrowWithNoAnimation:(float)y withIndex:(int)idx;
@end
