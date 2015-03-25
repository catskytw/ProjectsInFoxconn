//
//  AboutFutureMainPageCell.h
//  FlowerGuide
//
//  Created by Liao Change on 9/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutFutureMainPageCell : UITableViewCell {
	IBOutlet UILabel *contentLabel;
	IBOutlet UIImageView *contentImageView;
}
@property(nonatomic,retain)UILabel *contentLabel;
@property(nonatomic,retain)UIImageView *contentImageView;
@end
