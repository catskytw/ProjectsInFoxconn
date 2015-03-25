//
//  ExhibitorEventCell.h
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitorEventDatoObject.h"
@interface ExhibitorEventCell : UITableViewCell{
    UILabel *titleLabel;
    UILabel *attenderLabel;
    UIImageView *checkImg;
    UIImageView *selectedImg;
    NSString *eventId;
    UIButton *admitBtn;
    
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *attenderLabel;
@property (nonatomic, retain) IBOutlet UIImageView *checkImg;
@property (nonatomic, retain)NSString *eventId;
@property (nonatomic, retain) IBOutlet UIButton *admitBtn;
-(void)setUIDefault;
-(void)setDO:(ExhibitorEventDatoObject*) dao;
@end
