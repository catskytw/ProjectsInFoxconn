//
//  AttendanceFunCell.h
//  MobileOffice
//
//  Created by Liao Chen-chih on 2011/9/14.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FcTableCellStyle1.h"
@interface AttendanceFunCell : FcTableCellStyle1{
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *funImage;
    
    IBOutlet UIImageView *seperateImgView;
    IBOutlet UIImageView *selectedImg;
}
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UIImageView *funImage,*seperateImgView,*selectedImg;
-(void)setDO:(NSString*)name;
@end
