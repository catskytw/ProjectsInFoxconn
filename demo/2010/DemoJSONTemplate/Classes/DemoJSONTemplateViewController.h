//
//  DemoJSONTemplateViewController.h
//  DemoJSONTemplate
//
//  Created by 廖 晨志 on 2010/12/2.
//  Copyright 2010 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoJSONTemplateViewController : UIViewController {
	UIView *preView;
	NSTimer *timer;
	BOOL hasRunningAnimated;
	
	IBOutlet UIImageView *demoUIImageView;
	IBOutlet UILabel *demoLabel1;
	IBOutlet UILabel *demoLabel2;
	IBOutlet UILabel *demoLabel3;
	IBOutlet UILabel *demoLabel4;
	IBOutlet UIButton *demoButton;
}
@property(nonatomic,retain)UIImageView *demoUIImageView;
@property(nonatomic,retain)UILabel *demoLabel1,*demoLabel2, *demoLabel3, *demoLabel4;
@property(nonatomic,retain)UIButton *demoButton;
-(IBAction)getJSONValue;
-(IBAction)getUIImageValue;
@end

