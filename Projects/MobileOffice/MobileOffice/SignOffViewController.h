//
//  SignOffViewController.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/13.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "BasicViewController.h"
#import "ThreeContentViewController.h"
@interface SignOffViewController : BasicViewController{
    ThreeContentViewController *contentVC;
    BOOL isSlideForKeyboard;
}
@property (assign,nonatomic) BOOL isComment;
@end
