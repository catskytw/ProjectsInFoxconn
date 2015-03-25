//
//  menuIconView.h
//  WMBT
//
//  Created by link on 2011/2/25.
//  Copyright 2011 foxconn. All rights reserved.
//
#import "MainMenuViewController.h"
#import <UIKit/UIKit.h>
#

@interface menuIconView : UIView {
	NSString *thumbnailPath;
	NSString *labelText;
	MainMenuViewController *controller;
	IBOutlet UIImageView *imgView;
	IBOutlet UILabel *label;
}
- (void)setThumbnailPath:(NSString*)urlString;
- (void)setlabelText:(NSString*)txtString;
- (void)addImage:(NSString*) urlString andLabelTxt:(NSString*) txtString andController:(MainMenuViewController*) controller;
@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UILabel *label;
@property(copy) NSString *thumbnailPath;
@property(copy) NSString *labelText;
@property(nonatomic,retain) MainMenuViewController *controller;
@end
