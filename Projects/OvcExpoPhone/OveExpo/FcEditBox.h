//
//  FcEditBox.h
//  OveExpo
//
//  Created by Chang Link on 11/9/19.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FcEditBox : UIViewController {
    UIImageView *bgImg;
    UITextField *textField;
}

@property (nonatomic, retain) IBOutlet UIImageView *bgImg;
@property (nonatomic, retain) IBOutlet UITextField *textField;

@end
