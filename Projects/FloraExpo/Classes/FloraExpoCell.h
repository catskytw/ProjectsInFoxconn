//
//  FloraExpoCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 6/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FloraExpoCell : UITableViewCell {
	IBOutlet UIImageView *icon;
	IBOutlet UILabel *stringLabel;
}
@property(nonatomic,retain)UIImageView *icon;
@property(nonatomic,retain)UILabel *stringLabel;
@end
