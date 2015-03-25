//
//  AboutUsViewCtrl.h
//  OveExpo
//
//  Created by  on 11/10/7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcViewController.h"
@interface AboutUsViewCtrl : FcViewController
{
    //*** Title
    IBOutlet UILabel *contentTitleLabel;
    IBOutlet UILabel *contentLabel;
    IBOutlet UIScrollView *baseScroll;
    
    //*** Others
    NSString *title;
    NSString *content;
}
@end
