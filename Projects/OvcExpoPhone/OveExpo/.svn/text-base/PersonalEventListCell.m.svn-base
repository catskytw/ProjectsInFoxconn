//
//  PersonalEventListCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PersonalEventListCell.h"
#import "PSListDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
#import "DateUtilty.h"
@implementation PersonalEventListCell
@synthesize titleLabel;
@synthesize dateLabel;
@synthesize checkImg;

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
-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    [dateLabel setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
    //[bgView setImage:[TUNinePatchCache imageOfSize:bgView.frame.size forNinePatchNamed:@"list_i"]];
}

-(void)setDO:(PSListDataObject*) dao{
    titleLabel.text = dao.name;
    dateLabel.text = [NSString stringWithFormat:@"%@",[DateUtilty timeSectionString:dao.startTime withEndTime:dao.endTime]];
    if ([dao.type isEqual:[NSNull null]]) {
        //[checkImg setImage:[UIImage imageNamed:@"ic_addtoschedule.png"]];
    }else{
        if ([dao.type isEqualToString:@"AP"]) {
            [checkImg setImage:[UIImage imageNamed:@"ic_addtoschedule.png"]];
        
        }else if( [dao.type isEqualToString:@"CP"]){
            [checkImg setImage:[UIImage imageNamed:@"ic_addtoschedule_check.png"]];
       
        }
    }
}

- (void)dealloc {
    [selectedImg release];
    [titleLabel release];
    [dateLabel release];
    [checkImg release];
    [super dealloc];
}
@end
