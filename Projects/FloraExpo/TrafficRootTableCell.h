//
//  TrafficRootTableCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrafficRootTableCell : UITableViewCell {
	IBOutlet UIImageView *myImage;
	IBOutlet UILabel *titleLabel;
}
@property(nonatomic,retain)UIImageView *myImage;
@property(nonatomic,retain)UILabel *titleLabel;
@end
