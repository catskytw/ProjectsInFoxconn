//
//  SearchCellViewController.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchCellViewController : UITableViewCell {
	IBOutlet UILabel *settingLabel;
	IBOutlet UISwitch *settingSwitch;
	IBOutlet UILabel *hiddenLabel;
}
@property(nonatomic,retain)UILabel *settingLabel;
@property(nonatomic,retain)UISwitch *settingSwitch;
@property(nonatomic,retain)UILabel *hiddenLabel;
@end
