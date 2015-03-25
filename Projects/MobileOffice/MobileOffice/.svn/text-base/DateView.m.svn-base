//
//  DateView.m
//  MobileOffice
//
//  Created by 廖 晨志 on 2011/8/23.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import "DateView.h"
#import "FcConfig.h"

@implementation DateView
@synthesize dayLabel,monthLabel,fc_radian;
-(id)initWithDay:(NSString*)day withMonth:(NSString*)month{
    if((self=[super init])){
        _day=day;
        _month=month;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.dayLabel setText:_day];
    [self.monthLabel setText:_month];
}
-(void)caculateXYFromRadian{
    CGFloat radius=_WIDTH+15.0f;
    CGPoint loc=CGPointMake(sin((double)self.fc_radian)*radius,cos((double)self.fc_radian)*radius);
    CGPoint real_loc=ccpAdd(CGPointMake(50, 29), ccp(loc.x, _WIDTH-loc.y));
    self.view.center=real_loc;
}
@end
