//
//  MyFavoriteBusCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyFavoriteBusCell : UITableViewCell {
	IBOutlet UILabel *stationName;
	IBOutlet UILabel *busLineName;
	IBOutlet UILabel *timeLabel;
	IBOutlet UIImageView *busLinePic;
}
@property(nonatomic,retain) UILabel *stationName;
@property(nonatomic,retain) UILabel *busLineName;
@property(nonatomic,retain) UILabel *timeLabel;
@property(nonatomic,retain) UIImageView *busLinePic;
@end
