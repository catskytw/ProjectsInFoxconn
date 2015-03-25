//
//  FlowerContentViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowerContentObject.h"
#import "FlowerContent.h"
@interface FlowerContentViewController : UIViewController {
	IBOutlet UILabel *titleLabel;
	IBOutlet UIView *mainView;
	FlowerContentObject *thisDataObject;
	FlowerContent *flowerContentView;
}
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIView *mainView;

-(id)initWithFlowerId:(NSString*)flowerId;
-(IBAction)closeThisWindow:(id)sender;
-(void)resetImageStyle:(NSNotification*)notification;
@end
