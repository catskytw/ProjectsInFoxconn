//
//  PSListTableViewCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/20.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "PSListTableViewCell.h"
#import "PSListDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
@implementation PSListTableViewCell
@synthesize locationlabel;
@synthesize typeImg;
@synthesize bookingStatusLabel;
@synthesize endTimeLabel;
@synthesize startTimeLabel;
@synthesize nameLabel;
@synthesize bgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setDO:(PSListDataObject*) dao{
    startTimeLabel.text = dao.startTime;
    endTimeLabel.text = dao.endTime;
    locationlabel.text = [NSString stringWithFormat:@"%@%@",AMLocalizedString(@"Location",nil),dao.location];
    nameLabel.text =dao.name;
    //NSLog(@"bookingStatus %@", dao.bookingStatus);
    if ([dao.bookingStatus isEqualToString:@"-"]) {
        bookingStatusLabel.hidden = YES;
    }else{
         bookingStatusLabel.text = dao.bookingStatusName;
    }
    
    if ([SCHEDULE_TYPE_BOOKING isEqualToString: dao.type]) {
        [typeImg setImage:[UIImage imageNamed:@"img_booking_meeting.png"]];
    }else if([SCHEDULE_TYPE_CONFERENCE isEqualToString: dao.type]){
        [typeImg setImage:[UIImage imageNamed:@"img_conference.png"]];
    }else if([SCHEDULE_TYPE_EXHIBITOR isEqualToString: dao.type]){
        [typeImg setImage:[UIImage imageNamed:@"img_exhibitor.png"]];
    }
}
-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 1) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    
    //[bgView setImage:[TUNinePatchCache imageOfSize:bgView.frame.size forNinePatchNamed:@"list_i"]];
    [bookingStatusLabel setTextColor:[UIColor colorWithRed:96/255.f green:194/255.f blue:213/255.f alpha:1]];
    [locationlabel setTextColor:[UIColor colorWithRed:157/255.f green:157/255.f blue:157/255.f alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [selectedImg release];
    [bgView release];
    [nameLabel release];
    [startTimeLabel release];
    [endTimeLabel release];
    [bookingStatusLabel release];
    [typeImg release];
    [locationlabel release];
    [super dealloc];
}
@end
