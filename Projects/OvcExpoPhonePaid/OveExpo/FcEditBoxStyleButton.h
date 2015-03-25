//
//  FcEditBoxStyleButton.h
//  OveExpo
//
//  Created by Chang Link on 11/9/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewController.h"
@interface FcEditBoxStyleButton : UIViewController {
    UIImageView *bgImg;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIButton *arrowBtn;
    UIViewController *rootViewController;
    ListTableViewController *listViewController;
}

@property (nonatomic, retain) IBOutlet UIImageView *bgImg;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *contentLabel;
@property (nonatomic, retain) IBOutlet UIButton *arrowBtn;
@property (nonatomic, retain) UIViewController *rootViewController;
- (IBAction)toNextView:(id)sender;

@end
