//
//  TrainListCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 7/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrainListCell : UITableViewCell {
	IBOutlet UIImageView *categoryImageView;
	IBOutlet UILabel *name;
	IBOutlet UILabel *brief;
	IBOutlet UILabel *duration;
	IBOutlet UILabel *trainId;
}
@property(nonatomic,retain)UIImageView *categoryImageView;
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *brief;
@property(nonatomic,retain)UILabel *duration;
@property(nonatomic,retain)UILabel *trainId;
@end
