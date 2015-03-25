//
//  CooperatorCategoryListCell.h
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/8.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CooperatorCategoryListCell : UITableViewCell{
    IBOutlet UILabel *contentLabel;
    UIImageView *selectedImg;
    NSString *name;
}
@property (nonatomic, retain)IBOutlet UILabel *contentLabel;
-(void)setUIDefault;
@end