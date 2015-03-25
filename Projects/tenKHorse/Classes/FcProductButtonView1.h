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
    IBOutlet UIImageView *frame;
	IBOutlet UILabel *name;
	IBOutlet UILabel *price;
    IBOutlet UILabel *brand;
	IBOutlet UIButton *actionButton;
}
@property(nonatomic,retain) UIImageView *picture,*frame;
@property(nonatomic,retain) UILabel *name;
@property(nonatomic,retain) UILabel *price;
@property(nonatomic,retain) UILabel *brand;
@property(nonatomic,retain) UIButton *actionButton;
-(void)tuneLayout;
@end
