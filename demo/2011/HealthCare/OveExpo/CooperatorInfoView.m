//
//  ExhibitroInfoViewController.m
//  OveExpo
//
//  Created by Chang Link on 11/9/21.
//  Copyright 2011年 foxconn. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CooperatorInfoView.h"
#import "FcConfig.h"
#import "LocalizationSystem.h"
#import "UITuneLayout.h"
#import "NinePatch.h"
#import "QueryPattern.h"
#import "Tools.h"
#import "CooperatorDataAdaptor.h"
#import "CooperatorDataObject.h"
#import "CooperatorDummyDao.h"
#import "LocalizedCurrentLocation.h"
#import "Tool.h"
#import "FcLocation.h"
#define ContentSpacingVertical 14

@interface CooperatorInfoView(PrivateMethod)
-(void)tuneLabelFrame;
@end
@implementation CooperatorInfoView
@synthesize infoLabel,emailLabel,phoneLabel,addressLabel;
@synthesize contentScroll;
@synthesize seperateImg;
@synthesize nameLabel;
@synthesize websiteBtn;
@synthesize pathGuideBtn;
@synthesize btnBgImg;
@synthesize cooperatorId;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [self initData];
    [super viewDidLoad];
}
-(void)viewDidUnload{
    [website release];
    [super viewDidUnload];
}
#pragma -

#pragma mark - ActionMethod
- (IBAction)goWebSite:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}
-(IBAction)googleRoute:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:USING_LOCATION object:nil];
    NSString *destinationAddress = addressLabel.text;  
    NSString *sourceAddress = [Tool getReGeoCode:[FcLocation nowLocation]];
    NSLog(@"address:%@  destinationAddress:%@",sourceAddress,addressLabel.text);
    NSString *url = [NSString
                     stringWithFormat:@"http://maps.google.com/maps?saddr=%@&daddr=%@",
                     [sourceAddress
                      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                     [destinationAddress
                      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}
#pragma -
#pragma mark - Layout
-(void) setUIDefault{
    [super setUIDefault];
    [self settingBtnStyle:pathGuideBtn];
    [self settingBtnStyle:websiteBtn];
    [pathGuideBtn setTitle:AMLocalizedString(@"pathGuide",nil) forState:UIControlStateNormal];
    [websiteBtn setTitle:AMLocalizedString(@"goWebSite",nil) forState:UIControlStateNormal];
    
    [seperateImg setImage:[TUNinePatchCache imageOfSize:seperateImg.frame.size forNinePatchNamed:@"bg_line"]];
    [btnBgImg setImage:[TUNinePatchCache imageOfSize:btnBgImg.frame.size forNinePatchNamed:@"bg_black"]];
    [self tuneLabelFrame];
    CGSize infoSize = [infoLabel.text sizeWithFont:[UIFont fontWithName:DefaultFontName size:14] constrainedToSize:CGSizeMake(infoLabel.frame.size.width,500000) lineBreakMode:UILineBreakModeWordWrap];
    infoLabel.frame = CGRectMake(infoLabel.frame.origin.x, emailLabel.frame.origin.y+ContentSpacingVertical*2+ emailLabel.frame.size.height+2, infoSize.width, infoSize.height);
    [contentScroll setContentSize:CGSizeMake(contentScroll.frame.size.width, infoLabel.frame.origin.y+infoSize.height)];
}
-(void)tuneLabelFrame{
    NSInteger m_space=22;
    CGSize m_size=[Tools estimateStringSize:nameLabel.text withFontSize:22 withMaxSize:ccs(290, 50000)];
    if(m_size.height>40){
        nameLabel.numberOfLines=2;
        [nameLabel setFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y, nameLabel.frame.size.width, nameLabel.frame.size.height+m_space)];
        phoneLabel.center=ccpAdd(phoneLabel.center, ccp(0, m_space));
        addressLabel.center=ccpAdd(addressLabel.center, ccp(0, m_space));
        emailLabel.center=ccpAdd(emailLabel.center, ccp(0, m_space));
    }
}
#pragma -
#pragma mark - DataControl
-(void) initData{   
    CooperatorDataAdaptor *m_dataAdaptor=[CooperatorDummyDao new];
    CooperatorDataObject *m_tmpObj=[m_dataAdaptor getCooperatorData:cooperatorId];
    [nameLabel setText:m_tmpObj.objName];
    [phoneLabel setText:m_tmpObj.phone];
    [addressLabel setText:m_tmpObj.address];
    [emailLabel setText:m_tmpObj.email];
    website=[[NSString stringWithString:m_tmpObj.webSite] retain];
    [m_dataAdaptor release];
}
#pragma -
@end
