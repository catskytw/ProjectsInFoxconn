//
//  MyLifeSearchResultCell.h
//  FloraExpo2010
//
//  Created by Change Liao on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyLifeSearchResultCell : UITableViewCell {
	IBOutlet UILabel *name;
	IBOutlet UILabel *address;
	IBOutlet UILabel *teletphone;
	IBOutlet UILabel *key;
}
@property(nonatomic,retain)UILabel *name;
@property(nonatomic,retain)UILabel *address;
@property(nonatomic,retain)UILabel *teletphone;
@property(nonatomic,retain)UILabel *key;
@end
