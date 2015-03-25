//
//  ProductContentView.h
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductContentView : UIViewController {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *contentLabel;
    IBOutlet UIScrollView *contentSubView;
}
@property(nonatomic,retain)UILabel *titleLabel,*contentLabel;
@property(nonatomic,retain)UIScrollView *contentSubView;
@end
