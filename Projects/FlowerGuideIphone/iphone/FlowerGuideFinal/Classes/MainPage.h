//
//  MainPage.h
//  FlowerGuide
//
//  Created by Change Liao on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#ifdef QRCODE
#import "ZXingWidgetController.h"
#endif
@interface MainPage : BaseViewController <
#ifdef QRCODE
ZXingDelegate,
#endif
UITextFieldDelegate,UIAlertViewDelegate>{
	UIView *preView;
	NSTimer *timer;
	
	UIButton *disableKeyBoardBtn;
	IBOutlet UITextField *thisSearchTextField;
	IBOutlet UIButton *areaButton1;
	IBOutlet UIButton *areaButton2;
	IBOutlet UIButton *areaButton3;
	IBOutlet UIButton *areaButton4;
	IBOutlet UIButton *areaButton5;
	IBOutlet UIButton *areaButton6;
	IBOutlet UIButton *areaButton7;
	IBOutlet UIButton *areaButton8;
	IBOutlet UIButton *areaButton9;
	IBOutlet UIButton *areaButton10;
	IBOutlet UIButton *areaButton11;
	IBOutlet UIButton *areaButton12;
	IBOutlet UIButton *areaButton13;
	NSMutableArray *areaObjectArray;
}
@property(nonatomic,retain)UITextField *thisSearchTextField;
@property(nonatomic,retain)UIButton *areaButton1,*areaButton2,*areaButton3,*areaButton4,*areaButton5,*areaButton6,*areaButton7,*areaButton8,*areaButton9,*areaButton10,*areaButton11,*areaButton12,*areaButton13;
-(IBAction)goFuture:(id)sender;
-(IBAction)closeApp:(id)sender;
-(IBAction)goAboutFuture:(id)sender;
-(IBAction)goFlowerSearch:(id)sender;
-(IBAction)qrCodeScane:(id)sender;
-(IBAction)areaQueryAction:(id)sender;
-(void)enterMapScene:(NSInteger)m_nowPosition;
@end
