//
//  SignOffNameListCell.h
//  MobileOffice
//
//  Created by Chang Link on 11/9/5.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcTableCellStyle2.h"
#import "SignOffNameListCellDO.h"
#import "FcConfig.h"
@interface SignOffNameListCell: FcTableCellStyle2{
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *uncheckImgView;
    IBOutlet UIImageView *checkImgView;
    IBOutlet UIImageView *seperateImgView;
    IBOutlet UIButton *checkedBtn;
    BOOL bChecked;
    NSString* sTaskId;
    BOOL bNull;
}
@property (nonatomic, retain)  UIImageView *uncheckImgView;
@property (nonatomic, retain)  UIImageView *checkImgView;
@property (nonatomic, retain)  UIButton *checkedBtn;
@property (nonatomic, retain)  UIImageView *seperateImgView;
@property (nonatomic, retain)  UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *typenameLabel;
-(void)setDO:(SignOffNameListCellDO*)cellDO;
-(IBAction)check:(id)sender;
-(NSString*)flowTypeName:(FlowTypeEnum)flowEnum;
-(NSString*)addFlowTypeName:(NSString*)name FlowEnum:(FlowTypeEnum)flowEnum;
@end
