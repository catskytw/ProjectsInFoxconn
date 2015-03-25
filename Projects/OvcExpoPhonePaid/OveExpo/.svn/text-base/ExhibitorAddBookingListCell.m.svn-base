//
//  ExhibitorAddBookingListCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/26.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorAddBookingListCell.h"
#import "NinePatch.h"
#import "DateUtilty.h"
@implementation ExhibitorAddBookingListCell
@synthesize noteLabel;
@synthesize title;
@synthesize reserveId;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    [noteLabel setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];
}
-(void)setDO:(ExhibitorAddBookingListDataObject*) dao{
    title.text  = [NSString stringWithFormat:@"%@ - %@",[DateUtilty timeString:dao.startDate],[DateUtilty timeString:dao.endDate]];
    noteLabel.text = dao.note;
    reserveId = dao.reserveId;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [title release];
    [noteLabel release];
    [super dealloc];
}
@end
