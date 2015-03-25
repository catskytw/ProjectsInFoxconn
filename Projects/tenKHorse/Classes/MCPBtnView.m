//
//  MainCategoryPictureButton.m
//  TenKHorse
//
//  Created by 廖 晨志 on 2011/6/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "MCPBtnView.h"


@implementation MCPBtnView
@synthesize categoryImage,frameImage,btn,categoryName,gradientImage;

- (void)dealloc
{
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)setRotation:(NSInteger)rotateAngle{
    self.transform=CGAffineTransformMakeRotation( ( rotateAngle * M_PI ) / 180 );
}
@end
