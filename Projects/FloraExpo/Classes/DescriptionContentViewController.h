//
//  DescriptionContentViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionDescriptionObject.h"

@interface DescriptionContentViewController : UIViewController {
	ExhibitionDescriptionObject *thisData;
	
	IBOutlet UILabel *titleLabel;
	IBOutlet UIImageView *picImageView;
	IBOutlet UIView *contentView;
	IBOutlet UITextView *contentText;
	IBOutlet UIButton *changeSizeBtn;
	
	CGAffineTransform originTransform;
	CGAffineTransform afterTransform;
		
	BOOL isBigFlowerImage;
}
@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UIImageView *picImageView;
@property(nonatomic,retain) UITextView *contentText;
@property(nonatomic,retain) UIButton *changeSizeBtn;
@property(nonatomic,retain) UIView *contentView;
-(id)initWithType:(NSInteger)type withKey:(NSString*)key;
-(IBAction)changeImageSizeAnimation:(id)sender;
-(void)setFlowerImageLocation;
@end
