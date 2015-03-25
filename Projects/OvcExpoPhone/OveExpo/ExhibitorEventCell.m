//
//  ExhibitorEventCell.m
//  OveExpo
//
//  Created by Chang Link on 11/9/27.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "ExhibitorEventCell.h"
#import "PSListDataObject.h"
#import "NinePatch.h"
#import "LocalizationSystem.h"
#import "FcConfig.h"
@implementation ExhibitorEventCell
@synthesize titleLabel;
@synthesize attenderLabel;
@synthesize checkImg;
@synthesize eventId;
@synthesize admitBtn;
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
    self.admitBtn.selected = NO;
    // If you don't set highlighted to NO in this method,
    // for some reason it'll be highlighed while the 
    // table cell selection animates out
    self.admitBtn.highlighted = NO;
    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.admitBtn.highlighted = NO;
}

-(void) setUIDefault{
    UIImageView *seperateImg = [UIImageView new];
    [seperateImg setImage:[TUNinePatchCache imageOfSize:CGSizeMake(self.frame.size.width, 2) forNinePatchNamed:@"bg_line"]];
    seperateImg.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 2);
    [self addSubview:seperateImg];
    [seperateImg release];
    selectedImg = [[UIImageView alloc]initWithImage:[TUNinePatchCache imageOfSize:self.frame.size forNinePatchNamed:@"list_i"]];
    self.selectedBackgroundView = selectedImg;
    admitBtn.titleLabel.font = [UIFont fontWithName:DefaultFontName size:14.0f];
    [admitBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:admitBtn.frame.size forNinePatchNamed:@"btn_content"] forState:UIControlStateNormal];
    [admitBtn setBackgroundImage:
     [TUNinePatchCache imageOfSize:admitBtn.frame.size forNinePatchNamed:@"btn_content_i"] forState:UIControlStateHighlighted];
	//[admitBtn addTarget:self action:@selector(admitAction:) forControlEvents:UIControlEventTouchUpInside];

    [admitBtn setTitle:AMLocalizedString(@"admit",nil) forState:UIControlStateNormal];
    [admitBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
    [attenderLabel setTextColor:[UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1]];

}

-(void)setDO:(ExhibitorEventDatoObject*) dao{
    titleLabel.text = dao.title;
    eventId = dao.eventId;
    attenderLabel.text = [NSString stringWithFormat:@"%@ %@",dao.attender, dao.mobile];
    if ([dao.status isEqualToString:@"RP"]) {
        [checkImg setImage:[UIImage imageNamed:@"ic_addtoschedule.png"]];
        [admitBtn setTitle:AMLocalizedString(@"admit",nil) forState:UIControlStateNormal];
        admitBtn.enabled = YES;
    }else if([dao.status isEqualToString:@"CP"]){
        [checkImg setImage:[UIImage imageNamed:@"ic_addtoschedule_check.png"]];
         [admitBtn setTitle:AMLocalizedString(@"admited",nil) forState:UIControlStateNormal];
         admitBtn.enabled = NO;
    }
    
}

- (void)dealloc {
    [selectedImg release];
    [titleLabel release];
    [attenderLabel release];
    [checkImg release];
    [admitBtn release];
    [super dealloc];
}

@end
