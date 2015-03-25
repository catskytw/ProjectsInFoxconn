//
//  PopWindows1.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/27.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PopWindows1 : UIViewController {
	IBOutlet UIImageView *titleBackgroundView;
	IBOutlet UIImageView *mainAreaBackgroundView;
	
	IBOutlet UIScrollView *contentScrollView;
	IBOutlet UIButton *closeBtn;
	
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *slogonLabel;
	IBOutlet UILabel *rightCommentLabel;
	IBOutlet UILabel *placeLabel;
	IBOutlet UILabel *briefLabel;
	IBOutlet UILabel *contentLabel;
@private
	NSInteger startYPosition;
	NSString *myKey;
}
@property(nonatomic,retain)UIImageView *titleBackgroundView,*mainAreaBackgroundView;
@property(nonatomic,retain)UILabel *titleLabel,*slogonLabel,*rightCommentLabel;
@property(nonatomic,retain)UILabel *placeLabel,*briefLabel,*contentLabel;
@property(nonatomic,retain)UIScrollView *contentScrollView;
@property(nonatomic,retain)UIButton *closeBtn;
-(id)initWithKey:(NSString*)key;
-(IBAction)closeBtnAction:(id)sender;
-(void)loadData:(NSString*)key;
@end
