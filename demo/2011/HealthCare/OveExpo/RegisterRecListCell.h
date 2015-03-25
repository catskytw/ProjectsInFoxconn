//
//  RegisterListCell.h
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterRecListDataObject.h"
@interface RegisterRecListCell : UITableViewCell{
    
    UIImageView *selectedImg;
    NSString *recordId;
}
@property (nonatomic, retain) NSString* recordId;
@property (retain, nonatomic) IBOutlet UILabel *doctorName;
@property (retain, nonatomic) IBOutlet UILabel *hospitalName;
@property (retain, nonatomic) IBOutlet UIImageView *iconImg;
-(void)setUIDefault;
-(void)setDAO:(RegisterRecListDataObject*)_rdo;
@end
