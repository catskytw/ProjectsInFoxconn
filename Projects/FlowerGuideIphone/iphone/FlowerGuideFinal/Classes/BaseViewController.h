//
//  BaseViewController.h
//  FlowerGuide
//
//  Created by Change Liao on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController {
	/*greenBarView,下方綠色Bar
	  viewPortView,中央主要顯示之View
	 */
	IBOutlet UIImageView *systemBarView;
	IBOutlet UIImageView *greenBarView;
	IBOutlet UIView *viewPortView;
	IBOutlet UILabel *titleLabel;
	//分別由左至右之五個按鍵
	IBOutlet UIButton *leftBtn;
	IBOutlet UIButton *leftMedBtn;
	IBOutlet UIButton *medBtn;
	IBOutlet UIButton *rightMedBtn;
	IBOutlet UIButton *rightBtn;
	IBOutlet UIButton *rightUpBtn;
	
	IBOutlet UIImageView *batteryImage;
	IBOutlet UILabel *timeLabel;
	
	NSTimer *systembarTimer;
}
@property(nonatomic,retain) UIButton *leftBtn,*leftMedBtn,*medBtn,*rightBtn,*rightMedBtn,*rightUpBtn;
@property(nonatomic,retain) UIImageView *greenBarView,*batteryImage;
@property(nonatomic,retain) UIView *viewPortView,*systemBarView;
@property(nonatomic,retain) UILabel *titleLabel,*timeLabel;
-(IBAction)leftBtnAction:(id)sender;
-(IBAction)rightBtnAction:(id)sender;
-(IBAction)leftMidBtnAction:(id)sender;
-(IBAction)rightMidBtnAction:(id)sender;
-(IBAction)MidBtnAction:(id)sender;
-(IBAction)rightUpBtnAction:(id)sender;
-(void)baseViewControllerSetting;
-(void)updateSystemInfo;
@end