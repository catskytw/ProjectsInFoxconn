//
//  DistanceCare.m
//  HealthCare
//
//  Created by Liao Chen-chih on 2011/11/9.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "DistanceCareViewController.h"
#import "DistanceCareDataAdaptor.h"
#import "DistanceCareDummyData.h"
#import "UITuneLayout.h"
#import "LocalizationSystem.h"
#import "NinePatch.h"
#import "Tool.h"
@interface DistanceCareViewController(PrivateMethod)
-(void)fetchData;
@end

@implementation DistanceCareViewController
@synthesize contentText,phoneBtn,btnBackground,lineImage;
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [self fetchData];
    [super viewDidLoad];
}
- (void)viewDidUnload
{
    [dao release];
    [phoneNumber release];
    [super viewDidUnload];
}
#pragma -
#pragma mark - DelegateMethod
#pragma -
#pragma mark - ActionMethod
//撥打專線
-(IBAction)callPhoneNumber:(id)sender{
    [Tool makePhoneCall:phoneNumber];
}
#pragma -
#pragma mark - Layout
-(void)setUIDefault{
    [super setUIDefault];
    [contentText setText:dao.contentText];
    [phoneBtn setTitle:AMLocalizedString(@"callPhone", nil) forState:UIControlStateNormal];
    [self settingBtnStyle:phoneBtn];
    [btnBackground setImage:[TUNinePatchCache imageOfSize:btnBackground.frame.size forNinePatchNamed:@"bg_black"]];
    [lineImage setImage:[TUNinePatchCache imageOfSize:lineImage.frame.size forNinePatchNamed:@"bg_line"]];
}
#pragma -
#pragma mark - DataControl
-(void)fetchData{
    DistanceCareDataAdaptor *dataAdaptor=[DistanceCareDummyData new];
    dao=[[dataAdaptor fetchDistanceCareData] retain];
    phoneNumber=[[NSString stringWithString:dao.phoneNumber] retain];
    [dataAdaptor release];
}
#pragma -
#pragma mark - PrivateMethod
#pragma -
@end
