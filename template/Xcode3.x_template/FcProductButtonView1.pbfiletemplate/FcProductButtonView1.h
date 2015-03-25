//
//  ProductButton1.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/23.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FcProductButtonView1 : UIViewController {
	IBOutlet UIImageView *picture;
	IBOutlet UILabel *name;
	IBOutlet UILabel *price;
	IBOutlet UIButton *actionButton;
}
@property(nonatomic,retain) UIImageView *picture;
@property(nonatomic,retain) UILabel *name;
@property(nonatomic,retain) UILabel *price;
@property(nonatomic,retain) UIButton *actionButton;
@end
