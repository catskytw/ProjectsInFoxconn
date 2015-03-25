//
//  MyLifeDescriptionContentView.m
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyLifeDescriptionContentView.h"
#import "MyLifeDescriptionViewController.h"
#import "MyLifeModel.h"
#import "Tools.h"
@implementation MyLifeDescriptionContentView
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"DescriptionContentViewController" bundle:nibBundleOrNil]) {
	}
    return self;
}
-(id)initWithStoreKey:(NSString*)storeKey{
	if((self=[super init])){
		thisDataObject=[[MyLifeModel getMyLifeDetailInformation:storeKey]retain];
		mc=[[MyLifeDescriptionViewController alloc]initWithDataObject:thisDataObject];
	}
	return self;
}
- (void)viewWillAppear:(BOOL)animated {
	[picImageView setContentMode:UIViewContentModeScaleToFill];
	//[picImageView setFrame:CGRectMake(200, 0, 100, 74)];
	[picImageView setBackgroundColor:[UIColor whiteColor]];
	mc.parentViewController=self;
	originTransform=CGAffineTransformMakeScale((CGFloat)1, (CGFloat)1);
	afterTransform=CGAffineTransformMakeScale((CGFloat)2.8,(CGFloat)2.8);
	isBigFlowerImage=NO;
	[self.navigationItem setTitle:thisDataObject.storeName];
	[titleLabel setText:thisDataObject.categoryName];
	[contentText removeFromSuperview];
	[contentView setFrame:CGRectMake(0, contentView.frame.origin.y, contentView.frame.size.width, contentView.frame.size.height)];
	[contentView addSubview:mc.thisScrollView];
	//TODO thread download
	[Tools getImageFromURL:thisDataObject.storePicName withTargetUIImageView:picImageView];
}

-(void)dealloc{
	[thisDataObject release];
	[mc release];
	[super dealloc];
}
@end
