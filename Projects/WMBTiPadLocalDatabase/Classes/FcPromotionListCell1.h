//
//  FcPromotionListCell1.h
//  ipadTestProject
//
//  Created by 廖 晨志 on 2011/1/27.
//  Copyright 2011 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FcPromotionListCell1 : UITableViewCell {
	NSString *key;
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *descriptionLabel;
	IBOutlet UILabel *subLabelLeft,*subLabelRight;
    IBOutlet UILabel *detailLabel;
}
@property(nonatomic,retain)NSString *key;
@property(nonatomic,retain)UILabel *titleLabel,*descriptionLabel,*subLabelLeft,*subLabelRight,*detailLabel;
@end
