//
//  MyLifeSearchViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyLifeSearchViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate>{
	IBOutlet UITextField *area;
	IBOutlet UITextField *category;
	UIAlertView *alert;
	
	NSString *mainKey;
	NSString *subKey;
	NSString *districtKey;
}
@property(nonatomic,retain)NSString *mainKey;
@property(nonatomic,retain)NSString *subKey;
@property(nonatomic,retain)NSString *districtKey;

@property(nonatomic,retain)UITextField *area;
@property(nonatomic,retain)UITextField *category;

-(IBAction)selectArea:(id)sender;
-(IBAction)selectCategory:(id)sender;
@end
