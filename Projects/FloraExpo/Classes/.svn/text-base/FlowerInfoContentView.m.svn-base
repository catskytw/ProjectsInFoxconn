//
//  FlowerInfoContentView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerInfoContentView.h"


@implementation FlowerInfoContentView
@synthesize myTitle;
@synthesize myArea;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"DescriptionContentViewController" bundle:nibBundleOrNil]) {
		mc=[[DescriptionViewController alloc]initWithDescriptionKey:@"9"];
		mc.startY=0;
		mc.thisScrollView=[[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 385)]autorelease];
		mc.thisScrollView.alwaysBounceVertical=YES;
		[mc constructThisPage];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
	originTransform=CGAffineTransformMakeScale((CGFloat)1, (CGFloat)1);
	afterTransform=CGAffineTransformMakeScale((CGFloat)2.85,(CGFloat)2.8378);
	isBigFlowerImage=NO;
	titleLabel.text=[NSString stringWithString:myArea];
	[self.navigationItem setTitle:myTitle];
	[titleLabel setText:myArea];
	[contentText removeFromSuperview];
	[contentView addSubview:mc.thisScrollView];
	[picImageView setImage:[UIImage imageNamed:@"img_a_rose.png"]];
}

@end
