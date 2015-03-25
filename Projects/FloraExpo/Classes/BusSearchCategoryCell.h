//
//  BusSearchCategoryCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BusSearchCategoryCell : UITableViewCell {
	IBOutlet UILabel *idLabel;
	IBOutlet UIImageView *pic;
	IBOutlet UILabel *busCategory;
}
@property(nonatomic,retain)UIImageView *pic;
@property(nonatomic,retain)UILabel *busCategory;
@property(nonatomic,retain)UILabel *idLabel;
@end
