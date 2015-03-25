//
//  ParkingAreaListCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ParkingAreaListCell : UITableViewCell {
	IBOutlet UILabel *areaNameLabel;
	IBOutlet UILabel *publicLabel;
	IBOutlet UILabel *privateLabel;
}

@property(nonatomic,retain) UILabel *areaNameLabel;
@property(nonatomic,retain) UILabel *publicLabel;
@property(nonatomic,retain) UILabel  *privateLabel;
@end
