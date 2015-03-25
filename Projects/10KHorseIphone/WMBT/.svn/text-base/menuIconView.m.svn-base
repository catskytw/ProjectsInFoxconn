//
//  menuIconView.m
//  WMBT
//
//  Created by link on 2011/2/25.
//  Copyright 2011 foxconn. All rights reserved.
//

#import "menuIconView.h"

@implementation menuIconView
@synthesize thumbnailPath;
@synthesize labelText;
@synthesize controller,imgView,label;

- (id)initWithFrame:(CGRect)frame{
	if((self=[super initWithFrame:frame])){
		self.thumbnailPath = @"";
		self.labelText = @"";
		self.controller = nil;
	}
	return self;
} 

- (void)addImage:(NSString*) urlString andLabelTxt:(NSString*) txtString andController:(MainMenuViewController*) viewController{
	thumbnailPath = urlString;
	labelText = txtString;
	controller = viewController;
	if (thumbnailPath!=@"" && labelText !=@"") {
		imgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:thumbnailPath]] autorelease];
		[imgView setImage:[UIImage imageNamed:thumbnailPath]];
		imgView.tag = 100;
	
		//imgView.frame = CGRectMake(0,0,menuIconWidth,menuIconHeight);
		label.text = labelText;
		label.font = [UIFont systemFontOfSize:menuIconTextFont];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:imgView];
		[self addSubview:label];
		
	}
	
}
- (void)setThumbnailPath:(NSString*)urlString{
	thumbnailPath = urlString;
}
- (void)setlabelText:(NSString*)txtString{
	labelText = txtString;
}
- (void)dealloc{
	[thumbnailPath release];
	[labelText release];
	self.controller = nil;
	[super dealloc];
}

// 透過 delegate 觸發事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[controller menuAction:labelText];
	
}

@end
