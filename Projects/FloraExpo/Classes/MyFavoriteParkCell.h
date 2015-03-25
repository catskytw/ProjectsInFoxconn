//
//  MyFavoriteParkCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyFavoriteParkCell : UITableViewCell {
	IBOutlet UILabel *parkName;
	IBOutlet UILabel *desc;
	IBOutlet UILabel *space;
	IBOutlet UIImageView *preImage;
}
@property(nonatomic,retain)UILabel *parkName,*desc,*space;
@property(nonatomic,retain)UIImageView *preImage;
@end
