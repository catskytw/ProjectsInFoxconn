//
//  FlowerContentTemplate.m
//  iphoneFlowerProject
//
//  Created by Change Liao on 5/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowerContent.h"

@implementation FlowerContent
@synthesize flowerImage;
@synthesize titleLabel,contentLabel,areaTitle;
@synthesize switchSizeBtn;
@synthesize mainScrollView;
-(id)initWithScreenWidth:(NSInteger)width{
	if((self=[super init])){
		screenWidth=width;
	}
	return self;
}
- (void)viewDidLoad{	
	[super viewDidLoad];
	isBigFlowerImage=NO;
}
-(void)settingTransform{
	BOOL isStraight=(flowerImage.frame.size.width>flowerImage.frame.size.height)?NO:YES;
	float originRate=(isStraight)?((float)85/flowerImage.frame.size.height):((float)77/flowerImage.frame.size.width);
	float afterRate=(isStraight)?((float)315/flowerImage.frame.size.height):((float)285/flowerImage.frame.size.width);
	
	originTransform=CGAffineTransformMakeScale(originRate, originRate);
	afterTransform=CGAffineTransformMakeScale(afterRate, afterRate);
}
-(IBAction)changeImageSizeAnimation:(id)sender{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	isBigFlowerImage=!isBigFlowerImage;
	[self setFlowerImageLocation];
	[UIView commitAnimations];
}

-(void)setFlowerImageLocation{
	flowerImage.transform=(isBigFlowerImage)?afterTransform:originTransform;
	//計算flowerImage之x位置
	int xPosition=screenWidth-flowerImage.frame.size.width;
	//計算switchSizeBtn之y位置
	//int yPosition=flowerImage.frame.size.height-switchSizeBtn.frame.size.height;
	flowerImage.frame=CGRectMake(xPosition, 0.0f, flowerImage.frame.size.width, flowerImage.frame.size.height);	
	CGRect rect=flowerImage.frame;
	if(isBigFlowerImage){
		[switchSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgreduce.png"] forState:UIControlStateNormal];
		[switchSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgreduce_i.png"] forState:UIControlStateHighlighted];
		switchSizeBtn.frame=CGRectMake(screenWidth-switchSizeBtn.frame.size.width, 0, switchSizeBtn.frame.size.width, switchSizeBtn.frame.size.height);
	}else{
		[switchSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgenlarge.png"] forState:UIControlStateNormal];
		[switchSizeBtn setBackgroundImage:[UIImage imageNamed:@"contentui_btn_imgenlarge_i.png"] forState:UIControlStateHighlighted];
		switchSizeBtn.frame=CGRectMake(screenWidth-switchSizeBtn.frame.size.width, 0, switchSizeBtn.frame.size.width, switchSizeBtn.frame.size.height);
	}
}
@end
