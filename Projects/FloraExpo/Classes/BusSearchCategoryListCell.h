//
//  BusSearchCategoryListCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BusSearchCategoryListCell : UITableViewCell {
	IBOutlet UILabel *lineIdLabel;
	IBOutlet UILabel *busLineName;
	IBOutlet UILabel *busLineDescription;
	IBOutlet UIImageView *lineCategoryImageView;
}
@property(nonatomic,retain)UILabel *lineIdLabel;
@property(nonatomic,retain)UILabel *busLineName;
@property(nonatomic,retain)UILabel *busLineDescription;
@property(nonatomic,retain)UIImageView *lineCategoryImageView;
@end
