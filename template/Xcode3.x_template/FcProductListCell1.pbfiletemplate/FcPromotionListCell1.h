//
//  FcPromotionListCell1.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/27.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FcPromotionListCell1 : UITableViewCell {
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *descriptionLabel;
	IBOutlet UILabel *subLabelLeft,*subLabelRight;
}
@property(nonatomic,retain)UILabel *titleLabel,*descriptionLabel,*subLabelLeft,*subLabelRight;
@end
