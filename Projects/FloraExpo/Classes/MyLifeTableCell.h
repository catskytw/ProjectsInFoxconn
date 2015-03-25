//
//  MyLifeTableCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyLifeTableCell : UITableViewCell {
	IBOutlet UILabel *objectName;
	IBOutlet UIImageView *objectImage;
}
@property(nonatomic,retain)UILabel *objectName;
@property(nonatomic,retain)UIImageView *objectImage;
@end
