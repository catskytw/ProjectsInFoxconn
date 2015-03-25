//
//  FutureTableCell.h
//  FlowerGuide
//
//  Created by Liao Change on 9/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeatureTableCell : UITableViewCell {
	IBOutlet UILabel *title1;
	IBOutlet UIButton *button1;
	IBOutlet UILabel *title2;
	IBOutlet UIButton *button2;
	IBOutlet UILabel *title3;
	IBOutlet UIButton *button3;
	
	UINavigationController *currentNavigationController;
}
@property(nonatomic,retain)UILabel *title1,*title2,*title3;
@property(nonatomic,retain)UIButton *button1,*button2,*button3;
@property(nonatomic,retain)UINavigationController *currentNavigationController;
-(IBAction)buttonAction:(id)sender;
@end
