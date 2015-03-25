//
//  DirectionArrowViewController.h
//  FlowerGuide
//
//  Created by Liao Change on 9/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DirectionArrowViewController : UIViewController {
	IBOutlet UIView *mainView;
	NSDictionary *arrowContentArray;
}
@property(nonatomic,retain)UIView *mainView;
-(void)drawDirectionArrow:(CGRect)rangRect withStandingPosition:(CGPoint)standPoint;
-(IBAction)closeThisView:(id)sender;
-(IBAction)pressArrow:(id)sender;
@end
