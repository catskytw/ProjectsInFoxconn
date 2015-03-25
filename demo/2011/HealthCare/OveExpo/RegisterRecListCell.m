//
//  RegisterListCell.m
//  HealthCare
//
//  Created by Chang Link on 11/11/8.
//  Copyright (c) 2011年 foxconn. All rights reserved.
//

#import "RegisterRecListCell.h"
#import "NinePatch.h"
@implementation RegisterRecListCell
@synthesize doctorName;
@synthesize hospitalName;
@synthesize iconImg;
@synthesize recordId;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [doctorName release];
    [hospitalName release];
    [iconImg release];
    [super dealloc];
}
#pragma -
#pragma mark -  PrivateMethod

-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    [hospitalName setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
}

-(void)setDAO:(RegisterRecListDataObject*)_rdo{
    doctorName.text = [NSString stringWithFormat:@"%@ %@",_rdo.departmentName, _rdo.doctorName]; //cathy要求加科別
    hospitalName.text = _rdo.hospitalName;
    recordId = _rdo.recordId;
    if (_rdo.status == 0) {
         [iconImg setImage:[UIImage imageNamed:@"ic_addtoschedule.png"]];
    }else if (_rdo.status == 1){
        [iconImg setImage:[UIImage imageNamed:@"ic_addtoschedule_check.png"]];
    }
}

@end
