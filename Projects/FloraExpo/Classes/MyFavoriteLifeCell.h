//
//  MyFavoriteList.h
//  FloraExpo2010
//
//  Created by Change Liao on 9/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyFavoriteLifeCell : UITableViewCell {
	IBOutlet UILabel *name;
	IBOutlet UILabel *address;
	IBOutlet UILabel *tel;
}
@property(nonatomic,retain)UILabel *name,*address,*tel;
@end
